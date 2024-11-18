package front.web.config.view;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import biz.app.contents.model.SeriesVO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.EventPopupVO;
import framework.common.constants.CommonConstants;
import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 01.common
* - 패키지명	: framework.front.model
* - 파일명		: ViewBase.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Front Base View 정보
* </pre>
*/
@Data
public class ViewBase implements Serializable {

	private static final long serialVersionUID = 1L;

	/* 사이트 속성 */
	private Long	stId;			// 사이트 아이디
	private String  stGb; 			// 사이트 구분
	private String	stNm;			// 사이트 명
	private String	svcGbCd;		// 사이트 서비스 (pc or mb)
	private String	envmtGbCd;		// 환경 구분 (local, dev, oper)
	private String  title;		// 타이틀
	private String	stDomain;
	private String	lang;
	private String 	imgPath;
	private String 	imgComPath;
	private String	noImgPath;
	private Long 	mainDispClsfNo; /*비정형매장인 메인이 A인지 B인지 판단 변수 */
	private String	url;			//페이지 url
	private String  imgDomain;
	private String  schema;
	private String	gaKey;		//Google Analytics Key
	private String  mbrGrdCd;
	
	private String[]	navigation;
	private Map<Long,String> cateNavigation;
	private List<DisplayCategoryVO> displayCategoryList;  // 카테고리 목록
	private List<DisplayBannerVO> displayShortCutList;  // 바로가기영역 목록
	private List<DisplayCategoryVO> displayExhibitionList;  // 기획전 목록
	private List<DisplayCategoryVO> displaySeriesList;  // 시리즈목록
	private List<SeriesVO> foSeriesList; //시리즈 전체 목록
	private Integer cartCnt;		// 장바구니 수
	private Long 	dispCornNoBest;			// BEST 상품 번호
	private String goBackUrl;				// 뒤로가기 URL
	
	/** 주문 단계 */
	private String orderStep;

	// ===================== 딥링크 관련 정보 ==========================
	private String deepLinkYn;
	private String requestURL;
	// ===================== 딥링크 관련 정보 ==========================
	
	/** 기기구분 [normal=true:모바일이나 태블릿 아님, mobile=true: 모바일, tablet=true:태블릿]*/
//	private Device device;
	
	/** OS 구분 [DEVICE_TYPE(PC), ANDROID:10, IOS:20]*/
	private String os;
	
	/** 기기구분 [PC, MO, APP]*/
	private String deviceGb;
	
	/** 서비스 구분 [펫샵:10, 펫TV:20(default), 펫로그:30] */
	private String seoSvcGbCd = CommonConstants.SEO_SVC_GB_CD_20; 
	/** 펫 구분 [강아지:10(default), 고양이: 20, 기타:30] */
	private String petGb = CommonConstants.PET_GB_10;
	
	private String jsonData;
	private Map<String, String> jsonDt;
	
	/** SEO 구분*/
	//private Long seoInfoNo;		// SEO 정보 번호
	/** SEO 유형 [공통:10(default), 펫상품:20, 카테고리:30, 브랜드:40, 기획전:50, 게시판:60, 기타:99] */
	//private String seoTpCd = CommonConstants.SEO_TP_10;		// SEO 유형
	
	//private SeoInfoVO seoInfo;		// SEO 정보 번호
	
	private Long dispClsfNo;		// 전시 분류 정보
	
	/** 펫톡 brand key */
	private String brandKey;
	
	/** 공유하기를 통한 접근 여부 */
	private String shareAcc;
	
	/** 삼선 메뉴 (.btnGnb) 컨트롤 */
	private Boolean btnGnbHide = false;
	
	/** 메타 nocache 컨트롤 */
	private Boolean nocache = false;
	
	/** TWC userAgent */
	private Boolean twcUserAgent = false;
	
	/** 이벤트팝업 목록 */
	private List<EventPopupVO> popLayerEventList;
}