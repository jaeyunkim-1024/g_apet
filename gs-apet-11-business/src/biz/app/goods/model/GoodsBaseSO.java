package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.model
* - 파일명		: GoodsBaseSO.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 상품 기본 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBaseSO extends BaseSearchVO<GoodsBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;
	
	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 고시 아이디 */
	private String ntfId;

	/** 모델 명 */
	private String mdlNm;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 하위 업체 번호 */
	private Long lowCompNo;

	/** 업체 명 */
	private String compNm;

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

	/** 브랜드 명 국문 */
	private String bndNmKo;

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

	/** MD 사용자 번호 */
	private Long mdUsrNo;

	/** 인기 순위 */
	private Long pplrtRank;

	/** 인기 설정 코드 */
	private String pplrtSetCd;

	/** 사이트 아이디 */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 매장 번호 */
	private Long strNo;

	/** 카테고리 번호 */
	private Long ctgNo;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;

	/** 노출여부 */
	private String showYn;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 대표 브랜드 번호 */
	private Long dlgtBndNo;

	/** 추가분 */
	private String goodsIdArea;
	private String[] goodsIds;
	private String goodsNmArea;
	private String[] goodsNms;
	private String compGoodsIdArea;
	private String[] compGoodsIds;
	private String mdlNmArea;
	private String[] mdlNms;
	private String bomCdArea;
	private String[] bomCds;
	private String itemNoArea;
	private Long[] itemNos;

	private String goodsUpdateGb;
	private Long dispClsfNo;	//전시분류번호
	private Long upDispClsfNo;
	private Long srDispClsfNo;	//쇼룸 전시 분류 번호
	private String srchWord;	//검색어
	private String prevSrchWord;	//재검색시 이전 검색어

	private int searchCondCnt;		//상세 검색 - 검색조건 갯수
	private String priceFrom;		//상세 검색 - 금액 시작 - 화면용
	private String priceTo;			//상세 검색 - 금액 종료 - 화면용
	private int priceFromInt;		//상세 검색 - 금액 시작 - 쿼리용
	private int priceToInt;			//상세 검색 - 금액 종료 - 쿼리용
	private String benefit;			//상세 검색 - 혜택 코드 - 화면용
	private String style;			//상세 검색 - 스타일 코드 - 화면용
	private String[] styles;		//상세 검색 - 스타일 코드 - 쿼리용
	private String category;		//상세 검색 - 카테고리 코드 - 화면용
	private String[] categorys;		//상세 검색 - 카테고리 코드 - 쿼리용
	private String brand;			//상세 검색 - 브랜드 코드 - 화면용
	private String[] brands;		//상세 검색 - 브랜드 코드 - 쿼리용
	private String brandName;		//상세 검색 - 브랜드명	 - 화면용

	/** 판매 금액 */
	private Long saleAmt;
	/** 원가 금액 */
	private Long costAmt;

	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;

	/** 신상품 여부 */
	private String newYn;

	private Long[] dispClsfNos;	//전시분류번호
	private List<String> webMobileGbCds;
	private String webMobileGbCd;
	private Long mbrNo;

	private String[] goodsStatCds;

	/** 비정형매장 상품 조회 */
	private Long atpcDispClsfNo;
	private Long dispCornNo;
	private Long dlgtDispClsfNo;

	private Long dispCornNoNew;
	private Long dispCornNoBest;

	/** 세일상품 가격변경일자 */
	private Timestamp saleUpdateEndDate;

	/** 총 카운트 */
	private Long cntTotal;

	/** 성공 카운트 */
	private Long cntSuccess;

	/** 실패 카운트 */
	private Long cntFail;

	/** 사이트아이디들 */
	private String[] stIds;

	/** 상품유형-goodsTpCd SELECT BOX 편집 가능 여부 */
	private Boolean disableAttrGoodsTpCd;

	/** 집계 구분 코드 */
	private String sumGbCd;

	private Integer limitCount;

	/** 메뉴구분(브랜드) */
	private String ctgGb;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;

	/** 상품검색할 때 정렬 기준 */
	private String goodsOrderingTpCd;

	/** 수수료율  */
	private Double cmsRate;

	private String adminYn;
	private Long adminNo;

	private String goodsAmtTpCd;

	/** 판매기간 종료상품 여부 */
	private String endSaleYn;

	/** 삭제 여부 */
	private String delYn;

	/** 품절 여부 */
	private String soldOutYn;

	/** 상품상세 연관상품 추가 팝업 자기자신 제외용 goodsId by pkt on 20200115 */
	private String eptGoodsId;

	private String prdtCdArea;

	/** 제외 업체 구분 코드 */
	private String excludeCompGbCd;

	/** 상품 구성 유형 코드 배열 */
	private String[] goodsCstrtTpCds;
	
	/** 상품 구성 유형 코드 */
	private String goodsCstrtTpCd;
	
	/** 상품 아이콘 */
	private String[] goodsIconCd;
	
	/** 사은품 가능 여부 */
	private String frbPsbYn;
	private String attrYn; //Y

	/** 상품 태그 */
	private String[] tags;

	/** 엑셀 다운로드 타입 */
	private String excelType;

	/** 가격 유형 시작 일시 */
	private Timestamp priceStrtDt;

	/** 가격 유형 종료 일시 */
	private Timestamp priceEndDt;

	private String exhbtGbCd;
	
	/** 상품 상태 코드_시스템_여부 */
	private String goodsStatCdSysYn;
	
	private String[] twcDispClsfNos;

	private String cdnUrl;

	private String[] compTpCds;

	private String dlgtGoodsId;

	/** 최초 상품 아이디 */
	private String fstGoodsId;
	
	/** App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다. */
	private String callParam;
}