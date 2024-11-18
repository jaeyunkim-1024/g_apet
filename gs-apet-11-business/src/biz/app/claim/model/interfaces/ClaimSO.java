package biz.app.claim.model.interfaces;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimSO.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimSO extends BaseSearchVO<ClaimSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Long ordDtlSeq;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 클레임 유형 코드 배열 */
	private String[] clmTpCds;
	
	/** 클레임 상세 상태 코드 : 배열 */
	private String[] clmDtlStatCds;
	
	/** 시작 일시 : Start */
	private Timestamp clmAcptDtmStart;

	/** 종료 일시 : End */
	private Timestamp clmAcptDtmEnd;

	/** 배송 지시 일시 : Start */
	private Timestamp dlvrCmdDtmStart;

	/** 배송 지시 일시 : End */
	private Timestamp dlvrCmdDtmEnd;
	
	/** 사이트 ID */
	private Long stId;

	/** 검색 조건 : 상품정보 */
	private String searchKeyGoods;

	/** 검색 값 : 상품정보 */
	private String searchValueGoods;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 하위 업체 번호 */
	private Long lowCompNo;
	
	/** 업체 번호 - 하위업체까지 같이 조회 */
	private Long compNoWithLowComp;
	
	/** 클레임상세상태 */
	private String clmDtlStatCd;
	
	/** 클레임 상세유형코드 */
	private String clmDtlTpCd;

	/** 회원 번호 */
	private Long mbrNo;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 이메일 */
	private String ordrEmail;

	/** 클레임 상세 순번 */
	private Long clmDtlSeq;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/** 기간별 검색 */
	private String period;

}