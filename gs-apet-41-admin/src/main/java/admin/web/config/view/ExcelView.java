package admin.web.config.view;

import admin.web.config.util.ServiceUtil;
import biz.app.system.model.CodeDetailVO;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.crypt.EncryptionMode;
import org.apache.poi.poifs.crypt.Encryptor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Excel View
 * @author snw
 * @since 2013.07.30
 */
@Slf4j
public class ExcelView extends AbstractXlsxView {

	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String excelFileName = (String)model.get(CommonConstants.EXCEL_PARAM_FILE_NAME);

		ExcelViewParam excel = (ExcelViewParam)model.get(CommonConstants.EXCEL_PARAM_NAME);
		List<ExcelViewParam> listExcel = (List<ExcelViewParam>)model.get(CommonConstants.EXCEL_LIST_PARAM_NAME);

		if(StringUtil.isBlank(excelFileName)){
			excelFileName = "excel";
		}

		String password = Optional.ofNullable(model.get(CommonConstants.EXCEL_PASSWORD)).orElseGet(()->"").toString();
		String exceNameDateFormat  = Optional.ofNullable(model.get(CommonConstants.EXCEL_PARAM_FILE_NAME_DATE_FORMAT)).orElseGet(()->"yyyyMMdd").toString();

		String excelName = createFileName(excelFileName, exceNameDateFormat);

		String fileName = URLEncoder.encode(excelName, "UTF-8");
		fileName = fileName.replaceAll("\\+", " ");
		log.debug(">>>>>>>>Excel Name="+excelName);
		log.debug(">>>>>>>>File Name="+fileName);

