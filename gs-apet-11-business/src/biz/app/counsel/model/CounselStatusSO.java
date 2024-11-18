package biz.app.counsel.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselStatusSO.java
* - 작성일		: 2017. 6. 27.
* - 작성자		: Administrator
* - 설명			: 상담 요약정보 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselStatusSO extends BaseSearchVO<CounselStatusSO> {

	private static final long serialVersionUID = 1L;

	private Long 	mbrNo;
	
	private String 	name;
	
	private String 	tel;
	
	private String 	mobile;
	
	private Long		stId;
	
	private Timestamp acptDtmStart;
	
	private Timestamp 	acptDtmEnd;
}
