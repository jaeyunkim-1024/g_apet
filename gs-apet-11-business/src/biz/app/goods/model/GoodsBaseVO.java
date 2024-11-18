package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import framework.common.constants.CommonConstants;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import biz.app.pet.model.PetBaseVO;
import biz.app.st.model.StStdInfoVO;
import framework.admin.constants.AdminConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;
	
	/** 업체 상품명 */
	private String compGoodsNm;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 상품 상태 명칭 */
	private String goodsStatNm;

	/** 고시 아이디 */
	private String ntfId;

	/** 모델 명 */
	private String mdlNm;

	/** 업체 번호 */
	private Long compNo;

	/** 공급사 유형  */
	private String compTpCd;

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

	/** 대표상품 배송 정책 번호 */
	private Long dlgtSubDlvrcPlcNo;

	/** 업체 정책 번호 */
	private Long compPlcNo;

	/** 홍보 문구 */
	private String prWds;

	/** 무료 배송 여부 */
	private String freeDlvrYn;

	/** 대표상품 무료 배송 여부 */
	private String dlgtSubFreeDlvrYn;

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
	private String stId;

	/** 사이트 명 */
	private String stNm;

	/** 사이트 정보 */
	private List<StStdInfoVO> stStdList;


	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 판매기간 종료 여부 */
	private String salePeriodEndYn;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 명 영문 */
	private String bndNmEn;

	/** 브랜드 명  */
	private String bndNm;

	/** 핫딜용 원판매금액 */
	private Long orgAmt;

	/** 판매 금액 */
	private Long saleAmt;

	/** 할인 금액 */
	private Long dcAmt;

	/** 최종판매가 */
	private Long foSaleAmt;

	/** 쿠폰 금액 */
	private Long cpAmt;

	/** 이미지 경로 */
	private String imgPath;
	/** 상품 대표이미지 순번 */
	private Integer imgSeq;
	/** 반전 이미지 경로 */
	private String rvsImgPath;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;

	/** 노출여부 */
	private String showYn;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 업체 상품 아이디 */
	private String compGoodsId;

	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;

	/** 반품 가능 여부 */
	private String rtnPsbYn;

	/** 반품 메세지 */
	private String rtnMsg;
	
	/** 주문제작여부 */
	private String ordmkiYn;
	
	/** SEO 정보 번호 */
	private Long seoInfoNo;
	
	/** 속성 노출 유형 - 00: 일반 10:콤보박스 20:콤포넌트 */
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

	/** 펫 구분 코드
	 * 10 : 강아지, 20 : 고양이, 40 : 관상어, 50 : 소동물
	 */
	private String petGbCd;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 매입 업체 번호 */
	private Long phsCompNo;
	
	/** 매입 업체 이름 */
	private String phsCompNm;
	
	/** sku 코드 */
	private String skuCd;
	
	/** SHOPLINKER 전송 여부 */
	private String shoplinkerSndYn;
	
	/** TWC 전송 여부 */
	private String twcSndYn;
	
	/** 입고 알람 여부 */
	private String ioAlmYn;
	
	/** 웹재고수량 */
	private Integer webStkQty;
	
	/** 사은품 여부 */
	private String frbPsbYn;
	
	/** 단품번호 */
	private Long itemNo;
	
	/** CIS 번호 */
	private Integer cisNo;
	/** 유통기한 임박일자 */
	private String expDt;
	
	/** 상품 상태 코드_시스템_여부 */
	private String goodsStatCdSysYn;
	
	/** twc 전시 가능 카테고리 인지 확인 */
	private Boolean isTwcCategory;


	/** 추가분 */
	private String dispShowTpCd;	//전시 노출 타입
	private String compNm;
	private String soldOutYn;
	private String freebieYn;
	private String newYn;
	private String bestYn;
	private String couponYn;
	private Long cpNo;	//쿠폰 번호
	private String cpNm;	//쿠폰 명
	private String cpAplCd;	//쿠폰 적용 코드
	private Long aplVal;	//적용 값
	private Long dispClsfNo;		//전시 분류 번호
	private Long dispPriorRank;	//전시 우선 순위

	private Long commentCnt;	//상품평 수
	private String interestYn; //위시리스트 여부

	private Timestamp aplStrtDtm; /** 쿠폰 적용 시작 일시 */
	private Timestamp aplEndDtm;  /** 쿠폰 적용 종료 일시 */
	private String size; /** 규격 */
	private String goodsCstrtGbCd;
	private String cstrtGoodsId;
	private String eptGoodsId;		/** 상품상세 연관상품 추가 팝업 자기자신 제외용 goodsId by pkt on 20200115 */

	/** 상품 평가 문항 */
	private List<GoodsEstmQstVO> GoodsEstmQstVOList; 
	/** 사용자 펫 정보 리스트 */
	private List<PetBaseVO> petBaseVOList;
	/** 옵션상품 옵션명*/
	private String cstrtShowNm;
	
	/** 선택상품 옵션목록 */
	private String attrVals;
	
	
	/** 판매가능상태코드 */
	private String salePsbCd;
	
	/** 프로모션 번호 */
	private Long 	prmtNo;

	/** 프로모션 할인 금액 */
	private Long	prmtDcAmt;

	/** 대표 동영상 link url */
	private String vdLinkUrl;

	/** 상품금액유형코드 */
	private String goodsAmtTpCd;

	/** 현재가격 판매 시작 일시 */
	private Timestamp priceSaleStrtDtm;

	/** 현재가격 판매 종료 일시 */
	private Timestamp priceSaleEndDtm;

	/** 성공여부 **/
	private String resultYN;
	/** 결과메세지 **/
	private String resultMsg;
	
	/** 관리자 여부 **/
	private String adminYn;

	/** 사이트 아이디 전체 */
	public String getStIds() {
		if (hasManySite()) {
			List<String> stIds = new ArrayList<String>();
			for(StStdInfoVO st : this.stStdList) {
				stIds.add(st.getStId().toString());
			}

			return StringUtils.join(stIds.iterator(), "|");
		} else {
			return getFirstStId();
		}
	}

	/** 사이트 명 전체 */
	public String getStNms() {
		if (hasManySite()) {
			List<String> stNms = new ArrayList<String>();
			for(StStdInfoVO st : this.stStdList) {
				stNms.add(st.getStNm());
			}

			return StringUtils.join(stNms.iterator(), " | ");
		} else {
			return getFirstStNm();
		}
	}

	private boolean hasManySite() {

		return CollectionUtils.isNotEmpty(this.stStdList) && CollectionUtils.size(this.stStdList) > 1;
	}

	private String getFirstStId() {
		if (CollectionUtils.isEmpty(this.stStdList) || CollectionUtils.sizeIsEmpty(this.stStdList)) {
			return StringUtils.EMPTY;
		}

		return this.stStdList.get(0).getStId().toString();
	}

	private String getFirstStNm() {
		if (CollectionUtils.isEmpty(this.stStdList) || CollectionUtils.sizeIsEmpty(this.stStdList)) {
			return StringUtils.EMPTY;
		}

		return this.stStdList.get(0).getStNm();
	}

	/** 편집가능 여부 */
	public boolean isEditable() {
		boolean editable = false;

		if (StringUtils.isEmpty(this.goodsStatCd) || StringUtils.equals(this.goodsStatCd, AdminConstants.GOODS_STAT_10)) {
			editable = true;
		}

		return editable;
	}

	private Long goodsPrcNo;

	/** 공급 금액 */
	private Long splAmt;
	/** 정상 금액 */
	private Long orgSaleAmt;
	private Long orgSalePrc;
	private Long priceOrdQty;
	

	/** 가격테이블의 판매 종료 일시 */
	private Timestamp maxSaleEndDtm;

	/** 아이콘 */
	private String icons;

	/** 속성 */
	private String attr1No;
	private String attr1Nm;
	private String attr1ValNo;
	private String attr1Val;
	private String attr2No;
	private String attr2Nm;
	private String attr2ValNo;
	private String attr2Val;
	private String attr3No;
	private String attr3Nm;
	private String attr3ValNo;
	private String attr3Val;
	private String attr4No;
	private String attr4Nm;
	private String attr4ValNo;
	private String attr4Val;
	private String attr5No;
	private String attr5Nm;
	private String attr5ValNo;
	private String attr5Val;
	private Integer attrCnt;

	private Long rowNum;
	
	
	/** 상품 주문 매핑 수량 */
	private Long ordCnt;
	/** 상품 세트 매핑 수량 */
	private Long setCnt;
	/** 상품 묶음 매핑 수량 */
	private Long pakCnt;
	/** 상품 최초 수정 카운트 */
	private Long firstUpdateCnt;
	/** 상품 구성 수정 가능 체크 카운트 */
	private Long checkCstrtUpdCnt;
	/** 대표 서브 상품 아이디 */
	private String dlgtSubGoodsId;
	/** 묶음 상품 아이디 */
	private String pakGoodsId;
	/** 묶음 상품 명 */
	private String pakGoodsNm;

	/** 상품 카테고리 정보 */
	private String cateCdL;
	private String cateNmL;
	private String cateCdM;
	private String cateNmM;
	private String cateCdS;
	private String cateNmS;
	private String dispCtgPath;

	/** 상품 조회수 */
	private int hits;
	
	/** 대상 상품 판매가 차이 금액 */
	private Long saleAmtCal;

	private String totalSalePsbCd;
	
	/** 카테고리 아이콘 */
	private String cateIcon;
	
	/** 사전예약 타입 현재,미래,과거 */
	private String reservationType;
	
	/** 사전예약 시작 기간 */
	private Timestamp reservationStrtDtm;

	/** 알람 발송 일시 */
	private Timestamp almSndDtm;
	
	/** 표준코드 */
	private String prdStdCd;

	/** 가격 정보 */
	private String[] goodsPriceInfo;

	/** 핫딜 상품 여부 */
	private String	dealYn;

	public void setGoodsPriceInfo(String goodsPriceInfo) {
		if(StringUtils.isNotEmpty(goodsPriceInfo)) {
			this.goodsPriceInfo = goodsPriceInfo.split("\\|");
			settingAmt();
		}
	}

	/**
	 * goodsPriceInfo
	 * 상품판매가(핫딜세일적용가)|프로모션번호|프로모션할인가|쿠폰번호|쿠폰할인가|상품금액유형코드|상품원판매가|공급금액|상품가격번호
	 */
	public void settingAmt() {

		//상품판매가
		Long saleAmt = Long.parseUnsignedLong(goodsPriceInfo[0]);
		this.setSaleAmt(saleAmt);

		//상품원판매가
		Long orgSaleAmt = Long.parseUnsignedLong(goodsPriceInfo[6]);
		this.setOrgSaleAmt(orgSaleAmt);

		//프로모션할인가
		Long dscountAmt = Long.parseUnsignedLong(goodsPriceInfo[2]);
		Long dcAmt = 0L;
		Long foSaleAmt = 0L;

		if(dscountAmt > 0) {
			dcAmt = saleAmt - dscountAmt;
			foSaleAmt = saleAmt - dscountAmt;
		} else {
			dcAmt = dscountAmt;
			foSaleAmt = saleAmt;
		}
		//할인가
		this.setDcAmt(dcAmt);
		//최종판매가
		this.setFoSaleAmt(foSaleAmt);

		//딜여부
		String goodsAmtTpCd = goodsPriceInfo[5];
		String dealYn = null;
		if(StringUtils.equals(goodsAmtTpCd, CommonConstants.GOODS_AMT_TP_20)) {
			dealYn = CommonConstants.COMM_YN_Y;
		} else {
			dealYn = CommonConstants.COMM_YN_N;
		}
		this.setDealYn(dealYn);

		//쿠폰 여부
		Long cpNo = Long.parseUnsignedLong(goodsPriceInfo[3]);
		String couponYn = null;
		if(cpNo == null || cpNo == 0) {
			couponYn = CommonConstants.COMM_YN_N;
		} else {
			couponYn = CommonConstants.COMM_YN_Y;
		}
		this.setCouponYn(couponYn);
	}
	
	public String getCateNmLUnderbar() {
		if ( this.cateNmL == null ) {
			return "";
		}
		
		return StringUtils.replace( this.cateNmL, "/", "_" );
	}
	
	public String getCateNmMUnderbar() {
		if ( this.cateNmM == null ) {
			return "";
		}
		
		return StringUtils.replace( this.cateNmM, "/", "_" );
	}
	
	public String getCateNmSUnderbar() {
		if ( this.cateNmS == null ) {
			return "";
		}
		
		return StringUtils.replace( this.cateNmS, "/", "_" );
	}
	
}