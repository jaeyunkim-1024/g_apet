package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsInquiryVO.java
* - 작성일		: 2016. 3. 21.
* - 작성자		: snw
* - 설명		: 상품문의  Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsInquiryVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/* 상품 문의 번호 */
	private Long		goodsIqrNo;
	/* 상품 아이디 */
	private String		goodsId;
	/* 상품 문의 상태 코드 */
	private String		goodsIqrStatCd;
	/* 문의 제목*/
	private String		iqrTtl;
	/* 문의 내용 */
	private String		iqrContent;
	/* 문의자 회원 번호 */
	private Long		eqrrMbrNo;
	/* 문의자 명 */
	private String		eqrrNm;
	/* 문의자 아이디 */
	private String		eqrrId;
	/* 문의자 닉네임 */
	private String		nickNm;
	/* 문의자 휴대폰 */
	private String		eqrrMobile;
	/* 문의자 이메일 */
	private String		eqrrEmail;
	/* 답변 내용*/
	private	String		rplContent;
	/* 답변자 사용자 번호*/
	private	Long		rplrUsrNo;
	/* 답변자 명*/
	private	String		rplrNm;
	/* 답변 일시 */
	private	Timestamp	rplDtm;
	/* 상위 상품 문의 번호 */
	private Long upGoodsIqrNo;
	/* 사용자 그룹 코드 */
	private	String		usrGrpCd;
	/* 비밀글 여부 */
	private String 		hiddenYn;
	/* 답변 알림 수신 여부 */
	private String      rplAlmRcvYn;
	
	/* 상품 문의 이미지 리스트 */
	private List<GoodsIqrImgVO> goodsIqrImgList;

	/** GOODS_INQUIRY Table 외 추가 정보 */
	/* 상품 명 */
	private String		goodsNm;
	/* 브랜드 번호 */
	private Integer		bndNo;
	/* 브랜드 명 국문 */
	private String		bndNmKo;
	/* 브랜드 명 */
	private String		bndNm;

	// 추가[BO]
	/* 전시 여부 */
	private String dispYn;
	/*업체코드*/
	private String compNo;
	/* 업체명 */
	private String compNm;
	/* 비고 */
	private String bigo;
	/* 답변 내용 머리말 */
	private String rplContentHeader;
	/* 답변 내용 맺음말 */
	private String rplContentFooter;
	/* 답변 전체 내용 */
	private String rplContentFull;
	/* 상품 문의 상태명 */
	private String iqrStatNm;
	
	/* 이미지 순번 */
	private Long imgSeq;
	/* 이미지 경로 */
	private String imgPath;
	
	/* 사이트 아이디 */
	private Long stId;
	/* 사이트 명 */
	private String stNm;

	/** 이미지 경로 배열 */
	private String[] imgPaths;
	/** 이미지 번호 배열 */
	private Long[] imgSeqs;
}
