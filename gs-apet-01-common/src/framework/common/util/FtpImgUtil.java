package framework.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FtpImgUtil {

	private Properties bizConfig;
	
	private NhnObjectStorageUtil nhnObjectStorageUtil;

	/**
	 * sftp session
	 */
	private Session session = null;

	/**
	 * sftp channel
	 */
	private Channel channel = null;

	/**
	 * sftp channelSftp
	 */
	private ChannelSftp ftp = null;

	private void disconnect() {
		if (session != null) {
			session.disconnect();
		}
		if (channel != null) {
			channel.disconnect();
		}
		if (ftp != null) {
			ftp.disconnect();
		}
	}

	private void connect() {
		JSch jsch = new JSch();
		String id = bizConfig.getProperty("sftp.image.id");
		String pwd = bizConfig.getProperty("sftp.image.pwd");
		String host = bizConfig.getProperty("sftp.image.host");
		Integer port = Integer.parseInt(bizConfig.getProperty("sftp.image.port", "22"));
		
		try {
			session = jsch.getSession(id, host, port);
			session.setPassword(pwd);

			Properties config = new Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			session.connect();

			channel = this.session.openChannel("sftp");
			channel.connect();
			ftp = (ChannelSftp) channel;
		} catch (JSchException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			if (session != null) {
				session.disconnect();
			}
			if (channel != null) {
				channel.disconnect();
			}
			if (ftp != null) {
				ftp.disconnect();
			}
			throw new CustomException(ExceptionConstants.ERROR_FTP_CONNECT);
		}
	}

	public FtpImgUtil() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		bizConfig = (Properties) wContext.getBean("bizConfig");
		nhnObjectStorageUtil = (NhnObjectStorageUtil) wContext.getBean("nhnObjectStorageUtil");
	}

	public FtpImgUtil(Properties bizConfig) {
		this.bizConfig = bizConfig;
	}

	public boolean tempFileCheck(String filePath) {
		boolean result = false;

		if (StringUtil.isNotEmpty(filePath)) {
			String tempPath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH;

			if (filePath.indexOf(tempPath) > -1) {
				result = true;
			}
		}
		return result;
	}

	public String uploadFilePath(String orgFileStr, String filePath) {
		// 보안 진단 관련 check
		filePath = StringUtils.replace(filePath, "..", StringUtils.EMPTY);		
		String newFileName = FilenameUtils.getName(orgFileStr);
		return filePath + FileUtil.SEPARATOR + newFileName;
	}

	public void upload(String orgFileStr, String newFileStr) {

		// upload(orgFileStr, newFileStr, StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL) ? false : true);
		// SFTP 접속 불가
		upload(orgFileStr, newFileStr, true, true);
	}
	
	public void upload(String orgFileStr, String newFileStr, boolean remove) {

		// upload(orgFileStr, newFileStr, StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL) ? false : true);
		// SFTP 접속 불가
		upload(orgFileStr, newFileStr, true, remove);
	}

	public void upload(String orgFileStr, String newFileStr, boolean isNas, boolean remove) {
		// 보안 진단 관련 check
		orgFileStr = StringUtils.replace(orgFileStr, "..", StringUtils.EMPTY);
		if (!orgFileStr.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
			throw new CustomException(ExceptionConstants.ERROR_FILE_ACCESS_PERMISSION);
		}
		
		//보안 진단관련 replace 처리
		newFileStr = newFileStr.replaceAll("\\.{2,}[/\\\\]", "");

		if (StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
			nhnObjectStorageUtil.upload(orgFileStr, newFileStr);
			if (remove) {
				File orgFile = new File(orgFileStr);
				orgFile.delete();
			}
		} else {
			if (isNas) {
				
				try {
					File orgFile = new File(orgFileStr);
					log.error("imageUtil path : {}", bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + newFileStr);
					File targetFile = new File(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + newFileStr);
					log.error("imageUtil targetFile path : {}", targetFile.getPath());
					
					if (!targetFile.getParentFile().exists()) {
						targetFile.getParentFile().mkdirs();
						if(!targetFile.getParentFile().setReadable(true, false)){
							log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
						}
						if(!targetFile.getParentFile().setExecutable(true, false)){
							log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
						}
					}
					if (remove) {
						FileUtil.move(orgFile, targetFile);
					} else {
						FileUtil.copy(orgFile, targetFile);
					}
					if(!targetFile.setReadable(true, false)){
						log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
					}
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_NAS_COPY);
				}
				
			} else {
				// ftp 연결
				connect();
				String dir = bizConfig.getProperty("sftp.image.base.dir");
				
				String newFilePath = FilenameUtils.getPath(newFileStr);
				String newFileName = FilenameUtils.getName(newFileStr);
				
				try {
					ftp.cd(dir);
				} catch (SftpException e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					disconnect();
					throw new CustomException(ExceptionConstants.ERROR_FTP_FILEPATH);
				}
				
				String[] arrFilePath = newFilePath.split(FileUtil.SEPARATOR);
				if (arrFilePath != null && arrFilePath.length > 0) {
					for (String path : arrFilePath) {
						try {
							ftp.mkdir(path);
							ftp.cd(path);
						} catch (SftpException e) {
							try {
								ftp.cd(path);
							} catch (SftpException e1) {
								//보안성 진단. 오류메시지를 통한 정보노출
								//e1.printStackTrace();
								log.error("##### SftpException When ftp img upload", e1.getClass());
								disconnect();
								throw new CustomException(ExceptionConstants.ERROR_FTP_FILEPATH);
							}
						}
					}
				} else {
					disconnect();
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				try(FileInputStream in = new FileInputStream(orgFileStr)) {				
					ftp.put(in, newFileName);
				} catch (FileNotFoundException | SftpException e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					disconnect();
					throw new CustomException(ExceptionConstants.ERROR_FTP_FILE);
				} catch (IOException e1) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e1);
					disconnect();
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				} finally {				
					disconnect();
				}
			}
		}

	}

	public String goodsImgUpload(String orgFileStr) {

		return goodsImgUpload(orgFileStr, !StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL));
	}

	public String goodsImgUpload(String orgFileStr, boolean isNas) {
		String newFileStr = FileUtil.SEPARATOR + orgFileStr.substring(orgFileStr.indexOf("goods"));
		
		//보안 진단관련 replace 처리
		newFileStr = newFileStr.replaceAll("\\.{2,}[/\\\\]", "");
				
		// nas 아니어도 share dir에 파일 복사 하자.
//		isNas = true;
//		if (isNas) {
			try {
				File orgFile = new File(orgFileStr);
				File targetFile = new File(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + newFileStr);

				if (!targetFile.getParentFile().exists()) {
					targetFile.getParentFile().mkdirs();
					if(!targetFile.getParentFile().setReadable(true, false)){
						log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
					}
					if(!targetFile.getParentFile().setExecutable(true, false)){
						log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
					}
				}
				FileUtil.copy(orgFile, targetFile);
				if(!targetFile.setReadable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}
				log.info("FtpImgUtil.java copy finish : from "+ orgFile.getAbsolutePath() +" to "+ targetFile.getAbsolutePath());

			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_NAS_COPY);
			}
