package biz.app.claim.model;

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

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 시작 일시 : Start */
	private Timestamp clmAcptDtmStart;

	/** 종료 일시 : End */
	private Timestamp clmAcptDtmEnd;

	/** 사이트 ID */
	private Long stId;

	/** 검색 조건 : 상품정보 */
	private String searchKeyGoods;

	/** 검색 값 : 상품정보 */
	private String searchValueGoods;

	/** 검색 조건 : 주문정보 */
	private String searchKeyOrder;

	/** 검색 값 : 주문정보 */
	private String searchValueOrder;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 하위 업체 번호 */
	private Long lowCompNo;
	
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

	/** 상품 명 */
	private String goodsNm;

	/** 로우 보여줄지 말지 ... 삭제내역 안보이도록 */
	private String ordrShowYn;

///////////////// 미확인 ///////////////////////////////////////


	/** 주문자 이메일 */
	private String ordrEmail;

	/** 클레임 상세 순번 */
	private Long clmDtlSeq;


	/** 기간별 검색 */
	private String period;
	
	/** 업체 유형 코드 배열 */
	private String[] arrCompTpCd;
	
	/** 배송 처리 유형 코드 배열 */
	private String[] arrDlvrPrcsTpCd;
	
	/** 환불상태 배열 */
	private String[] arrPayStatCd;
}