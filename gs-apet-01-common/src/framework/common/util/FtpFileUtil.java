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
public class FtpFileUtil {

	private Properties bizConfig;

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
		String id = bizConfig.getProperty("sftp.file.id");
		String pwd = bizConfig.getProperty("sftp.file.pwd");
		String host = bizConfig.getProperty("sftp.file.host");
		Integer port = Integer.parseInt(bizConfig.getProperty("sftp.file.port", "22"));
		
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
			disconnect();
			throw new CustomException(ExceptionConstants.ERROR_FTP_CONNECT);
		}
	}

	public FtpFileUtil() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		bizConfig = (Properties) wContext.getBean("bizConfig");
	}

	public boolean tempFileCheck(String filePath) {
		boolean result = false;

		String tempPath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH;
		
		if (StringUtil.isNotEmpty(filePath) && filePath.indexOf(tempPath) > -1) {
			result = true;
		}	
		return result;
	}

	public String uploadFilePath(String orgFileStr, String filePath) {
		String newFileName = FilenameUtils.getName(orgFileStr);
		return filePath + FileUtil.SEPARATOR + newFileName;
	}

	public void upload(String orgFileStr, String newFileStr) {
		upload(orgFileStr, newFileStr, true);
	}

	public void upload(String orgFileStr, String newFileStr, boolean isNas) {

		// 보안 진단 관련 check
		orgFileStr = StringUtils.replace(orgFileStr, "..", StringUtils.EMPTY);
		if (!orgFileStr.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
			throw new CustomException(ExceptionConstants.ERROR_FILE_ACCESS_PERMISSION);
		}
		
		//보안 진단관련 replace 처리
		newFileStr = newFileStr.replaceAll("\\.{2,}[/\\\\]", "");

		if (isNas) {
			try {
				File orgFile = new File(orgFileStr);
				File targetFile = new File(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.file") + newFileStr);

				if (!targetFile.getParentFile().exists()) {
					targetFile.getParentFile().mkdirs();
					if(!targetFile.getParentFile().setReadable(true, false)){
						log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
					}
					if(!targetFile.getParentFile().setExecutable(true, false)){
						log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
					}
				}
				FileUtil.move(orgFile, targetFile);
				if(!targetFile.setReadable(true, false)){
					log.error(CommonConstants.LOG_EXCEPTION_SET_PROPERTY);
				}

			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_NAS_COPY);
			}

		} else {

			// ftp 연결
			connect();
			String dir = bizConfig.getProperty("sftp.file.base.dir");

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
							// 보안성 진단. 오류메시지를 통한 정보노출
							//e1.printStackTrace();
							log.error("##### SftpException When ftp upload", e1.getClass());
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
			} catch (FileNotFoundException |SftpException e) {
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

	public String download(String downFileStr) {
		return download(downFileStr, true);
	}

	public String download(String downFileStr, boolean isNas) {

		// 보안 진단 관련 replace 처리
		downFileStr = StringUtils.replace(downFileStr, "..", StringUtils.EMPTY);
		
		//보안 진단관련 replace 처리
		downFileStr= downFileStr.replaceAll("\\.{2,}[/\\\\]", "");
				
		if (isNas) {

			try {

				File orgFile = new File(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.file") + downFileStr);

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

		} else {

			// ftp 연결
			connect();
			String dir = bizConfig.getProperty("sftp.file.base.dir");

			String oldFilePath = FilenameUtils.getPath(downFileStr);
			String newFilePath = bizConfig.getProperty("common.file.download.base") + FileUtil.SEPARATOR
					+ DateUtil.getNowDate() + FileUtil.SEPARATOR;
			String newFileName = FilenameUtils.getName(downFileStr);

			try {
				if(ftp != null) {
					ftp.cd(dir);
					ftp.cd(oldFilePath);
				}				
			} catch (SftpException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				disconnect();
				throw new CustomException(ExceptionConstants.ERROR_FTP_FILEPATH);
			}
			
			File file = new File(newFilePath, newFileName);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			//보안 진단. 부적절한 자원 해제 (IO)
			InputStream in = null;
			FileOutputStream out = null;
			try {
				in = ftp.get(newFileName);
				out = new FileOutputStream(file);
			
				int i;

				while ((i = in.read()) != -1) {
					out.write(i);
				}
			} catch (FileNotFoundException | SftpException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				disconnect();
				throw new CustomException(ExceptionConstants.ERROR_FTP_FILE);			
			} catch (IOException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				disconnect();
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			} finally {				
				disconnect();
				try {
					if(in != null) {
						in.close();
					}
					if(out != null) {
						out.close();
					}
				} catch (IOException e2) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e2);
				}
				
			}
			return newFilePath + newFileName;
		}
	}

	public void delete(String delFileStr) {
		delete(delFileStr, !StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL));
	}

	public void delete(String delFileStr, boolean isNas) {

		// 보안 진단 관련 replace 처리
		delFileStr = StringUtils.replace(delFileStr, "..", "");

		if (isNas) {

			try {
				FileUtil.delete(bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.file") + delFileStr);

			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_NAS_DELETE);
			}

		} else {

			// ftp 연결
			connect();
			String dir = bizConfig.getProperty("sftp.file.base.dir");

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
}