//		}
		
		return newFileStr;

	}

	public Boolean goodsImgCopy(String orgFileStr, String targetFileStr, boolean isNas) {
		try {
			File orgFile = new File(orgFileStr);
			File targetFile = new File(targetFileStr);

			if (!targetFile.getParentFile().exists()) {
				targetFile.getParentFile().mkdirs();
				if(!targetFile.getParentFile().setReadable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}
				if(!targetFile.getParentFile().setExecutable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}
			}
			FileUtil.copy(orgFile, targetFile);
			if(!targetFile.setReadable(true, false)){
				log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
			}
			log.info("FtpImgUtil.java copy finish : from "+ orgFile.getAbsolutePath() +" to "+ targetFile.getAbsolutePath());

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_NAS_COPY);
		}

		return true;

	}

	public String download(String downFileStr) {
		return download(downFileStr, true);
	}

	public String download(String downFileStr, boolean isNas) {

		// 보안 진단 관련 replace 처리
		downFileStr = StringUtils.replace(downFileStr, "..", StringUtils.EMPTY);
		
		//보안 진단관련 replace 처리
		downFileStr = downFileStr.replaceAll("\\.{2,}[/\\\\]", "");

		try {

			File orgFile = new File(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + downFileStr);

			String newFilePath = bizConfig.getProperty("common.file.download.base") + FileUtil.SEPARATOR + DateUtil.getNowDate() + FileUtil.SEPARATOR;
			String newFileName = FilenameUtils.getName(downFileStr);
			File targetFile = new File(newFilePath + newFileName);

			if (!targetFile.getParentFile().exists()) {
				targetFile.getParentFile().mkdirs();
				if(!targetFile.getParentFile().setReadable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}
				if(!targetFile.getParentFile().setExecutable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}
			}
			FileUtil.copy(orgFile, targetFile);
			if(!targetFile.setReadable(true, false)){
				log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
			}

			return newFilePath + newFileName;

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_NAS_COPY);
		}
	}
	
	public void delete(String delFileStr) {
		log.info("################ FtpImgUtil 누가 삭제를 하는가1 ################");
		log.info("################ {} ################",delFileStr);
		delete(delFileStr, !StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL));
	}

	/**
	 * <pre>Ftp 파일 삭제</pre>
	 * 
	 * @param fileStr
	 * @param isNas
	 */
	public void delete(String delFileStr, boolean isNas) {
		log.info("################ FtpImgUtil 누가 삭제를 하는가2 ################");
		log.info("################ {} ################",delFileStr);

		// 보안 진단 관련 replace 처리
		delFileStr = StringUtils.replace(delFileStr, "..", "");

		if (isNas) {
			try {
				FileUtil.delete(delFileStr);

			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_NAS_DELETE);
			}

		} else {
			// ftp 연결
			connect();
			String dir = bizConfig.getProperty("sftp.image.base.dir");
			
			String oldFilePath = FilenameUtils.getPath(delFileStr);
			String newFileName = FilenameUtils.getName(delFileStr);

			try {
				ftp.cd(dir);
				ftp.cd(oldFilePath);
			} catch (SftpException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				disconnect();
				throw new CustomException(ExceptionConstants.ERROR_FTP_FILEPATH);
			}

			try {
				ftp.rm(newFileName);
			} catch (SftpException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				disconnect();
				throw new CustomException(ExceptionConstants.ERROR_FTP_FILE);
			} finally {				
				disconnect();
			}
		}
	}
	
	public void deleteTempFolders() {
		String tempPath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR;
		String today = DateUtil.getNowDate();
		String yesterday = DateUtil.addDay(today, "yyyyMMdd", -1);
		File folder = new File(tempPath);
	    try {
	    	if(folder.exists()){
				File[] folderList = folder.listFiles(); //파일리스트 얻어오기
				for (int i = 0; i < folderList.length; i++) {
					String foldPath = folderList[i].getPath();
					if(foldPath.indexOf(today) == -1 && foldPath.indexOf(yesterday) == -1) {
						File[] fileList = folderList[i].listFiles();
						for (int j = 0; j < fileList.length ; j++) {
							fileList[j].delete();
						}
						folderList[i].delete();
						log.debug("삭제 : i["+i+"]:"+folderList[i].getPath());
					}
				}
	    	}
	    } catch (Exception e) {
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    }
	}

}
