package framework.common.view;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import framework.common.constants.CommonConstants;
import framework.common.model.FileViewParam;
import framework.common.util.CryptoUtil;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.common.view
 * - 파일명		: FileView.java
 * - 작성일		: 2020. 12. 17.
 * - 작성자		: VALFAC
 * - 설 명			: File VIEW
 * </pre>
 */
@Slf4j
public class FileAllView extends AbstractView {

    public FileAllView() {
        setContentType("application/download; charset=utf-8");
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        int fileCnt = (Integer) model.get(CommonConstants.FILE_LIST_CNT);

        String zipFileName = DateUtil.getNowDate() + "_" + Optional.ofNullable(model.get("seq")).orElseGet(()->"1").toString();
        zipFileName = URLEncoder.encode(zipFileName, "utf-8");
        zipFileName = zipFileName.replaceAll("\\+", " ");

        zipFileName = zipFileName;
        ZipOutputStream zos = null;

        int bufferSize = 1024 * 2;

        try {
            response.setHeader("Content-Disposition", "attachment; filename=" + zipFileName + ".zip" + ";");
            response.setHeader("Content-Transfer-Encoding", "binary");

            OutputStream os = response.getOutputStream();
            zos = new ZipOutputStream(os);
            zos.setLevel(8);
            BufferedInputStream bis = null;

            for(int i=0;i<fileCnt;i++) {
                FileViewParam fileView = (FileViewParam) model.get(CommonConstants.FILE_PARAM_NAME + i);

                log.info(">>>>FileView Name=" + fileView.getFileName());
                log.info(">>>>FileView Path=" + fileView.getFilePath());

                String fileName = fileView.getFileName();
                File sourceFile = new File(fileView.getFilePath());

                bis = new BufferedInputStream(new FileInputStream(sourceFile));
                ZipEntry zentry = new ZipEntry(fileName);
                zentry.setTime(sourceFile.lastModified());
                zos.putNextEntry(zentry);

                byte[] buffer = new byte[bufferSize];
                int cnt = 0;
                while ((cnt = bis.read(buffer, 0, bufferSize)) != -1) {
                    zos.write(buffer, 0, cnt);
                }
                zos.closeEntry();
            }
            zos.close();
            bis.close();

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
