package framework.common.util.excel;

/**
 * ExcelUtil에서 엑셀 파일을 읽어 각 행(row) 별로 callback 하기 위한 인터페이스
 * 
 * @author valueFactory
 * @since 2016. 05. 19.
 */
public interface ExcelCallback {
	public void rowAt(int rowNo, Object[] cellDatas);
}
