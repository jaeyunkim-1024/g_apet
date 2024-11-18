package framework.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class FileUtil {

	private FileUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}

	// File.separator
	public static final String SEPARATOR = "/";

	/**
	 * 파일 이동
	 * 
	 * @param orgFile    : 원본파일
	 * @param targetFile : 대상파일
	 * @throws Exception
	 */
	public static void move(File orgFile, File targetFile) throws Exception {

		log.error("#### FileUtil move ####");
		log.error("#### orgFile path : {}",orgFile.getPath());
		log.error("#### targetFile path : {}",targetFile.getPath());
		log.error("#### ##### ####");
		if (targetFile.isFile()) {
			targetFile.delete();
		}
		copy(orgFile, targetFile);
		orgFile.delete();
	}

	/**
	 * 파일 복사
	 * 
	 * @param orgFile    : 원본파일
	 * @param targetFile : 대상파일
	 * @throws IOException 
	 * @throws Exception
	 */
	public static void copy(File orgFile, File targetFile) {
		//보안 진단. 부적절한 자원 해제 (IO)
		FileInputStream inputStream = null;
		FileOutputStream outputStream = null;
		FileChannel fcin = null;
		FileChannel fcout = null;
		try {
			inputStream = new FileInputStream(orgFile);
			outputStream = new FileOutputStream(targetFile);
			fcin = inputStream.getChannel();
			fcout = outputStream.getChannel();
			long size = fcin.size();
			fcin.transferTo(0, size, fcout);			
		} catch ( IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} finally {
			try {
				if(inputStream != null) {
					inputStream.close();
				}
				if(outputStream != null) {
					outputStream.close();
				}
				if(fcin != null) {
					fcin.close();
				}
				if(fcout != null) {
					fcout.close();
				}
			}catch ( IOException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
	}

	/**
	 * 파일 삭제
	 * 
	 * @param targetFile : 대상 파일
	 * @throws Exception
	 */
	public static void delete(File targetFile) throws Exception {
		targetFile.delete();
	}

	public static void fileCopy(String inFileName, String outFileName) {
		//보안 진단관련 replace 처리
		outFileName = outFileName.replaceAll("\\.{2,}[/\\\\]", "");
		File file = new File(outFileName);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		//보안 진단. 부적절한 자원 해제 (IO)
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(inFileName);
			fos = new FileOutputStream(outFileName);

			int data = 0;
			while ((data = fis.read()) != -1) {
				fos.write(data);
			}
			
			
		} catch (IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} finally {
			try {
				if(fis != null) {
					fis.close();
				}
				if(fos != null) {
					fos.close();
				}
			} catch (IOException e2) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e2);
			}
			
		}
	}

	/**
	 * 파일 삭제
	 * 
	 * @param targetFile : 대상 파일
	 * @throws Exception
	 */
	public static void delete(String targetFile) {
		log.info("################ FileUtil 누가 삭제를 하는가3 ################");
		log.info("################ {} ################",targetFile);
		//보안 진단관련 replace 처리
		targetFile = targetFile.replaceAll("\\.{2,}[/\\\\]", "");
		File f = new File(targetFile);
		f.delete();
	}

}
