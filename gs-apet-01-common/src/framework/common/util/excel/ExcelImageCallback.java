package framework.common.util.excel;

import java.io.File;

public interface ExcelImageCallback<T> {
	public void rowAt(int rowNo, T data, File[] imageFiles);
}
