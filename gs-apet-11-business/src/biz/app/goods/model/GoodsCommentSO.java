package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsCommentSO.java
* - 작성일		: 2016. 4. 7.
* - 작성자		: snw
* - 설명		: 상품평가 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentSO extends BaseSearchVO<GoodsCommentSO>{

	private static final long serialVersionUID = 1L;

	/* 상품 아이디 */
	private String	goodsId;
	/* 이미지 등록 여부 */
	private String	imgRegYn;
	/* 추천 여부 */
	private String	rcomYn;
	/* 상품 평가 번호 */
	private Long goodsEstmNo;
	/* 평가 회원 번호 */
	private Long estmMbrNo;
	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;

	private String commentType;

	/** BestReview 검색조건 */
	private String searchType;
	private String searchString;
	private String searchOrderBy;

	/** 추가 */
	/** 업체 번호 */
	private Long compNo;
	/** 하위업체 번호 */
	private Long lowCompNo;
	private String estmId;
	private String sysDelYn;
	private String goodsIdArea;
	private String[] goodsIds;
	private String[] estmMbrNos;

	private Long[] goodsEstmNos;

	/** 사이트 아이디 */
	private Long stId;

	/** 작성회원 이름 */
	private String mbrNm;

	/** 작성회원 아이디 */
	private String loginId;

	/** PC/Mobile 구분 */
	private String webMobileGbCd;

	/** 상품 후기 평점 */
	private String estmScore;
	/** 상품 후기 유형 */
	private String goodsEstmTp;
	/** 상품 전시 여부 */
	private String dispYn;
	/** 상품 BEST 여부 */
	private String bestYn;
	/** 상품 전시 여부 */
	private String goodsCommentListView;
	/** 도움 건수 start */
	private String startLkeCnt;
	/** 도움 건수 end */
	private String endLkeCnt;
	/** 신고 접수 건수 */
	private String rptpCnt;
	/** 신고 사유 */
	private String rptpRsn;
	/** TAB 구분 */
	private String tabFlag;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/** 기간별 검색 */
	private String period;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;

	/** 시스템 등록자 번호 */
	private Long sysRegrNo;
	
	/** 상품 구성 유형 코드 */
	private String goodsCstrtTpCd;

	/* 주문번호 */
	private String ordNo;

	/* 주문상세순번 */
	private String ordDtlSeq;
	
	/* 옵션 상품 아이디 */
	private String optGoodsId;

    /*펫로그 번호*/
    private Long petLogNo;
	
	/*전체 조회 여부 */
    private String allSelectYn;
    
	/* 대표 상품 번호 */
    private String dlgtGoodsId;
}
