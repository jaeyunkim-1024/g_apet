package framework.common.util.excel;

import java.util.ArrayList;
import java.util.List;
import lombok.Data;

/**
 * ExcelUtil에서 엑셀 파일을 읽어낸 정보를 모아서 제공하기ㅣ 위한 holder 객체
 * 
 * @author valueFactory
 * @since 2016. 05. 19.
 */
@Data
@SuppressWarnings("rawtypes")
public class ExcelData {
	@SuppressWarnings("unchecked")
	public ExcelData(ExcelHeader header, List res) {
		this.excelHeader = header;
		//this.data = res;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.data = new ArrayList<>();
		if(res != null) {
			this.data.addAll(res);
		}
	}

	private ExcelHeader excelHeader;
	private List data;
}
