package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsDispConnerVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.service
 * - 파일명     : GoodsDispService.java
 * - 작성일     : 2021. 02. 15.
 * - 작성자     : valfac
 * - 설명       : 메인 상품 조회
 * </pre>
 */
public interface GoodsDispService {

	List getGoodsMain(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	List getGoodsMain(GoodsDispSO so);

	int countGoodsMain(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, String salePeriodYn, String saleOutYn, String order);
	int countGoodsMain(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 메인 타임딜 상품 조회
	 *
	 * 타임딜 진행중 : 타임딜(날짜/시간) 진행중인 상품 노출
	 * 타임딜 예고 : 타임딜 진행하는 날짜기준 1일전 상품 노출
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : DEAL, 진행중 : NOW, 예고 : SOON
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @throws Exception
	 */
//	int countGoodsTimeDeal(long stId, Long mbrNo, String dispType, long dispClsfCornNo, String deviceGb, String salePeriodYn, String saleOutYn);
//	int countGoodsTimeDeal(GoodsDispSO so);
	
	List getGoodsTimeDeal(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows);
	List getGoodsTimeDeal(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 폭풍 할인 상품 조회
	 *
	 * 재고 임박 : 재고갯수 적은 순 우선 노출(동일시 가나다순)
	 * 유통기한임박 : 유통기한 임박한 순서로 우선 노출(동일시 가나다순)
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : DC
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @throws Exception
	 */
//	int countGoodsDc(long stId, Long mbrNo, String dispType, long dispClsfCornNo, String deviceGb, String salePeriodYn, String saleOutYn);
//	int countGoodsDc(GoodsDispSO so);
	
	List getGoodsDc(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order);
	List getGoodsDc(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: MD 추천상품 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : MD
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @throws Exception
	 */
//	int countGoodsMd(long stId, Long mbrNo, String dispType, long dispClsfCornNo, String deviceGb, String salePeriodYn, String saleOutYn);
//	int countGoodsMd(GoodsDispSO so);
	
	List getGoodsMd(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order);
	List getGoodsMd(GoodsDispSO so);

	/**
	 * TODO[상품, 이하정, 20210218] 카테고리별 조회 작업 해야 함, 현재 메인 일간 기본 조회
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 베스트20 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : BEST, AUTO : 자동, MANUAL : 수동
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param dispClsfNo        전시 카테고리 NO
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param page              페이징
	 * @param rows              조회건수
	 * @param period            조회 기간 ( 일간 : DAY, 주간 : WEEK, 월간 : MONTH )
	 * @throws Exception
	 */
//	int countGoodsBest(long stId, Long mbrNo, String dispType, Long dispClsfCornNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn, String period);
//	int countGoodsBest(GoodsDispSO so);
	
	List getGoodsBest(long stId, Long mbrNo, String dispType, Long dispClsfCornNo, Long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String period);
	List getGoodsBest(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 펫샵 단독 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : PETSHOP
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @throws Exception
	 */
//	int countGoodsPetShop(long stId, Long mbrNo, String dispType, long dispClsfCornNo, String deviceGb, String salePeriodYn, String saleOutYn);
//	int countGoodsPetShop(GoodsDispSO so);
	
	List getGoodsPetShop(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order);
	List getGoodsPetShop(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 패키지 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispType          전시 타입 : PACKAGE
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @throws Exception
	 */
	int countGoodsPackage(long stId, Long mbrNo,String dispType, long dispClsfNo, long dispClsfCornNo, List<String> filters, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, String order);
	int countGoodsPackage(GoodsDispSO so);
	
	List getGoodsPackage(long stId, Long mbrNo,String dispType, long dispClsfNo, long dispClsfCornNo, List<String> filters, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order);
	List getGoodsPackage(GoodsDispSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 3. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 자주 구매한 상품 조회
	 * </pre>
	 * @param stId
	 * @param mbrNo
	 * @param dispClsfNo
	 * @param deviceGb
	 * @param totalCount
	 * @param salePeriodYn
	 * @param saleOutYn
	 * @param page
	 * @param rows
	 * @param searchMonth
	 * @return
	 */
	int countGoodsFrequentOrder(long stId, Long mbrNo, long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer searchMonth);
	int countGoodsFrequentOrder(GoodsDispSO so);
	
	List getGoodsFrequentOrder(long stId, Long mbrNo, long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, Integer searchMonth);
	List getGoodsFrequentOrder(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: valfac
	 * - 설명		: 펫로그 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param dispType          전시 타입 : PETLOG
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param totalCount        총 조회 건수
	 * @throws Exception
	 */
	List getDispPetLog(long stId, String dispType, long dispClsfCornNo, Integer totalCount);
	List getDispPetLog(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 24.
	 * - 작성자		: valfac
	 * - 설명		: 상품 전시 카테고리 별 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId          사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispClsfNo    전시 카테고리 NO
	 * @param filterArr     필터 NO
	 * @param bndNoArr      브랜드 NOs
	 * @param icons         아이콘 CDs
	 * @param tags          태그
	 * @param deviceGb      웹모바일 구분
	 * @param salePeriodYn  판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체)
	 * @param saleOutYn     품절상품 조회 여부
	 * @param order         정렬
	 * @param page          현재 페이지
	 * @param rows          페이지 당 조회 갯수
	 * @throws Exception
	 */
	int countGoods(long stId, Long mbrNo, Long dispClsfNo, String[] filterArr, Integer[] bndNoArr, String[] tags, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	int countGoods(GoodsDispSO so);
	
	List getGoods(long stId, Long mbrNo, Long dispClsfNo, String[] filterArr, Integer[] bndNoArr, String[] tags, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	List getGoods(GoodsDispSO so);
	List<GoodsDispConnerVO> getGoodsNoticeBanner(Long dispCornNo);

	List getFilterGroup(List<String> goodsIds);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 카테고리 추천상품 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @throws Exception
	 */
	List getGoodsCategory(long stId, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn);
	List getGoodsCategory(GoodsDispSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 03. 5.
	 * - 작성자		: valfac
	 * - 설명		: 기획전
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispClsfCornNo    기획전 테마 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @throws Exception
	 */
	List getGoodsExhibited(long stId, Long mbrNo, Long thmNo, Long exhbtNo, String exhbtGbCd, String deviceGb, Integer page, Integer rows, String salePeriodYn, String saleOutYn, String reservedYn);
	List getGoodsExhibited(GoodsDispSO so);
	int selectGoodsExhibitedCount(GoodsDispSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명		: 브랜드 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispClsfNo        전시 카테고리 NO
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @param page              페이징
	 * @param rows              조회건수
	 * @throws Exception
	 */
	int countBrandGoods(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	int countBrandGoods(GoodsDispSO so);
	
	List getGoodsCategoryBrand(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn);
	List getGoodsCategoryBrand(GoodsDispSO so);
	
	List getGoodsBrand(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	List getGoodsBrand(GoodsDispSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명		: 신상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param mbrNo             회원번호
	 * @param dispClsfNo        전시 카테고리 NO
	 * @param icons				아이콘
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @param order         	상품 정렬
	 * @param page              페이징
	 * @param rows              조회건수
	 * @throws Exception
	 */
	int countGoodsNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	int countGoodsNew(GoodsDispSO so);
	
	List getGoodsCategoryNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn);
	List getGoodsCategoryNew(GoodsDispSO so);
	
	List getGoodsNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows);
	List getGoodsNew(GoodsDispSO so);
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 3. 25. 
	 * - 작성자		: YJU
	 * - 설명			: 상품번호 별 찜여부 YN
	 * </pre>
	 * @param so
	 * @return
	 */
	GoodsDispVO getInterestGoodsYN(GoodsDispSO so);
}
