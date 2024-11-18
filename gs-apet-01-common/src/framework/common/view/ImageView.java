package framework.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import framework.common.constants.CommonConstants;
import framework.common.model.FileViewParam;
import framework.common.util.FileUtil;

/**
 * Image View
 * 
 * @author valueFactory
 * @since 2013. 07. 30.
 */
@Slf4j
public class ImageView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		FileViewParam fileView = (FileViewParam)model.get(CommonConstants.FILE_PARAM_NAME);
		if (!StringUtils.contains(fileView.getFilePath(), fileView.getRootPath()[1]) && !StringUtils.startsWith(fileView.getFilePath(), fileView.getRootPath()[0])){
			fileView.setFilePath(fileView.getRootPath()[0] + FileUtil.SEPARATOR + fileView.getFilePath());
		}
		File file = new File(fileView.getFilePath());

		log.debug("=====================================================");
		log.debug("= FilePath : {}", fileView.getFilePath());
		log.debug("=====================================================");

		OutputStream out = response.getOutputStream();

		try(FileInputStream fis = new FileInputStream(file);) {			
			FileCopyUtils.copy(fis, out);
		}
		out.flush();

	}
}
