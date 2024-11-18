package framework.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;

import framework.common.constants.CommonConstants;
import framework.common.util.excel.CellRangeAddressWrapper;
import framework.common.util.excel.ExcelCallback;
import framework.common.util.excel.ExcelData;
import framework.common.util.excel.ExcelDataCallback;
import framework.common.util.excel.ExcelHeader;
import framework.common.util.excel.MultiSheetExcelFactory;
import framework.common.util.excel.SingleSheetExcelFactory;
import lombok.extern.slf4j.Slf4j;

/**
 * Excel Util
 * 
 * @author valueFactory
 * @since 2016. 05. 19.
 */
@Slf4j
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ExcelUtil {

	/*
	 * 한 시트에 최대 넣을 수 있는 데이터 Rows 수 설정시 주의점 : 
	 * Title이나, 요소의 정보를 넣을 수 있으므로, 해당 값을 넣을 수 있는 Row는 이 값 설정할때 여유값으로 빼 줄것 
	 * 원래대로라면 65535까지 가능 메뉴의 전체 다운로드 기능 개선(엑셀파일 시트분리)에 의거 5만 라인으로 FIX
	 */
	public static final  int MAXIMUM_ROW_CNTS_PER_ONE_SHEET = 50000;
	public static final  int HEADER_ROW_CNTS = 3;

	/**
	 * <pre>엑셀 파일을 파싱하여 데이터 형태로 반환한다.</pre>
	 * 
	 * @param file
	 * @param clazz
	 * @param mappings
	 * @param headerLines
	 * @param columnRowIndex
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public static ExcelData parse(File file, final Class clazz, final String[][] mappings, int headerLines, final int columnRowIndex)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {

		final ExcelUtil instance = new ExcelUtil();
		final List res = new ArrayList(100);
		ExcelHeader header = instance.execute(file, headerLines, columnRowIndex, new ExcelDataCallback() {
			@Override
			public void rowAt(ExcelHeader header, int rowNo, Object[] cellDatas) 
					throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
				res.add(instance.convertCellToObjectByColumn(header, columnRowIndex, clazz, mappings, cellDatas));
			}
		});

		return new ExcelData(header, res);
	}

	/**
	 * <pre>엑셀을 Template Method 형태로 분석하며 Callback 받아 처리할수 있는 메소드</pre>
	 * 
	 * @param file
	 * @param headerLines
	 * @param columnRowIndex
	 * @param excelDataCallback
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public ExcelHeader execute(File file, int headerLines, int columnRowIndex, ExcelDataCallback excelDataCallback)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {

		Sheet sheet = loadExcelFile(file).getSheetAt(0);
		int rowCount = sheet.getPhysicalNumberOfRows();
		int maxCellCount = countMaxCellCount(sheet, rowCount);
		String[][] headers = new String[rowCount][maxCellCount];
		
		for (int i = 0; i < headerLines; i++) {
			Row row = sheet.getRow(i);
			Object[] values = getRowCellsData(row, maxCellCount);
			for (int k = 0; k < maxCellCount; k++) {
				if (values[k] != null) {
					headers[i][k] = values[k].toString();
				}
			}
		}
		
		ExcelHeader header = new ExcelHeader(headers);
		// Column Name Row 는 넘기고 데이터 계산 시작
		for (int i = columnRowIndex + 1; i < rowCount; i++) {
			Row row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Object[] values = getRowCellsData(row, maxCellCount);
			excelDataCallback.rowAt(header, i, values);
		}
		return header;
	}

	public static List parse(File file, final Class clazz, final String[] mapping, int headerSkipLines) throws IOException {
		final ExcelUtil instance = new ExcelUtil();
		final List res = new ArrayList(100);
		instance.execute(file, headerSkipLines,	(int rowNo, Object[] cellDatas) ->{
				try {
					res.add(ExcelUtil.convertCellToObject(clazz, mapping, cellDatas));
				} catch (Exception ex) {
					throw new IllegalArgumentException(ex);
				}		
		});
		return res;
	}

	/**
	 * <pre>데이터 목록을 엑셀파일로 생성한다.</pre>
	 * 
	 * @param dataList
	 * @param mapping
	 * @param title
	 * @param targetFile
	 */
	public static void toExcelFile(List<?> dataList, String[][] mapping, String title, File targetFile) {
		new SingleSheetExcelFactory().toExcelFile(dataList, mapping, title, targetFile);
	}

	/**
	 * <pre>데이터 목록을 엑셀파일로 생성한다.</pre>
	 * 
	 * @param dataList
	 * @param mapping
	 * @param title
	 * @param targetFile
	 */
	public static void toMultipleSheetsExcelFile(List<?> dataList, String[][] mapping, String title, File targetFile) {
		new MultiSheetExcelFactory().toMultipleSheetsExcelFile(dataList, mapping, title, targetFile);
	}

	protected static Object convertCellToObject(Class clazz, String[] mapping, Object[] cellDatas)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Object bizz = clazz.newInstance();
		Method[] methods = bizz.getClass().getMethods();

		/*
		 * 실제 Mapping이 Excel CellData의 크기보다 더 큰경우에 대한 예외처리 mapping을 여유있게 넉넉히 잡은 경우,
		 * Excel Cell Data에 해당정보가 들어오지 않아도, 해당 값을 입력만 안 할 뿐 오류가 나지 않도록 조치
		 *
		 */

		int mappingLength = mapping.length;
		if (cellDatas.length < mappingLength) {
			mappingLength = cellDatas.length;
		}
		 
		for (int i = 0; i < mappingLength; i++) {
			if (cellDatas[i] == null) {
				continue;
			}
			String[] options = null;
			String propertyName = mapping[i];
			if (propertyName.contains(",")) {
				options = propertyName.substring(propertyName.indexOf(',') + 1).trim().split(",");
				propertyName = propertyName.substring(0, propertyName.indexOf(',')).trim();

			}
			Object rawData = cellDatas[i];
			Class paramClass = parseParameterClass(methods, options, propertyName);
			if (paramClass == null) {
				continue;
			}

			// PropertyUtils 은 정확히 같은 타입만을 set 해주기 때문에 각 메소드의 타입을 파악해야 함.
			if (rawData instanceof Double) {
				Double value = (Double) cellDatas[i];

				if (paramClass.equals(Long.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.longValue());
				} else if (paramClass.equals(Double.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value);
				} else if (paramClass.equals(Integer.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.intValue());
				}

				else if (paramClass.equals(Float.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.floatValue());
				} else if (paramClass.equals(String.class)) {
					if (value.toString().endsWith(".0")) {
						int valueTmp = value.intValue();
						NestedBeanUtils.setProperty(bizz, propertyName, Integer.toString(valueTmp));
					} else {
						NestedBeanUtils.setProperty(bizz, propertyName, value.toString());
					}
				} else if (paramClass.equals(Date.class)) {
					Date dateValue = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);
					NestedBeanUtils.setProperty(bizz, propertyName, dateValue);
				}
			} else if (rawData instanceof Float) {
				NestedBeanUtils.setProperty(bizz, propertyName, ((Float) rawData).longValue());
			}

			else {
				// 현재까지 Option을 지원하는 것은 Date 뿐임.
				if (options != null && paramClass.equals(Date.class)) {
					SimpleDateFormat formatter = new SimpleDateFormat(options[2]);
					try {
						Date date = formatter.parse(rawData.toString());
						NestedBeanUtils.setProperty(bizz, propertyName, date);
					} catch (ParseException e) {
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
				} else {
					NestedBeanUtils.setProperty(bizz, propertyName, rawData);
				}
			}
		}
		return bizz;
	}

	private static Class<?> parseParameterClass(Method[] methods, String[] options, String propertyName) {
		Class<?> paramClass = null;
		if (options == null) {

			String setter = toSetter(propertyName);
			Method setterMethod = null;
			for (Method method : methods) {
				if (method.getName().equals(setter)) {
					setterMethod = method;
				}
			}
			if (setterMethod == null) {
				return null;
			}

			Class<?>[] parameterTypes = setterMethod.getParameterTypes();
			paramClass = parameterTypes[0];
		} else {
			class SupportType {
				String type;
				Class clazz;

				SupportType(String type, Class clazz) {
					this.type = type;
					this.clazz = clazz;
				}
			}

			SupportType[] supportTypes = new SupportType[] {
				new SupportType("string", String.class),
				new SupportType("long", Long.class), 
				new SupportType("double", Double.class),
				new SupportType("float", float.class),
				new SupportType("date", Date.class),
				new SupportType("date", Date.class),
				new SupportType("date", Date.class)
			};
			for (SupportType type : supportTypes) {
				if (type.type.equals(options[0])) {
					paramClass = type.clazz;
				}
			}
		}
		return paramClass;
	}

	protected Object convertCellToObjectByColumn(ExcelHeader header, int columnRowIndex, Class clazz, String[][] mappings, Object[] cellDatas)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Object bizz = clazz.newInstance();

		Method[] methods = bizz.getClass().getMethods();

		for (String[] mapping : mappings) {
			String columnName = mapping[0];
			String propertyName = mapping[1];
			int colIndex = header.getColumnIndex(columnRowIndex, columnName);
			if (colIndex == -1 || cellDatas[colIndex] == null) {
				continue;
			}
			Object cellData = cellDatas[colIndex];

			// PropertyUtils 은 정확히 같은 타입만을 set 해주기 때문에 각 메소드의 타입을 파악해야 함.
			if (cellData instanceof Double) {
				Double value = (Double) cellData;
				String setter = toSetter(propertyName);
				Method setterMethod = null;
				for (Method method : methods) {
					if (method.getName().equals(setter)) {
						setterMethod = method;
					}
				}
				if (setterMethod == null) {
					continue;
				}
				Class<?>[] parameterTypes = setterMethod.getParameterTypes();
				Class<?> paramClass = parameterTypes[0];
				if (paramClass.equals(Long.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.longValue());
				} else if (paramClass.equals(Double.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value);
				} else if (paramClass.equals(Integer.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.intValue());
				}

				else if (paramClass.equals(Float.class)) {
					NestedBeanUtils.setProperty(bizz, propertyName, value.floatValue());
				} else if (paramClass.equals(String.class)) {
					if (value.toString().endsWith(".0")) {
						int valueTmp = value.intValue();
						NestedBeanUtils.setProperty(bizz, propertyName, Integer.toString(valueTmp));
					} else {
						NestedBeanUtils.setProperty(bizz, propertyName, value.toString());
					}
				}
			} else if (cellDatas[colIndex] instanceof Float) {
				NestedBeanUtils.setProperty(bizz, propertyName, ((Float) cellData).longValue());
			} else {
				NestedBeanUtils.setProperty(bizz, propertyName, cellData);
			}
		}
		return bizz;
	}

	private static String toSetter(String temp) {
		return "set" + temp.substring(0, 1).toUpperCase() + temp.substring(1);
	}

	/**
	 * <pre>엑셀파일을 읽어 Workbook 객체를 생성한다.</pre>
	 * 
	 * @param fileName
	 * @return
	 */
	Workbook loadExcelFile(String fileName) {
		return loadExcelFile(new File(fileName));
	}

	/**
	 * <pre>엑셀파일을 읽어 Workbook 객체를 생성한다.</pre>
	 * 
	 * @param file
	 * @return
	 */
	Workbook loadExcelFile(File file) {
		try {
			return WorkbookFactory.create(new FileInputStream(file));
		} catch (Exception ex) {
			throw new IllegalArgumentException(ex);
		}
	}

	/**
	 * <pre>엑셀파일을 읽어 각 줄을 excelCallback 에게 callback 한다.</pre>
	 * 
	 * @param fileName
	 * @param headerLinesToSkip
	 * @param excelCallback
	 * @throws IOException
	 */
	public void execute(String fileName, int headerLinesToSkip, ExcelCallback excelCallback) throws IOException {
		execute(new File(fileName), headerLinesToSkip, excelCallback);
	}

	/**
	 * <pre>엑셀파일을 읽어 각 줄을 excelCallback 에게 callback 한다.</pre>
	 * 
	 * @param file
	 * @param headerLinesToSkip
	 * @param excelCallback
	 * @throws IOException
	 */
	public void execute(File file, int headerLinesToSkip, ExcelCallback excelCallback) throws IOException {
		execute(loadExcelFile(file).getSheetAt(0), headerLinesToSkip, excelCallback);
	}

	/**
	 * <pre>엑셀파일을 읽어 각 줄을 excelCallback 에게 callback 한다.</pre>
	 * 
	 * @param sheet
	 * @param headerLinesToSkip
	 * @param excelCallback
	 * @throws IOException
	 */
	void execute(Sheet sheet, int headerLinesToSkip, ExcelCallback excelCallback) throws IOException {
		int rowCount = sheet.getPhysicalNumberOfRows();
		int maxCellCount = countMaxCellCount(sheet, rowCount);

		for (int i = headerLinesToSkip; i <= rowCount + 100; i++) {
			Row row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Object[] values = getRowCellsData(row, maxCellCount);
			excelCallback.rowAt(i, values);
		}
	}

	private Object[] getRowCellsData(Row row, int maxCellCount) {
		Object[] values = new Object[maxCellCount];

		for (int i = 0; i < maxCellCount; i++) {
			if (row == null) {
				continue;
			}
			Cell cell = row.getCell(i);
			if (cell == null) {
				continue;
			}
			values[i] = decideValues(cell);
		}
		return values;
	}

	private Object decideValues(Cell cell) {
		if (cell == null) {
			return null;
		}

		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC:
			DecimalFormat df = new DecimalFormat("#");
			int fractionalDigits = 2; // say 2
			df.setMaximumFractionDigits(fractionalDigits);
			String val = df.format(cell.getNumericCellValue());
			return val;
		case Cell.CELL_TYPE_STRING:
			return cell.getStringCellValue();

		default:
			// 다른 형식은 처리하지 않음.
		}
		return null;
	}

	private int countMaxCellCount(Sheet sheet, int rowCount) {
		int max = 0;
		for (int i = 0; i < rowCount; i++) {
			if (sheet.getRow(i) == null) {
				continue;
			}
			max = Math.max(max, sheet.getRow(i).getPhysicalNumberOfCells());
		}
		return max;
	}

	public static void copySheets(Sheet newSheet, Sheet sheet) {
		copySheets(newSheet, sheet, false);
	}

	public static void copySheets(Sheet newSheet, Sheet sheet, boolean copyStyle) {
		int maxColumnNum = 0;
		int newSheetRowCnt = 0;
		Map<Integer, CellStyle> styleMap = (copyStyle) ? new HashMap<>() : null;
		for (int i = sheet.getFirstRowNum() + HEADER_ROW_CNTS; i <= sheet.getLastRowNum(); i++) {
			Row srcRow = sheet.getRow(i);

			if (checkRow(srcRow)) {
				Row destRow = newSheet.createRow(newSheetRowCnt++);
				copyRow(sheet, newSheet, srcRow, destRow, styleMap);
				if (srcRow.getLastCellNum() > maxColumnNum) {
					maxColumnNum = srcRow.getLastCellNum();
				}				
			}

		}
		for (int i = 0; i <= maxColumnNum; i++) {
			newSheet.setColumnWidth(i, sheet.getColumnWidth(i));
		}
	}

	public static boolean checkRow(Row srcRow) {
		boolean checkCell = false;
		for (int j = srcRow.getFirstCellNum(); j <= srcRow.getLastCellNum(); j++) {
			Cell oldCell = srcRow.getCell(j); // ancienne cell

			if (oldCell == null || Cell.CELL_TYPE_BLANK == oldCell.getCellType()) {
				continue;
			}

			switch (oldCell.getCellType()) {
			case Cell.CELL_TYPE_STRING:
				log.debug("############################################# srcRow.getCell(j) : {} {} !", j, oldCell.getStringCellValue());
				break;
			case Cell.CELL_TYPE_NUMERIC:
				log.debug("############################################# srcRow.getCell(j) : {} {} !", j, oldCell.getNumericCellValue());
				break;
			case Cell.CELL_TYPE_BLANK:
				log.debug("############################################# srcRow.getCell(j) : {} BLANK !", j);
				break;
			case Cell.CELL_TYPE_BOOLEAN:
				log.debug("############################################# srcRow.getCell(j) : {} {} !", j, oldCell.getBooleanCellValue());
				break;
			case Cell.CELL_TYPE_ERROR:
				log.debug("############################################# srcRow.getCell(j) : {} {} !", j, oldCell.getErrorCellValue());
				break;
			case Cell.CELL_TYPE_FORMULA:
				log.debug("############################################# srcRow.getCell(j) : {} {} !", j, oldCell.getCellFormula());
				break;
			default:
				break;
			}

			checkCell = true;
		}

		return checkCell;
	}

	public static void copyRow(Sheet srcSheet, Sheet destSheet, Row srcRow, Row destRow,
			Map<Integer, CellStyle> styleMap) {
		// manage a list of merged zone in order to not insert two times a merged zone
		Set<CellRangeAddressWrapper> mergedRegions = new TreeSet<>();
		destRow.setHeight(srcRow.getHeight());
		// pour chaque row

		log.debug("############################################# srcRow.getCell(j) : START");

		// int rowCheck = 0;
		for (int j = srcRow.getFirstCellNum(); j <= srcRow.getLastCellNum(); j++) {
			Cell oldCell = srcRow.getCell(j); // ancienne cell

			if (oldCell == null || Cell.CELL_TYPE_BLANK == oldCell.getCellType()) {
				continue;
			}

			switch (oldCell.getCellType()) {
			case Cell.CELL_TYPE_STRING:
				log.debug("############################################# srcRow.getCell(j) STRING : {} {} !", j, oldCell.getStringCellValue());
				break;
			case Cell.CELL_TYPE_NUMERIC:
				log.debug("############################################# srcRow.getCell(j) NUMERIC : {} {} !", j, oldCell.getNumericCellValue());
				oldCell.setCellType(Cell.CELL_TYPE_STRING);

				break;
			case Cell.CELL_TYPE_BLANK:
				log.debug("############################################# srcRow.getCell(j) BLANK : {} BLANK !", j);
				break;
			case Cell.CELL_TYPE_BOOLEAN:
				log.debug("############################################# srcRow.getCell(j) BOOLEAN : {} {} !", j, oldCell.getBooleanCellValue());
				break;
			case Cell.CELL_TYPE_ERROR:
				log.debug("############################################# srcRow.getCell(j) ERROR : {} {} !", j, oldCell.getErrorCellValue());
				break;
			case Cell.CELL_TYPE_FORMULA:
				log.debug("############################################# srcRow.getCell(j) FORMULA : {} {} !", j, oldCell.getCellFormula());
				break;
			default:
				break;
			}

			// log.debug("############################################# srcRow.getCell(j) :
			// {} !" + srcRow.getCell(j).getStringCellValue());

			Cell newCell = destRow.getCell(j); // new cell
			
			if (newCell == null) {
				newCell = destRow.createCell(j);
			}
			// copy chaque cell
			copyCell(oldCell, newCell, styleMap);
			// copy les informations de fusion entre les cellules
			// (short)oldCell.getColumnIndex());

			CellRangeAddress mergedRegion = getMergedRegion(srcSheet, srcRow.getRowNum(), (short) oldCell.getColumnIndex());
			if (mergedRegion != null) {
				
				CellRangeAddress newMergedRegion = new CellRangeAddress(mergedRegion.getFirstRow(),
						mergedRegion.getLastRow(), mergedRegion.getFirstColumn(), mergedRegion.getLastColumn());
				
				CellRangeAddressWrapper wrapper = new CellRangeAddressWrapper(newMergedRegion);
				if (isNewMergedRegion(wrapper, mergedRegions)) {
					mergedRegions.add(wrapper);
					destSheet.addMergedRegion(wrapper.range);
				}
			}
		}
		log.debug("############################################# srcRow.getCell(j) : END");
	}

	public static void copyCell(Cell oldCell, Cell newCell, Map<Integer, CellStyle> styleMap) {
		if (styleMap != null) {
			if (oldCell.getSheet().getWorkbook() == newCell.getSheet().getWorkbook()) {
				newCell.setCellStyle(oldCell.getCellStyle());
			} else {
				int stHashCode = oldCell.getCellStyle().hashCode();
				CellStyle newCellStyle = styleMap.get(stHashCode);
				if (newCellStyle == null) {
					newCellStyle = newCell.getSheet().getWorkbook().createCellStyle();
					newCellStyle.cloneStyleFrom(oldCell.getCellStyle());
					// styleMap.put(stHashCode, newCellStyle);
				}
				newCell.setCellStyle(newCellStyle);
			}
		}
		switch (oldCell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			newCell.setCellValue(oldCell.getStringCellValue());
			break;
		case Cell.CELL_TYPE_NUMERIC:
			newCell.setCellValue(oldCell.getNumericCellValue());
			break;
		case Cell.CELL_TYPE_BLANK:
			newCell.setCellType(Cell.CELL_TYPE_BLANK);
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			newCell.setCellValue(oldCell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_ERROR:
			newCell.setCellErrorValue(oldCell.getErrorCellValue());
			break;
		case Cell.CELL_TYPE_FORMULA:
			newCell.setCellFormula(oldCell.getCellFormula());
			break;
		default:
			break;
		}
	}

	public static CellRangeAddress getMergedRegion(Sheet sheet, int rowNum, short cellNum) {
		for (int i = 0; i < sheet.getNumMergedRegions(); i++) {
			CellRangeAddress merged = sheet.getMergedRegion(i);
			if (merged.isInRange(rowNum, cellNum)) {
				return merged;
			}
		}
		return null;
	}

	private static boolean isNewMergedRegion(CellRangeAddressWrapper newMergedRegion, Set<CellRangeAddressWrapper> mergedRegions) {
		return !mergedRegions.contains(newMergedRegion);
	}

	public static ExcelData parse(File file, final Class clazz, final String[][] mappings)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		final ExcelUtil instance = new ExcelUtil();
		final List res = new ArrayList(1000);
		ExcelHeader header = instance.execute(file, new ExcelDataCallback() {
			@Override
			public void rowAt(ExcelHeader header, int rowNo, Object[] cellDatas) 
					throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
				res.add(instance.convertCellToObjectByColumn(header, 0, clazz, mappings, cellDatas));
			}
		});

		return new ExcelData(header, res);
	}

	public ExcelHeader execute(File file, ExcelDataCallback excelDataCallback)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Sheet sheet = loadExcelFile(file).getSheetAt(0);
		int rowCount = sheet.getPhysicalNumberOfRows();
		int maxCellCount = countMaxCellCountWithBlank(sheet, rowCount);

		if (log.isInfoEnabled()) {
			log.debug("##################################################################### rowCount : {}", rowCount);
			log.debug("##################################################################### maxCellCount : {}", maxCellCount);
		}

		String[][] headers = new String[1][maxCellCount];

		for (int k = 0; k < maxCellCount; k++) {
			headers[0][k] = String.valueOf(k + 1);

		}
		ExcelHeader header = new ExcelHeader(headers);

		for (int i = 1; i < rowCount; i++) {
			Row row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Object[] values = getRowCellsData(row, maxCellCount);
			excelDataCallback.rowAt(header, i, values);
		}

		return header;
	}

	private int countMaxCellCountWithBlank(Sheet sheet, int rowCount) {
		int max = 0;
		for (int i = 0; i < rowCount; i++) {
			if (sheet.getRow(i) == null) {
				continue;
			}
			max = Math.max(max, sheet.getRow(i).getLastCellNum());
		}
		return max;
	}
	
	@SuppressWarnings("unused")
	public static ArrayList<String> getHeaderList(File file) {
		Workbook wb = null;
		ArrayList<String> headerData = new ArrayList<String>();

		try {
			wb = WorkbookFactory.create(new FileInputStream(file));
		} catch (Exception ex) {
			throw new IllegalArgumentException(ex);
		}

		if (StringUtil.isNotEmpty(wb)) {
			Sheet sheet = wb.getSheetAt(0);
			Row row = sheet.getRow(0);
			Iterator<Cell> cellIterator = row.cellIterator();

			while (cellIterator.hasNext()) {
				Cell cell = cellIterator.next();
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_NUMERIC:
					headerData.add(String.valueOf(cell.getNumericCellValue()));
					break;
				case Cell.CELL_TYPE_STRING:
					headerData.add(cell.getStringCellValue());
					break;
				default:
					break;
				}
			}
		}
		return headerData;
	}

}
