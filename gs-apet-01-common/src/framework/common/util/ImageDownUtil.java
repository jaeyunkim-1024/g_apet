package framework.common.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.admin.constants.AdminConstants;
import framework.admin.util.LogUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImageDownUtil {

	private Properties bizConfig;

	public ImageDownUtil() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		this.bizConfig = (Properties) wContext.getBean("bizConfig");
	}

	public ImageDownUtil(Properties bizConfig) {
		this.bizConfig = bizConfig;
	}

	public String fetchFile(String imgUrl) throws IOException {
		String path = null;
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new ByteArrayHttpMessageConverter());

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_OCTET_STREAM));

		HttpEntity<String> entity = new HttpEntity<>(headers);

//	    String imgUrl = "https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png";

		ResponseEntity<byte[]> response = restTemplate.exchange(imgUrl, HttpMethod.GET, entity, byte[].class, "1");

		String orgFileName = imgUrl.substring(imgUrl.lastIndexOf('/') + 1, imgUrl.length()); // 이미지 파일명 추출
		String exe = imgUrl.substring(imgUrl.lastIndexOf('.') + 1, imgUrl.length()); // 이미지 확장자 추출
		String[] fileFilter = "jpg,jpeg,png,gif,bmp".split(",");

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			LogUtil.log("fileName : " + orgFileName);
			LogUtil.log("ext : " + exe);
			log.debug("==================================================");
		}

		Boolean checkExe = true;
		for (String ex : fileFilter) {
			if (ex.equalsIgnoreCase(exe)) {
				checkExe = false;
			}
		}

		if (checkExe) {
			throw new CustomException(ExceptionConstants.BAD_EXE_FILE_EXCEPTION);
		}

		String fileName = System.currentTimeMillis() + "." + exe;
		String filePath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH
				+ FileUtil.SEPARATOR + DateUtil.getNowDate() + FileUtil.SEPARATOR;
		filePath = filePath.replaceAll("\\.{2,}[/\\\\]", "");
		File file = new File(filePath + fileName);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}

		if (response.getStatusCode() == HttpStatus.OK) {
			path = file.getPath();
			Files.write(Paths.get(path), response.getBody());
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return path;
	}
}
