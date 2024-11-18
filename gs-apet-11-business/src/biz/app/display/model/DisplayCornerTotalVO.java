package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.banner.model.BannerVO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodVO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsListVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tv.model.TvDetailVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerTotalVO extends BaseSysVO {

	private	Long	dispCornNo;			// 전시 코너 번호
	private	String	dispCornNm;			// 전시 코너 명
	private	String	dispCornTpCd;		// 전시 코너 타입 코드
	private	Long	showCnt; 			// 노출 개수

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 노출 타입 코드 */
	private String dispShowTpCd;

	/** 전시 기간 설정 여부 */
	private String dispPrdSetYn;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 콘텐츠 타이틀 */
	private String cntsTtl;

	/** 콘텐츠 설명 */
	private String cntsDscrt;

	/** 코너 이미지 명 */
	private String cornImgNm;

	/** 코너 이미지 경로 */
	private String cornImgPath;

	/** 코너 모바일 이미지 명 */
	private String cornMobileImgNm;

	/** 코너 모바일 이미지 경로 */
	private String cornMobileImgPath;

	/** 코너 링크 경로 */
	private String linkUrl;

	/** 코너 모바일 링크 경로 */
	private String mobileLinkUrl;

	/** 코너 BG 컬러값 */
	private String bgColor;
	
	/** 전시 우선 순위 */
	private Long dispPriorRank;
	
	/** 전시 코너 페이지 명 */
	private String dispCornPage;
	
	/*펫 이름*/
	private String petNm;
	/*펫 리스트*/
	private String petNos;
	/*펫 구분 코드*/
	private String petGbCd;
	
	/** SEO 번호 */
	private Long seoInfoNo;
	
	private	List<DisplayBannerVO>		listBanner;			// 코너 아이템 - 배너
	private	List<DisplayCornerItemVO>	listCornerItem;		// 코너 아이템 - 상품
	private List<GoodsListVO>			goodsList;			// 코너 아이템 - 상품정보

	private List<DisplayBannerVO>		mainBannerList;		// 코너 아이템 - 메인 배너
	private List<VodVO>					customList;			// 코너 아이템 - 맞춤 추천  영상
	private List<TvDetailVO>			recentlyList;		// 코너 아이템 - 최근 본  영상
	private List<VodVO>					newVodList;			// 코너 아이템 - 따끈따끈 신규  영상
	private List<VodVO>					popularList;		// 코너 아이템 - 인기 영상
	private List<BannerVO>				bannerList;			// 코너 아이템 - 광고 배너
	private List<VodVO>					petSchoolList;		// 코너 아이템 - 펫스쿨
	private List<TagBaseVO>				interestTagList;	// 코너 아이템 - 내가 등록한 관심 TAG
	private List<VodVO>					interestVodList;	// 코너 아이템 - 내가 등록한 관심 TAG 관련 영상
	private List<SeriesVO>				seriesList;			// 코너 아이템 - 오리지널 시리즈
	private String						dupleVdIds;			// 코너 아이템 - 제외영상vdId
	private List<SeriesVO>				seriesTagList;		// 코너 아이템 - 시리즈 TAG
	private List<VodVO>					tagVodList;			// 코너 아이템 - 동영상 TAG
	
	private List<PetLogBaseVO>			petLogList;			// 코너 아이템 - 펫로그정보
	private List<MemberBaseVO>			memberList;			// 코너 아이템 - 펫로그회원정보
	private List<String>				tagList;			// 코너 아이템 - 태그정보
	
	/** 전시 코너 리스트 - 펫샵*/
	private List<BannerVO>				topBannerList;				// 코너 - 상단 배너
	private List<BannerVO>				adBannerList;				// 코너 - 광고 배너
	private List<BannerVO>				bottomAdBannerList;			// 코너 - 하단 광고 배너
	private List<DisplayBannerVO>		shortCutList;				// 코너 - 바로가기영역
	private List<DisplayPetLogVO>		popPetLogList;				// 코너 - 인기있는 펫로그 후기
	private List<GoodsDispVO>			timeDealList;				// 코너 - 타임딜
	private List<GoodsDispVO>			stockGoodsList;				// 코너 - 폭풍할인
	private List<GoodsDispVO>			expGoodsList;				// 코너 - 폭풍할인
	private List<GoodsDispVO>			mdGoodsList;				// 코너 - MD 추천상품
	private List<GoodsDispVO>			bestGoodsList;				// 코너 - 베스트20
	private List<GoodsDispVO>			bestGoodsCategoryList;		// 코너 - 베스트20 상품 카테고리
	private List<GoodsDispVO>			onlyGoodsList;				// 코너 - 펫샵 단독 상품
	private List<GoodsDispVO>			packageGoodsList;			// 코너 - 패키지 상품
	private List<GoodsDispVO>			recommendGoodsList;			// 코너 - 사용자 맞춤
	private List<List<GoodsDispVO>>		recommendTotalGoodsList;	// 코너 - 사용자 맞춤(전체)
	private List<GoodsDispVO>			offenGoodsList;				// 코너 - 자주 구매한 상품
	private int goodsCount;											// 상품 갯수
	
}