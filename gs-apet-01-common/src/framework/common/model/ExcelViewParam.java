package framework.common.model;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;

/**
 * excel view param
 * 
 * @author valueFactory
 * @since 2013. 07. 31.
 */
public class ExcelViewParam implements Serializable {

	private static final long serialVersionUID = 1L;

	@Getter
	private String		sheetName;

	@Getter
	private String[]	headerName;

	@Getter
	private String[]	fieldName;

	@Getter
	private String		codeYn;

	@Getter
	private List<? extends Object> dataList;

	public ExcelViewParam(String sheetName, String[] headerName, String[] fieldName, List<? extends Object> dataList) {
		this.sheetName = sheetName;
		
		//this.headerName = headerName;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.headerName = new String[headerName.length];
		for(int i=0; i<headerName.length; i++) {
			this.headerName[i] = headerName[i];
		}
		
		//this.fieldName = fieldName;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.fieldName = new String[fieldName.length];
		for(int j=0; j<fieldName.length; j++) {
			this.fieldName[j] = fieldName[j];
		}
		
		this.dataList = dataList;
	}

	public ExcelViewParam(String sheetName, String[] headerName, String[] fieldName, List<? extends Object> dataList, String codeYn) {
		this.sheetName = sheetName;
		
		//this.headerName = headerName;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.headerName = new String[headerName.length];
		for(int i=0; i<headerName.length; i++) {
			this.headerName[i] = headerName[i];
		}
				
		//this.fieldName = fieldName;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.fieldName = new String[fieldName.length];
		for(int j=0; j<fieldName.length; j++) {
			this.fieldName[j] = fieldName[j];
		}
				
		this.dataList = dataList;
		this.codeYn = codeYn;
	}

}