		response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "");

		if(CollectionUtils.isNotEmpty(listExcel)) {
			for(ExcelViewParam excelViewParam : listExcel){
				createSheet(workbook, excelViewParam,response,password);
			}
		} else {
			createSheet(workbook, excel,response, password);
		}
	}

	@SuppressWarnings("rawtypes")
	private void createSheet(Workbook workbookOrg, ExcelViewParam param , HttpServletResponse res , String password) throws IOException{
		Workbook workbook = workbookOrg;
		ByteArrayOutputStream fileOut = new ByteArrayOutputStream();
		if(StringUtil.isNotEmpty(password)){
			workbook = (XSSFWorkbook)workbookOrg;
		}

		Sheet sheet = workbook.createSheet(param.getSheetName());
		sheet.setDefaultColumnWidth(20);
		sheet.setDisplayGridlines(true);
		sheet.setDefaultRowHeightInPoints((short)15);
		
		if(null != param.getHeaderName() && param.getHeaderName().length > 0) {
			for(int i =0; i < param.getHeaderName().length; i++) {
				CellStyle textStyle = workbook.createCellStyle();
				textStyle.setDataFormat((short) BuiltinFormats.getBuiltinFormat("text"));
				sheet.setDefaultColumnStyle(i, textStyle);
			}
		}

		Row row = null;

		// Header Style
		CellStyle headerStyle = workbook.createCellStyle();
		Font headerFont = workbook.createFont();
		headerFont = createHeaderFont(headerFont);
		headerStyle = createHeaderCellStyle(headerStyle, headerFont);

		// 본문 Style
		CellStyle cellStyle = workbook.createCellStyle();
		Font cellFont = workbook.createFont();
		cellFont = createCellFont(cellFont);
		cellStyle = createCellStyle(cellStyle, cellFont);

		int i = 0;
		if(null != param.getHeaderName() && param.getHeaderName().length > 0) {
			row = sheet.createRow(i);
			int j = 0;
			for(String name : param.getHeaderName()) {
				String value = name;

				if(StringUtil.isNotBlank(param.getCodeYn()) && CommonConstants.COMM_YN_Y.equals(param.getCodeYn()) && null != param.getFieldName() && param.getFieldName().length > 0){
					try {
						String fieldName = StringUtil.toUnCamelCase(param.getFieldName()[j]);
						if(fieldName.lastIndexOf("_CD") > -1) {
							String grpCd = fieldName.substring(0, fieldName.lastIndexOf("_CD"));
							List<CodeDetailVO> list = ServiceUtil.listCode(grpCd);

							if(CollectionUtils.isNotEmpty(list)){
								StringBuilder sb = new StringBuilder();
								for(CodeDetailVO vo : list){
									sb.append("\n").append(vo.getDtlCd()).append(" - ").append(vo.getDtlNm());
								}
								value = name + sb.toString();
							}
						}
					} catch (Exception e){
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
				}

				row.createCell(j).setCellValue(value);
				row.getCell(j).setCellStyle(headerStyle);
				j++;
			}
			i++;
		}

		if(null != param.getDataList() && param.getDataList().size() > 0) {
			for(Object obj : param.getDataList()) {
				row = sheet.createRow(i);

				if (null != param.getFieldName() && param.getFieldName().length > 0) {
					int j = 0;

					for (String name : param.getFieldName()) {
						String fieldValue = "";
						try {
							Object value = PropertyUtils.getProperty(obj, name);

							if(value instanceof String) {
								if(StringUtil.isNotBlank(param.getCodeYn()) && CommonConstants.COMM_YN_Y.equals(param.getCodeYn())){
									fieldValue = StringEscapeUtils.unescapeHtml4((String) value);
								} else {
									String fieldName = StringUtil.toUnCamelCase(name);
									if(fieldName.equalsIgnoreCase("BOM_CD")) {
										fieldValue = (String) value;
									} else if(fieldName.toUpperCase().lastIndexOf("_CD") > -1) {
										String grpCd = fieldName.substring(0, fieldName.lastIndexOf("_CD"));
										String dtlCd = (String) value;
										if(StringUtil.isNotBlank(dtlCd)){
											CodeDetailVO vo = ServiceUtil.getCode(grpCd, dtlCd);
											if(vo != null) {
												fieldValue = vo.getDtlNm();
											}
										}
									} else {
										fieldValue = StringEscapeUtils.unescapeHtml4((String) value);
									}
								}
							}
							String fieldName = StringUtil.toUnCamelCase(name);
							
							if(value instanceof Long && fieldName.toUpperCase().lastIndexOf("MOBILE")<0) {
								//fieldValue = value.toString();
								DecimalFormat decimalFormat = new DecimalFormat("###,###");
								fieldValue = decimalFormat.format(value);
							}

							if(value instanceof BigDecimal) {
								//fieldValue = value.toString();
								DecimalFormat decimalFormat = new DecimalFormat("###,###");
								fieldValue = decimalFormat.format(value);
							}

							if(value instanceof Integer) {
								//fieldValue = value.toString();
								DecimalFormat decimalFormat = new DecimalFormat("###,###");
								fieldValue = decimalFormat.format(value);
							}

							if(value instanceof Double) {
								fieldValue = value.toString();
							}

							if(value instanceof Timestamp) {
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
								Timestamp t = (Timestamp) value;

								if(t != null) {
									fieldValue = sdf.format(t);
								}
							}
							
							if(fieldName.toUpperCase().lastIndexOf("MOBILE") > -1) {
								if(value instanceof Long) {
									fieldValue = String.valueOf(value);
								}
								String mobile = "";
								if(fieldValue.length()==11) {
									mobile = fieldValue.substring(0, 3) + "-" + fieldValue.substring(3, 7) + "-" + fieldValue.substring(7, 11); 
								} else if(fieldValue.length()==10) {
									mobile = fieldValue.substring(0, 3) + "-" + fieldValue.substring(3, 6) + "-" + fieldValue.substring(6, 10);
								}
								fieldValue = !"".equals(mobile) ? mobile : fieldValue;
							}

						} catch (IllegalAccessException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						} catch (InvocationTargetException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						} catch (NoSuchMethodException e) {
							log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						}

						row.createCell(j).setCellValue(fieldValue);
						row.getCell(j).setCellStyle(cellStyle);

						j ++;
					}
				}

				i ++;
			}
		}

		if(StringUtil.isNotEmpty(password)){
			try{
				workbook.write(fileOut);
				InputStream filein = new ByteArrayInputStream(fileOut.toByteArray());
				POIFSFileSystem fs = new POIFSFileSystem();
				EncryptionInfo info = new EncryptionInfo(EncryptionMode.agile);
				Encryptor enc = info.getEncryptor();
				enc.confirmPassword(password);

				OPCPackage opc = OPCPackage.open(filein);
				OutputStream os = enc.getDataStream(fs);
				opc.save(os);
				opc.close();

				OutputStream fileOut2 = null;
				fileOut2 = res.getOutputStream();
				fs.writeFilesystem(fileOut2);
				fileOut2.close();
				fileOut.close();
			}catch (IOException e) {
				log.error(e.getMessage(), e);

			} catch (InvalidFormatException e) {
				log.error(e.getMessage(), e);

			} catch (GeneralSecurityException e) {
				log.error(e.getMessage(), e);
			}
		}
	}

	/**
	 * Header Cell Style 정의
	 * @param headerStyle
	 * @return
	 */
	private CellStyle createHeaderCellStyle(CellStyle headerStyle, Font headerFont) {
		headerStyle.setBorderTop((short)1);
		headerStyle.setBorderLeft((short)1);
		headerStyle.setBorderRight((short)1);
		headerStyle.setBorderBottom((short)1);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
		headerStyle.setFont(headerFont);
		return headerStyle;
	}

	/**
	 * Header Font 정의
	 * @param headerFont
	 * @return
	 */
	private Font createHeaderFont(Font headerFont) {
		headerFont.setColor(Font.COLOR_NORMAL);
		headerFont.setFontHeightInPoints((short)11);
		return headerFont;
	}

	/**
	 * Cell Style 정의
	 * @param cellStyle
	 * @return
	 */
	private CellStyle createCellStyle(CellStyle cellStyle, Font cellFont) {
		cellStyle.setBorderTop((short)1);
		cellStyle.setBorderLeft((short)1);
		cellStyle.setBorderRight((short)1);
		cellStyle.setBorderBottom((short)1);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setFont(cellFont);
		cellStyle.setDataFormat((short) BuiltinFormats.getBuiltinFormat("text"));
		//여러 줄 표시할 경우 꼭 true
		cellStyle.setWrapText(true);
		return cellStyle;
	}

	/**
	 * Cell Font 정의
	 * @param cellFont
	 * @return
	 */
	private Font createCellFont(Font cellFont) {
		cellFont.setColor(Font.COLOR_NORMAL);
		cellFont.setFontHeightInPoints((short)10);
		return cellFont;
	}

	private String createFileName(String fName) {
		SimpleDateFormat fileFormat = new SimpleDateFormat("yyyyMMdd");
		return fName + "_" + fileFormat.format(new Date()) + ".xlsx";
	}

	private String createFileName(String fName, String format){

		if(StringUtils.equals(format, "")){
			format = "yyyyMMdd";
		}

		SimpleDateFormat fileFormat = new SimpleDateFormat(format);
		return fName + "_" + fileFormat.format(new Date()) + ".xlsx";
	}

}

