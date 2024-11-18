package framework.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import framework.common.constants.CommonConstants;
import framework.common.model.FileViewParam;
import lombok.extern.slf4j.Slf4j;

/**
 * File VIEW
 * 
 * @author valueFactory
 * @since 2013. 07. 30.
 */
@Slf4j
public class FileUrlView extends AbstractView {

	public FileUrlView() {
		setContentType("application/download; charset=utf-8");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws IOException{

		FileViewParam fileView = (FileViewParam)model.get(CommonConstants.FILE_PARAM_NAME);

		String fileName = fileView.getFileName();
		log.debug(">>>>FileView Name=" + fileView.getFileName());
		log.debug(">>>>FileView Path=" + fileView.getFilePath());

		response.setContentType(getContentType());
//		response.setContentLength((int) file.length());

		fileName = URLEncoder.encode(fileName, "utf-8");
		fileName = fileName.replaceAll("\\+", " ");

		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();

		

		try (InputStream is = new URL(fileView.getFilePath()).openStream();){
			
			FileCopyUtils.copy(is, out);
		} 
		out.flush();

	}

}
