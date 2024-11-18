package framework.common.util.excel;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DateUtil;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

public class SingleSheetExcelFactory {

	@SuppressWarnings({ "unused", "resource" })
	public void toExcelFile(List<?> dataList, String[][] mapping, String title, File targetFile) {
		try {
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("Sheet1");
			CreationHelper createHelper = wb.getCreationHelper();
			makeTitleHeader(title, sheet);
			makeColumnNames(mapping, sheet);
			Object[] last = new Object[mapping.length];
			for (int rowIndex = 0; rowIndex < dataList.size(); rowIndex++) {
				HSSFRow row = sheet.createRow(rowIndex + 2); // title, column 제외
				Object data = dataList.get(rowIndex);
				for (int colIndex = 0; colIndex < mapping.length; colIndex++) {
					String propertyName = mapping[colIndex][0];
					String[] options = null;
					if (propertyName.contains(",")) {
						options = propertyName.substring(propertyName.indexOf(',') + 1).trim().split(",");
						propertyName = propertyName.substring(0, propertyName.indexOf(',')).trim();
					}

					Object value = null;
					HSSFCell cell = row.createCell(colIndex);
					if (propertyName.matches("[a-zA-Z][a-zA-Z0-9_]*\\.[a-zA-Z][a-zA-Z0-9_]*(\\.[a-zA-Z][a-zA-Z0-9_]*)*")) {
						value = PropertyUtils.getNestedProperty(data, propertyName);
					} else {
						value = PropertyUtils.getSimpleProperty(data, propertyName);
					}
					if (value instanceof Date) {
						value = DateUtil.getExcelDate((Date) value);
						double dValue = ((Number) value).doubleValue();
						cell.setCellValue(dValue);
						String dateFormat = options != null && options.length >= 1 ? options[0] : "yyyy-MM-dd";
						CellStyle cellStyle = wb.createCellStyle();
						cellStyle.setDataFormat(createHelper.createDataFormat().getFormat(dateFormat));
						cell.setCellStyle(cellStyle);

					}

					last[colIndex] = value;
					if (value == null) {
						last[colIndex] = null;
						continue;
					}

					if (value instanceof Number) {
						cell.setCellType(Cell.CELL_TYPE_NUMERIC);
						double dValue = ((Number) value).doubleValue();
						cell.setCellValue(dValue);
					}

					else {
						cell.setCellType(Cell.CELL_TYPE_STRING);
						cell.setCellValue(value.toString());
					}

				}
			}
			//보안 진단. 부적절한 자원 해제 (IO)	
			FileOutputStream fileout = null;
			try {
				fileout = new FileOutputStream(targetFile);
				wb.write(fileout);
				fileout.close();
			} finally {
				if(fileout !=null) {
					fileout.close();
				}
			}
		}catch (IOException |  InvocationTargetException | NoSuchMethodException ioe) {
			throw new IllegalArgumentException(ioe);
		} catch (Exception e) {
			throw new IllegalArgumentException(e);
		}
	}

	private static void makeTitleHeader(String title, HSSFSheet sheet) {
		HSSFRow row = sheet.createRow(0);

		Cell cell = row.createCell(0);

		cell.setCellValue(title);
	}

	private static void makeColumnNames(String[][] mapping, HSSFSheet sheet) {
		HSSFRow row = sheet.createRow(1);
		for (int i = 0; i < mapping.length; i++) {
			row.createCell(i).setCellValue(mapping[i][1]);
		}
	}
}
