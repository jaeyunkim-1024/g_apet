package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsDescCommPO.java
* - 작성일	: 2021. 1. 4.
* - 작성자	: valfac
* - 설명 		: 상품 설명 공통 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsDescCommPO extends BaseSysVO {

	/** 공통 상품 설명 번호 */
	private Long commGoodsDscrtNo;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 서비스 구분 코드 */
	private String svcGbCd;
	
	/** 영역 구분 코드 */
	private String showAreaGbCd;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 시작일자 */
	private Timestamp strtDt;
	
	/** 종료일자 */
	private Timestamp endDt;
	
	/** 내용 PC */
	private String contentPc;
	
	/** 내용 모바일 */
	private String contentMo;
}
