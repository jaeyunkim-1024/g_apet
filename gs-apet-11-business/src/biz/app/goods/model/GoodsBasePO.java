package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 명 */
	private String goodsNm;
	
	/** 업체 상품명 */
	private String compGoodsNm;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 고시 아이디 */
	private String ntfId;

	/** 모델 명 */
	private String mdlNm;

	/** 업체 번호 */
	private Long compNo;

	/** 키워드 */
	private String kwd;

	/** 원산지 */
	private String ctrOrg;

	/** 최소 주문 수량 */
	private Long minOrdQty;

	/** 최대 주문 수량 */
	private Long maxOrdQty;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 배송 방법 코드 */
	private String dlvrMtdCd;

	/** 배송 정책 번호 */
	private Long dlvrcPlcNo;

	/** 업체 정책 번호 */
	private Long compPlcNo;

	/** 홍보 문구 */
	private String prWds;

	/** 무료 배송 여부 */
	private String freeDlvrYn;

	/** 수입사 */
	private String importer;

	/** 제조사 */
	private String mmft;

	/** 과세 구분 코드 */
	private String taxGbCd;

	/** 재고 관리 여부 */
	private String stkMngYn;

	/** MD 사용자 번 */
	private Long mdUsrNo;

	/** 인기 순위 */
	private Long pplrtRank;

	/** 인기 설정 코드 */
	private String pplrtSetCd;

	/** 사이트 아이디 */
	private Long stId;

	/** 상품 아이디 */
	private String goodsId;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 노출 여부 */
	private String showYn;

	/** 업체 상품 아이디 */
	private String compGoodsId;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 반품 가능 여부 */
	private String rtnPsbYn;

	/** 반품 메세지 */
	private String rtnMsg;

	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 대표 동영상 link url */
	private String vdLinkUrl;

	/** 인터페이스 api key 로 들어온 업체 번호 */
	private Long interFaceCompNo;
	
	private String[] goodsIds;
	
	/** 수수료 율 */
	private Double cmsRate;

	/** 공급금액 */
	private Long splAmt;
	
	/** 주문제작여부 */
	private String ordmkiYn;
	
	/** SEO 정보 번호 */
	private Long seoInfoNo;
	
	/** 속성 노출 유형 - 00:일반 10:콤보박스 20:콤포넌트 */
	private String attrShowTpCd;
	
	/** 상품 구성 유형 - ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음 */
	private String goodsCstrtTpCd;
	
	/** 상품평 전시 분류 번호*/
	private Long goodsEstmDispClsfNo;

	/** 품절 상품 노출 여부 */
	private String ostkGoodsShowYn;

	/** 재고 수량 노출 여부 */
	private String stkQtyShowYn;
	
	/** 네이버 제휴 상품 여부 */
	private String naverAffiGoodsYn;
	
	/** 최초 상품 아이디 */
	private String fstGoodsId;
	
	/** 성분 정보 연동 여부 */
	private String igdtInfoLnkYn;
	
	/** 유통기한 관리 여부 */
	private String expMngYn;
	
	/** 유통기한 월 */
	private String expMonth;
	
	/** MD 추천 문구 */
	private String mdRcomWds;
	
	/** MD 추천 여부 */
	private String mdRcomYn;
	
	/** check point 메시지 */
	private String checkPoint;
	
	/** 펫 구분 코드		10 : 강아지, 20 : 고양이, 40 : 관상어, 50 : 소동물 */
	private String petGbCd;
	
	/** 매입 업체 번호 */
	private Long phsCompNo;
	
	/** 매입 업체 이름 */
	private String phsCompNm;
	
	/** 상세 속성 노출 여부 */
	private String attrShowYn;

	/** 재입고 여부 */
	private String ioAlmYn;
	
	/** SHOPLINKER 전송 여부 */
	private String shoplinkerSndYn;
	
	/** TWC 전송 여부 */
	private String twcSndYn;
	
	/** CIS 번호 */
	private Integer cisNo;
	
	/** 단품 번호 */
	private Long itemNo;

	private String clctReqPsbYn;			// 수거 요청 가능 여부
	private String cusReqGoodsYn;			// 상담 문의 상품 여부
	private String prcCmprLnkYn;			// 가격 비교 연동 여부

	private String goodsUpdateGb;
	
	/** 회원 구분 */
	private String compGbCd;
	
	/** 단품 재고 */
	private Integer defatultItemStockCount;
	
	/** 상품 상태 코드_시스템_여부 */
	private String goodsStatCdSysYn;
	
	/** 표준코드 */
	private String prdStdCd;
	
}