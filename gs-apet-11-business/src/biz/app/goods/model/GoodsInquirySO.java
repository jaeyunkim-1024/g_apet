package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsInquirySO.java
* - 작성일		: 2016. 4. 7.
* - 작성자		: snw
* - 설명		: 상품문의 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsInquirySO extends BaseSearchVO<GoodsInquirySO>{

	private static final long serialVersionUID = 1L;

	/* 상품 아이디 */
	private String	goodsId;

	/** 문의자 회원 번호 */
	private Long eqrrMbrNo;

	// 추가[BO]
	/* 상품 문의 번호 */
	private Long goodsIqrNo;
	/* 상품아이디 검색 */
	private String goodsIdArea;
	/* 상품아이디 배열 */
	private String[] goodsIds;
	/* 등록 시작일시 */
	private Timestamp sysRegDtmStart;
	/* 등록 종료일시 */
	private Timestamp sysRegDtmEnd;
	/* 업체번호 */
	private String compNo;
	/* 하위업체번호 */
	private String lowCompNo;
	/* 문의자 아이디 */
	private String eqrrId;
	/* 상품 문의 상태 코드 */
	private String goodsIqrStatCd;
	/* 답변자 명*/
	private	String rplrNm;
	/* 답변자 사용자 번호*/
	private	Long rplrUsrNo;
	/* 전시 여부 */
	private String dispYn;
	/* 로그인 아이디 */
	private String loginId;
	/* 사이트 아이디 */
	private Long stId;
	/* 비밀글 여부 */
	private String hiddenYn;

	/* 검색 기간 */
	private String period;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;
}