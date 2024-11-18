package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsCommentVO.java
* - 작성일		: 2016. 4. 7.
* - 작성자		: snw
* - 설명		: 상품평가 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/* 상품 평가 번호 */
	private Long	goodsEstmNo;
	/* 상품 아이디 */
	private String	goodsId;
	/* 제목 */
	private String	ttl;
	/* 내용 */
	private String 	content;
	/* 펫로그 내용 */
	private String 	dscrt;
	/* 평가 점수 */
	private Integer estmScore;
	/* 평가 회원 번호 */
	private Long	estmMbrNo;
	/* 평가 회원 ID */
	private String	estmMbrId;
	
	/* 평가 회원 명 */
	private String mbrNm;

	/* 상품평 유형 */
	private String	goodsEstmTp;

	/* 상품평 유형명 */
	private String	goodsEstmTpNm;

	/* 평가 회원 아이디 */
	private String 	estmId;
	/* 이미지 등록 여부 */
	private String	imgRegYn;
	/* 추천 여부 */
	private String	rcomYn;
	/* 조회수 */
	private Integer	hits;

	/** 상품 평가 이미지 List VO */
	private List<GoodsCommentImageVO> goodsCommentImageList;

	/** 상품 정보  */
	/* 상품 명 */
	private String	goodsNm;
	/* 브랜드 명 국문 */
	private String	bndNmKo;
	/* 브랜드 명 영문 */
	private String	bndNmEn;



	private String loginId;

	private String sysDelYn;
	private String sysDelRsn;

	/* 펫 번호 */
	private String petNo;

	/* 베스트 설정 */
	private String bestYn;

	/* 전시 여부 */
	private String dispYn;

	/* 제제 */
	private String snctYn;

	/* 제재 알럿 메시지 */
	private String snctRsn;

	/* 좋아요 개수 */
	private String estmActnLke;

	/* 신고 개수 */
	private String estmActnRpt;

	/* 이미지 순번  */
	private Integer imgSeq;
	/* 이미지 경로  */
	private String imgPath;
	/* 이미지 경로s */
	private String[] imgPaths;
	
	

	/* 상품 이미지 순번  */
	private Integer goodsImgSeq;
	/* 상품 이미지 경로  */
	private String goodsImgPath;

	/* 홍보문구  */
	private String prWds;

	/* 댓글갯수  */
	private String commentCnt;

	/* 판매금액  */
	private Integer saleAmt;

	/* 할인금액  */
	private Integer dcAmt;

	/* 사이트 아이디 */
	private Integer stId;

	/* 사이트 명 */
	private String stNm;

	private String compNm;
	
	/* 주문번호 */
	private String ordNo;
	
	/* 주문상세순번 */
	private String ordDtlSeq;

	private Long rowNum;

	/* 펫 정보 */
	private String petNm;
	private String petGdGbCd;
	private Integer age;
	private Double weight;
	/* 펫 구분 코드 */
	private String petGbCd;
	/* 펫 종류 명 */
	private String petKindNm;
	/* birth */
	private String birth;
	/* month */
	private String month;
	/* 알려지 여부 */
	private String allergyYn;
	/* 중성화 여부 */
	private String fixingYn;
	/* 염려 질환 여부 */
	private String wryDaYn;
	
	/* 회원 상태 코드 */
	private String mbrStatCd;
	
	/** 추가 */
	/* 상품 평가 답변 리스트 */
	private List<GoodsEstmQstVO> goodsEstmQstVOList;
	private List<GoodsCommentScoreVO> goodsCommentScoreVOList;

	/* 상품 평가 수 */
	private Integer scoreTotal;
	/* 상품 평가 평균 */
	private Double estmAvg;
	/* 상품 평가 평균 0.5단위 반올림 */
	private Double estmAvgStar;
	/* 좋아요 수 */
	private Integer likeCnt;
	/* 닉네임 */
	private String nickNm;
	/* 프로필 이미지 */
	private String prflImg;
	
	/* 이미지 팝업용 선택한 이미지 경로 */
	private String clickImgPath;
	
	/** 구성 노출 명 */
	private String cstrtShowNm;

	/** 구성 유형 코드 */
	private String goodsCstrtTpCd;

	/** 묶음 상품 아이디 */
	private String pakGoodsId;
	/** 묶음 상품 명 */
	private String pakGoodsNm;
	
	private Timestamp ordAcptDtm;
	
	/** 옵션 상품 옵션값 */
	private String attrVal;

    /*펫로그 번호*/
    private Long petLogNo;

    /*펫로그 이미지 경로 전체*/
    private String imgPathAll;
    private String[] imgPathList;
    /*펫로그 영상 경로 */
    private String vdPath;
}
