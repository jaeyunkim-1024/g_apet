package front.web.config.page;

import java.io.Serializable;

import framework.common.model.BaseSearchVO;
import lombok.Data;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.page
* - 파일명		: Paging.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
@Data
public class Paging implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Paging(BaseSearchVO<?> vo){
		this.page = vo.getPage();
		this.sidx = vo.getSidx();
		this.sord = vo.getSord();
		this.totalRecord = vo.getTotalCount();
		this.rows = vo.getRows();
	}

	String	sidx;	//정렬 컬럼
	String	sord;	//정렬방향
	Integer page;	//현재페이지
	Integer	totalRecord;	//전체 데이터 수
	Integer rows;	//페이지 당 데이터 수
}
