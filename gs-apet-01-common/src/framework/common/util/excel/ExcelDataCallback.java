package framework.common.util.excel;

import java.lang.reflect.InvocationTargetException;

/**
 * ExcelUtil에서 엑셀 파일을 읽어 각 행(row) 별로 callback 하기 위한 인터페이스
 * 
 * @author valueFactory
 * @since 2016. 05. 19.
 */
public interface ExcelDataCallback {
	public void rowAt(ExcelHeader header, int rowNo, Object[] cellDatas)
			throws InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException;
}
