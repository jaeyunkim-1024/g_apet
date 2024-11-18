package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeValuePO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBulkUploadPO extends GoodsBasePO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 아이디 */
	private String stIds;
	private String stNm;

	/** 사이트 아이디 check */
	private Long[] stIdArray;

	/** 사이트 check */
	private String st;
	
	/** 업체 명 */
	private String compNm;
	private long compGoodsIdCnt;

	/** 브랜드 명 */
	private String bndNm;
	
	/** 펫구분 */
	private String petGbNm;
	
	/** 웹모바일 구분 */
	private String webMobileGbNm;
	
	/** 과세구분명 */
	private String taxGbNm;
	
	/** 판매가 */
	private Long saleAmt;
	/** 정상가 */
	private Long orgSaleAmt;
	/** 매입가 */
	private Long splAmt;

	/** 수수료 율 */
	private Double cmsRate;

	/** 상세설명 [PC] */
	private String contentPc;

	/** 상세설명 [MOBILE] */
	private String contentMobile;

	/** 전시 분류 번호 */
	private String dispClsfNos;

	/** 웹 재고 수량 */
	private Long webStkQty;

	/** 가격 */
	private String changeFutureYn;
	private String goodsAmtTpCd;
	
	/** 업로드 결과 */
	private String successYn;
	private String resultMessage;

	/** 처리 순번 */
	private Integer prcsSeq;

	/** 샵링커 전송 여부 */
	private String shoplinkerSndYn;

	/** 판매기간 설정여부 */
	private String saleDtYn;

	/** 성분 정보 연동 여부 */
	private String igdtInfoLnkYn;

	/** 속성 */
	private Long attr1No;
	private String attr1Nm;
	private String attr1ValNo;
	private String attr1Val;
	private Long attr2No;
	private String attr2Nm;
	private String attr2ValNo;
	private String attr2Val;
	private Long attr3No;
	private String attr3Nm;
	private String attr3ValNo;
	private String attr3Val;
	private Long attr4No;
	private String attr4Nm;
	private String attr4ValNo;
	private String attr4Val;
	private Long attr5No;
	private String attr5Nm;
	private String attr5ValNo;
	private String attr5Val;

	/** 상품 이미지 */
	private String img1Url;
	private String img2Url;
	private String img3Url;
	private String img4Url;
	private String img5Url;
	private String img6Url;
	private String img7Url;
	private String img8Url;
	private String img9Url;
	private String img10Url;

	/** 배너 */
	private String bannerImgUrl;

	/** 사은품 가능 여부 */
	private String frbPsbYn;

	/** 아이콘 */
	private String icons;
	private String iconStrtDtm;
	private String iconEndDtm;

	/** 태그 */
	private String tagsNm;
	private String tags;

	/** 네이버 */
	private String sndYn;       //네이버쇼핑 노출여부
	private String goodsSrcNm;  //수입 및 제작 여부
	private String goodsSrcCd;  //수입 및 제작 여부
	private String saleTpNm;    //판매 방식 구분
	private String saleTpCd;    //판매 방식 구분
	private String stpUseAgeNm; //주요사용연령대
	private String stpUseAgeCd; //주요사용연령대
	private String stpUseGdNm;  //주요사용성별
	private String stpUseGdCd;  //주요사용성별
	private String srchTag;     //검색태그
	private String naverCtgId;  //네이버 카테고리 ID
	private String prcCmprPageId;     //가격비교 페이지 ID

	/** SEO */
	private String pageYn;      //상품 개별 SEO 설정 사용여부
	private String pageTtl;     //메타태그 타이틀
	private String pageAthr;    //메타태그 작성자(Author)
	private String pageDscrt;   //메타태그 설명(Description)
	private String pageKwd;     //메타태그 키워드

	/**
	 * fixme[상품, 이하정, 20210208] 
	 * 여기 아래부터 체크
	 * 사용할까?
	 */
	/** 고시 아이디 */
	private String ntfId;
	private String itemVal1;
	private String itemVal2;
	private String itemVal3;
	private String itemVal4;
	private String itemVal5;
	private String itemVal6;
	private String itemVal7;
	private String itemVal8;
	private String itemVal9;
	private String itemVal10;
	private String itemVal11;
	private String itemVal12;
	private String itemVal13;
	private String itemVal14;
	private String itemVal15;
	private String itemVal16;
	private String itemVal17;
	private String itemVal18;
	private String itemVal19;
	private String itemVal20;

	/** 단품 */
	private List<AttributePO> attributePOList;
	private List<AttributeValuePO> attributeValuePOList;
	private List<ItemAttrHistPO> itemAttrHistPOList;

	private Long itemNo;
	private String itemNm;

	private String itemStatCd;

	/** 원가 금액 */
	private Long costAmt;

	/** 상품 카테고리 정보 */
	private Long cateCdL;
	private String cateNmL;
	private Long cateCdM;
	private String cateNmM;
	private Long cateCdS;
	private String cateNmS;

	/** 성공여부 **/
	private String resultYN;
	/** 결과메세지 **/
	private String resultMsg;

	private Long excelRow;

	/** 원산지명 **/
	private String ctrOrgNm;
}
