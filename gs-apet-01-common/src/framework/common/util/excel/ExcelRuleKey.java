package framework.common.util.excel;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

public final class ExcelRuleKey {

	private ExcelRuleKey() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}
	static final String TABLE_COUNT = "tablecount";
	static final String TABLE = "table";
	static final String RESULT_CODE_COLUMN = "resultCodeColumn";
	static final String RESULT_CODE_VALUE = "resultCodeValue";
	static final String RESULT_MSG_COLUMN = "resultMsgColumn";
	static final String PKS = "pks";
	static final String REQURIED_COLUMNS = "requriedColumns";
	static final String ATTRIBUTE = "attribute";
}
