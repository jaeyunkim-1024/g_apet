package framework.common.util.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Calendar;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Sheet {

	private static final Charset XML_ENCODING = StandardCharsets.UTF_8;
	/*
	 * 한 시트에 최대 넣을 수 있는 데이터 Rows 수 설정 시 주의점 : 
	 * Title이나, 요소의 정보를 넣을 수 있으므로, 해당 값을 넣을 수 있는 Row는 이 값 설정할때 여유값으로 빼 줄것
	 * 원래대로라면 65535까지 가능 
	 * BO> 단품관리 메뉴의 전체 다운로드 기능 개선(엑셀파일 시트분리)에 의거 5만 라인으로 FIX
	 */
	public static final int MAXIMUM_ROW_CNTS_PER_ONE_SHEET = 50000;

	File tmpFile;
	Writer output;
	SpreadsheetWriter sheetWriter;
	int rows = 0;
	String sheetRef;

	public Sheet() {
		try {
			tmpFile = File.createTempFile("sheet", ".xml");
			log.debug("Temp Sheet File {}", tmpFile.getAbsolutePath());
			output = new OutputStreamWriter(new FileOutputStream(tmpFile), XML_ENCODING);
			sheetWriter = new SpreadsheetWriter(output);
			beginSheet();
		} catch (IOException e) {
			throw new IllegalStateException(e);
		}
	}

	public void beginSheet() {
		try {
			sheetWriter.beginSheet();
		} catch (IOException e) {
			throw new IllegalStateException(e);
		}
	}

	public void endSheet() {
		try {
			sheetWriter.endSheet();
			output.close();
		} catch (IOException e) {
			throw new IllegalStateException(e);
		} finally {//보안 진단. 부적절한 자원 해제 (IO)
			try {
				if(output != null) {
					output.close();
				}
			} catch (IOException e) {
				throw new IllegalStateException(e);
			}
			
		}
	}

	public void insertRow(int rowIndex) {
		try {
			sheetWriter.insertRow(rowIndex);
			updateRowCount(rowIndex);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public void insertRow() {
		insertRow(rows + 1);
	}

	private void updateRowCount(int rowIndex) {
		rows = Math.max(rows, rowIndex);
	}

	/**
	 * Insert row end marker
	 */
	public void endRow() {
		try {
			sheetWriter.endRow();
		} catch (IOException e) {
			throw new IllegalStateException(e);
		}
	}

	public void createCell(int columnIndex, String value, int styleIndex) {
		try {
			sheetWriter.createCell(columnIndex, value, styleIndex);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public void createCell(int columnIndex, String value) {
		try {
			sheetWriter.createCell(columnIndex, value);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public void createCell(int columnIndex, double value, int styleIndex) {
		try {
			sheetWriter.createCell(columnIndex, value, styleIndex);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public void createCell(int columnIndex, double value) {
		try {
			sheetWriter.createCell(columnIndex, value);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public void createCell(int columnIndex, Calendar value, int styleIndex) {
		try {
			sheetWriter.createCell(columnIndex, value, styleIndex);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	public boolean isFull() {
		return rows >= MAXIMUM_ROW_CNTS_PER_ONE_SHEET;
	}

	public void setSheetRef(String sheetRef) {
		this.sheetRef = sheetRef.substring(1);
	}
}
