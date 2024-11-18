package biz.app.estimate.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.order.model
* - 파일명		: CartVO.java
* - 작성일		: 2016. 4. 26.
* - 작성자		: snw
* - 설명		: 장바구니 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EstimateVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 견적 번호 */
	private Integer estmNo;
	
	/** 견적 일자 */
	private String estmDt;
	
	/** 대상 명 */
	private String tgNm;
	
	/** 전화 */
	private String tel;
	
	/** 이메일 */
	private String email;
	
	/** 배송 요청 일자 */
	private String dlvrReqDt;
	
	/** 회원 번호 */
	private Integer mbrNo;
	
	/** 회원명 */
	private String mbrNm;
}