package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerItemVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;
	
	/** 배너 제목*/
	private String bnrTtl;
	
	/** 배너 번호*/
	private String bnrNo;
	
	/** 배너 아이디*/
	private String bnrId;
	
	/** 사이트 아이디*/
	private String stId;
	
	/** 사용 여부*/
	private String useYn;
	
	/** 영상 제목*/
	private String vdTtl;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 삭제 여부 */
	private String delYn;

	/** 상품평 번호 */
	private Long goodsEstmNo;

	/** 상품 번호 */
	private String goodsId;

	/** 상품 TEXT */
	private String goodsText;

	/** 영상 ID*/
	private String vdId;
	
	/** 전시 배너 번호 */
	private Long dispBnrNo;

	/** 배너 HTML */
	private String bnrHtml;

	/** 상품명 */
	private String goodsNm;

	/** 상품평 제목 */
	private String ttl;

	/** 상품평 내용 */
	private String content;

	/** 회원 ID */
	private String estmId;

	/** 이미지 여부 */
	private String imgRegYn;

	/** 이미지 경로 */
	private String imgPath;

	/** 반전 이미지 경로 */
	private String rvsImgPath;

	private Integer imgSeq;

	/** 조회수 */
	private Integer hits;

	/** 아이템 번호 */
	private Long dispCnrItemNo;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 업체명 */
	private String compNm;

	/** 브랜드 명 국문 */
	private String bndNmKo;
	
	/** 관련 컨텐츠 수 */
	private String rltCntsCnt;

	/** 관련 태그 수 */
	private String rltTagCnt;
	

	/** 제조사 */
	private String mmft;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 노출여부 */
	private String showYn;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 판매 금액 */
	private Long saleAmt;

	/** 할인 금액 */
	private Long dcAmt;

	/** 배너 TEXT */
	private String bnrText;

	/** 배너 이미지 명 */
	private String bnrImgNm;

	/** 배너 이미지 경로 */
	private String bnrImgPath;

	/** 배너 모바일 이미지 명 */
	private String bnrMobileImgNm;

	/** 배너 모바일 이미지 경로 */
	private String bnrMobileImgPath;

	/** 기본 배너 여부 */
	private String dftBnrYn;

	/** 배너 LINK URL */
	private String bnrLinkUrl;

	/** 배너 모바일 LINK URL */
	private String bnrMobileLinkUrl;

	/** 배너 모바일 PC_WEB_URL */
	private String  pcwebUrl;

	/** 위시리스트 추가여부 */
	private String interestYn;

	/************** mobile 용 추가분 ************************/
	/** 재고관리 여부 */
	private String stkMngYn;
	
	/** 재고 수량 노출 여부 */
	private String stkQtyShowYn;

	/** 웹 재고 수량 */
	private Long webStkQty;

	/** 상품 홍보문구 노출여부 */
	private String prWdsShowYn;

	/** 상품 홍보문구 */
	private String prWds;

	private Integer commentCnt;	//상품평 수
	
	/** 시리즈 번호 */
	private Integer srisNo;
	
	/** 시즌 번호 */
	private Integer sesnNo;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 좋아요수 */
	private Integer likeCnt;
	
	/** 공유 수 */
	private Integer shareCnt;
	
	/** 댓글수 */
	private Integer replyCnt;
	
	/** 썸네일 이미지 */
	private String thumPath;
	
	/** 시리즈 명 */
	private String srisNm;
	
	/** 시즌 명 */
	private String sesnNm;

	/** 전시 코너 명 */
	private String dispCornNm;

	private String soldOutYn;
	private String newYn;
	private String bestYn;
	private String couponYn;
	private String freeDlvrYn;
	private String freebieYn;
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 회원 구분 코드 */
	private String mbrGbCd;
	
	/** 펫로그  URL */
	private String petLogUrl;
	
	/** 단축 경로 */
	private String srtPath;
	
	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 펫로그 수 */
	private Integer petLogCnt;

	/** 시리즈 아이디*/
	private String srisId;
	
	/** 시리즈 설명*/
	private String srisDscrt;
	
	/** 시리즈 타입명 */
	private String tpNm;
	
	/** 시리즈 프로필 이미지 경로 */
	private String srisPrflImgPath;
	
	/** 시즌 수  */
	private Long sesnCnt;

	/** 태그 네임 */
	private String tagNm;
	
	/** 등록수정일 */
	private String regModDtm;
}