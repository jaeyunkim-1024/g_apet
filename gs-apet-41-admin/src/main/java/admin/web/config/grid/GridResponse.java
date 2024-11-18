package admin.web.config.grid;

import framework.common.model.BaseSearchVO;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.config.grid
* - 파일명		: GridResponse.java
* - 작성일		: 2016. 7. 1.
* - 작성자		: valueFactory
* - 설명			: Grid Response
* </pre>
*/
@Data
public class GridResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	public GridResponse(List<?> list, BaseSearchVO<?> vo) {
		this.total = vo.getTotalPageCount();
		this.page = vo.getPage();
		this.records = vo.getTotalCount();
		this.execSql = vo.getExecSql();
		this.cnctHistNo = vo.getCnctHistNo();
		this.inqrHistNo = vo.getInqrHistNo();
		this.data = list;
	}

	private Integer	total;		//전체페이지
	private Integer	page;		//현재페이지
	private Integer	records;	//전체데이터수

	private String execSql;		//실행 로그
	private Long cnctHistNo;	//이력 번호
	private Long inqrHistNo;	//이력 번호

	private List<?>	data;	//전체데이터

}