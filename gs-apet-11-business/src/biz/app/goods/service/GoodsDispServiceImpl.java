package biz.app.goods.service;

import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsDispDao;
import biz.app.goods.model.GoodsDispConnerPO;
import biz.app.goods.model.GoodsDispConnerVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.service
 * - 파일명     : GoodsDispServiceImpl.java
 * - 작성일     : 2021. 02. 15.
 * - 작성자     : valfac
 * - 설명       : 메인 화면 조회
 * </pre>
 */

@Service("goodsDispService")
public class GoodsDispServiceImpl implements GoodsDispService {

	@Autowired private Properties webConfig;

	@Autowired
	private GoodsDispDao goodsDispDao;

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsMain(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		totalCount = (totalCount != null) ? totalCount*2 : null;
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(dispType)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.order(order)
				.page(page)
				.rows(rows)
				.build();
		return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsMain(GoodsDispSO so) {
//		so.setSaleOutYn(CommonConstants.COMM_YN_N);
		return goodsDispDao.selectGoodsMain(so);
	}
	
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoodsMain(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb,String salePeriodYn, String saleOutYn, String order) {

		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(dispType)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.order(order)
				.build();
		return countGoodsMain(so);
	}
	
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoodsMain(GoodsDispSO so) {
//		so.setSaleOutYn(CommonConstants.COMM_YN_N);
		return goodsDispDao.countGoodsMain(so);
	}

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
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 )
	 * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @throws Exception
	 */
	@Override
	public List getGoodsTimeDeal(long stId, Long mbrNo,String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows) {
		totalCount = (totalCount != null) ? totalCount*2 : null;
		
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_DEAL)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.page(page)
				.rows(rows)
				.build();

		//return getGoodsTimeDeal(so);
		return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsTimeDeal(GoodsDispSO so) {
		return goodsDispDao.selectGoodsTimeDeal(so);
	}

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
	 * @param dispType          전시 타입 : DC
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 )
	 * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @throws Exception
	 */
	@Override
	public List getGoodsDc(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order) {
		totalCount = (totalCount != null) ? totalCount*2 : null;
		
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
//				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_DC)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_AMT_TP_40)	//유통기한 임박 할인/재고 임박 할인 세팅
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.page(page)
				.rows(rows)
				.order(order)
				.build();

		//return getGoodsDc(so);
		return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsDc(GoodsDispSO so) {
		List list = goodsDispDao.selectGoodsDcCache(so);

		return list;
	}

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
	 * @param dispType          전시 타입 : MD
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 )
	 * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @throws Exception
	 */
	@Override
	public List getGoodsMd(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order) {
		totalCount = (totalCount != null) ? totalCount*2 : null;
		
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_MD)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.page(page)
				.rows(rows)
				.order(order)
				.build();

		//return getGoodsMd(so);
		return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsMd(GoodsDispSO so) {
		List list = goodsDispDao.selectGoodsMdCache(so);

		return list;
	}

	/**
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
	 * @param dispType          전시 타입 : BEST, AUTO : 자동, MANUAL : 수동
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param dispClsfNo        전시 카테고리 NO (BEST 일 경우만 체크)
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 )
	 * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @param page              페이징
	 * @param rows              조회건수
	 * @param period            조회 기간 ( 일간 : DAY, 주간 : WEEK, 월간 : MONTH )
	 * @throws Exception
	 */
	@Override
	public List getGoodsBest(long stId, Long mbrNo, String dispType, Long dispClsfCornNo, Long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String period) {
		page = (page != null) ? page : 0;
		rows = (rows != null) ? rows : (AdminConstants.DEVICE_GB_10.equals(deviceGb) ? 10 : 5 );

		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO)
				.dispClsfCornNo(dispClsfCornNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.period(StringUtils.isNotEmpty(period) ? period : "DAY")
				.totalCount(totalCount == null ? Integer.parseInt(AdminConstants.GOODS_MAIN_DISP_TYPE_BEST_COUNT) : totalCount)
				.page(page)
				.rows(rows)
				.build();

		return getGoodsBest(so);
		//return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsBest(GoodsDispSO so) {
		if(AdminConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO.equals(so.getDispType())) {
			if(CommonConstants.PERIOD_DAY.equals(so.getPeriod())) {
				return goodsDispDao.selectGoodsBestDay(so);
			}else {
				return goodsDispDao.callGoodsBestProc(so);
			}
		} else {
			return goodsDispDao.selectGoodsBestManualCache(so);
//			return getGoodsMain(so);
		}
	}

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
	 * @param dispType          전시 타입 : PETSHOP
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체)
     * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @throws Exception
	 */
	@Override
	public List getGoodsPetShop(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order) {
		totalCount = (totalCount != null) ? totalCount*2 : null;
		
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_PETSHOP)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.page(page)
				.rows(rows)
				.order(order)
				.build();

		//return getGoodsPetShop(so);
		return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsPetShop(GoodsDispSO so) {
		return goodsDispDao.selectGoodsPetShop(so);
	}
	
	@Override
	public int countGoodsPackage(long stId, Long mbrNo, String dispType, long dispClsfNo, long dispClsfCornNo, List<String> filters, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, String order) {
		totalCount = (totalCount != null) ? totalCount*2 : null;

		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_PACKAGE)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.filters(filters)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				//.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.salePeriodYn(AdminConstants.COMM_YN_N)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.order(order)
				.build();
		return countGoodsPackage(so);
		//return countGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoodsPackage(GoodsDispSO so) {
		/*
		패키지 상품일 경우, 필터관리 필터와는 성질이 다름
		구성/혜택은 4개 중에 1개 선택 가능
		-1+1 : 1+1 상품만 해당
		-2+1 : 2+1 상품만 해당
		-사은품 증정 : 사은품 증정상품이 모두 해당
		-기타 : BO에서 패키지상품 영역에 노출한 묶은상품과 세트상품이 해당
		 */
		List<String> filters = so.getFilters();
		String goodsCstrtYn = (filters != null) ? (filters.stream().filter(p -> "ETC".equals(p)).count() > 0 ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N) : CommonConstants.COMM_YN_N;
		List<String> iconFilters = (filters != null) ? filters.stream().filter(p -> !"ETC".equals(p)).collect(Collectors.toList()) : null;

		//기본 검색조건
		String filterConditionStr = (String) webConfig.get("disp.petshop.package.filters");
		List<String> filterCondition = (StringUtils.isNotEmpty(filterConditionStr)) ? Arrays.stream(filterConditionStr.split(",")).collect(Collectors.toList()) : null;
		so.setFilterCondition(filterCondition);
		//아이콘 필터만 필터로 세팅
		so.setFilters(iconFilters !=null && iconFilters.size() > 0 ? iconFilters : null);
		//상품 구성유형 검색은 GOODS_CSTRT_TP_CD 검색
		so.setGoodsCstrtYn(goodsCstrtYn);
		//return goodsDispDao.countGoodsPackage(so);
		return countGoodsMain(so);
	}
	
	
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
	 * @param dispType          전시 타입 : PACKAGE
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @throws Exception
	 */
	@Override
	public List getGoodsPackage(long stId, Long mbrNo,String dispType, long dispClsfNo, long dispClsfCornNo, List<String> filters, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, String order) {
		totalCount = (totalCount != null) ? totalCount*2 : null;

		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_PACKAGE)
				.dispClsfNo(dispClsfNo)
				.dispClsfCornNo(dispClsfCornNo)
				.filters(filters)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount)
				.page(page)
				.rows(rows)
				.order(order)
				.build();

		return getGoodsPackage(so);
		//return getGoodsMain(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsPackage(GoodsDispSO so) {
		/*
		패키지 상품일 경우, 필터관리 필터와는 성질이 다름
		구성/혜택은 4개 중에 1개 선택 가능
		-1+1 : 1+1 상품만 해당
		-2+1 : 2+1 상품만 해당
		-사은품 증정 : 사은품 증정상품이 모두 해당
		-기타 : BO에서 패키지상품 영역에 노출한 묶은상품과 세트상품이 해당
		 */
		List<String> filters = so.getFilters();
		String goodsCstrtYn = (filters != null) ? (filters.stream().filter(p -> "ETC".equals(p)).count() > 0 ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N) : CommonConstants.COMM_YN_N;
		List<String> iconFilters = (filters != null) ? filters.stream().filter(p -> !"ETC".equals(p)).collect(Collectors.toList()) : null;
		
		//기본 검색조건
		String filterConditionStr = (String) webConfig.get("disp.petshop.package.filters");
		List<String> filterCondition = (StringUtils.isNotEmpty(filterConditionStr)) ? Arrays.stream(filterConditionStr.split(",")).collect(Collectors.toList()) : null;
		so.setFilterCondition(filterCondition);
		//아이콘 필터만 필터로 세팅
		so.setFilters(iconFilters !=null && iconFilters.size() > 0 ? iconFilters : null);
		//상품 구성유형 검색은 GOODS_CSTRT_TP_CD 검색
		so.setGoodsCstrtYn(goodsCstrtYn);

//		return goodsDispDao.selectGoodsPackageCache(so);
		return getGoodsMain(so);
	}
	
	@Override
	public int countGoodsFrequentOrder(long stId, Long mbrNo, long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer searchMonth) {
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.searchMonth(searchMonth == null ? 12 : searchMonth)
				.build();
		
		return countGoodsFrequentOrder(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoodsFrequentOrder(GoodsDispSO so) {
		return goodsDispDao.countFrequentOrderGoods(so);
	}
	
	@Override
	public List getGoodsFrequentOrder(long stId, Long mbrNo, long dispClsfNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn, Integer page, Integer rows, Integer searchMonth) {
		totalCount = (totalCount != null) ? totalCount : null;

		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.searchMonth(searchMonth == null ? 12 : searchMonth)
				.page(page)
				.rows(rows)
				.build();
		return getGoodsFrequentOrder(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsFrequentOrder(GoodsDispSO so) {
		return goodsDispDao.selectFrequentOrderGoods(so);
	}
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
	@Override
	public List getDispPetLog(long stId, String dispType, long dispClsfCornNo, Integer totalCount) {
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.dispType(StringUtils.isNotEmpty(dispType) ? dispType : AdminConstants.GOODS_MAIN_DISP_TYPE_PETLOG)
				.dispClsfCornNo(dispClsfCornNo)
				.totalCount(totalCount)
				.build();

		return getDispPetLog(so);
	}

	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getDispPetLog(GoodsDispSO so) {
		return goodsDispDao.selectDispPetLog(so);
	}

	@Override
	public int countGoods(long stId, Long mbrNo, Long dispClsfNo, String[] filterArr, Integer[] bndNoArr, String[] tags, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		List<String> filters = (filterArr != null) ? Arrays.stream(filterArr).collect(Collectors.toList()) : null;
		int filterCount = (filterArr != null) ? filterArr.length : 0;
		List<Integer> bndNos = (bndNoArr != null) ? Arrays.stream(bndNoArr).collect(Collectors.toList()) : null;
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.filters(filters)
				.filterCount(filterCount)
				.bndNos(bndNos)
				.tags(tags)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return countGoods(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoods(GoodsDispSO so) {
		return goodsDispDao.countGoods(so);
	}

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
	 * @param dispClsfNo    전시 카테고리 NO
	 * @param filterArr     필터 NO
	 * @param bndNoArr      브랜드 NOs
	 * @param icons         브랜드 NOs
	 * @param tags          TAGS
	 * @param deviceGb      웹모바일 구분
	 * @param salePeriodYn  판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn     품절상품 조회 여부
	 * @param order         정렬
	 * @param page          현재 페이지
	 * @param rows          조회 갯수
	 * @throws Exception
	 */
	public List getGoods(long stId, Long mbrNo, Long dispClsfNo, String[] filterArr, Integer[] bndNoArr, String[] tags, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		List<String> filters = (filterArr != null) ? Arrays.stream(filterArr).collect(Collectors.toList()) : null;
		int filterCount = (filterArr != null) ? filterArr.length : 0;
		List<Integer> bndNos = (bndNoArr != null) ? Arrays.stream(bndNoArr).collect(Collectors.toList()) : null;
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.filters(filters)
				.filterCount(filterCount)
				.bndNos(bndNos)
				.tags(tags)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return getGoods(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoods(GoodsDispSO so) {
		//return goodsDispDao.selectGoodsCache(so);
		return goodsDispDao.selectGoods(so);
	}

	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getFilterGroup(List<String> goodsIds) {
		return goodsDispDao.selectFilterGroup(goodsIds);
	}

	/**
	 * 상품 상세 공지 배너
	 * @param dispCornNo
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsDispConnerVO> getGoodsNoticeBanner(Long dispCornNo) {
		GoodsDispConnerPO po = new GoodsDispConnerPO();
		po.setDispCornNo(dispCornNo);
		return goodsDispDao.getGoodsNoticeBanner(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valfac
	 * - 설명		: 카테고리별 코너아이템 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param dispClsfCornNo    전시 분류 코너 번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체 )
	 * @param saleOutYn         품절상품 조회 여부  (Y : 조회 , N : 조회안함 )
	 * @throws Exception
	 */
	@Override
	public List getGoodsCategory(long stId, long dispClsfCornNo, String deviceGb, Integer totalCount, String salePeriodYn, String saleOutYn) {
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfCornNo(dispClsfCornNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.totalCount(totalCount == null ? Integer.parseInt(AdminConstants.GOODS_MAIN_DISP_TYPE_MD_COUNT) : totalCount)
				.build();

		return getGoodsCategory(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsCategory(GoodsDispSO so) {
		List list = goodsDispDao.selectGoodsCategory(so);

		return list;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 03. 5.
	 * - 작성자		: valfac
	 * - 설명		: 기획전 상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId              사이트 ID
	 * @param thmNo             기획전 테마번호
	 * @param deviceGb          웹모바일 구분
	 * @param totalCount        총 조회 건수
	 * @param salePeriodYn      판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn         품절상품 조회 여부
	 * @throws Exception
	 */
	@Override
	public List getGoodsExhibited(long stId, Long mbrNo, Long thmNo, Long exhbtNo, String exhbtGbCd, String deviceGb, Integer page, Integer rows, String salePeriodYn, String saleOutYn, String reservedYn) {
		page = page == null ? 0 : page;
		GoodsDispSO so = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.thmNo(thmNo)
				.exhbtNo(exhbtNo)
				.exhbtGbCd(exhbtGbCd)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.page(page) //TODO[상품, 이하정, 20210309] 기획전 TOTAL 카운트 체크
				.rows(rows)
				.reservedYn(reservedYn)
				.build();

		return getGoodsExhibited(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsExhibited(GoodsDispSO so) {
		List list = goodsDispDao.selectGoodsExhibited(so);

		return list;
	}
	
	@Override
	public int countBrandGoods(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return countBrandGoods(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countBrandGoods(GoodsDispSO so) {
		return goodsDispDao.countBrandGoods(so);
	}
	
	@Override
	public List getGoodsCategoryBrand(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn) {
		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.build();

		return getGoodsBrand(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsCategoryBrand(GoodsDispSO so) {
		return goodsDispDao.selectGoodsCategoryBrand(so);
	}
	
	@Override
	public List getGoodsBrand(long stId, Long mbrNo, Long dispClsfNo, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return getGoodsBrand(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsBrand(GoodsDispSO so) {
		return goodsDispDao.selectGoodsBrand(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : GoodsDispServiceImpl.java
	 * - 작성일        : 2021. 3. 17.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 상품 count조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int selectGoodsExhibitedCount(GoodsDispSO so) {
		return goodsDispDao.selectGoodsExhibitedCount(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public GoodsDispVO getInterestGoodsYN(GoodsDispSO so) {
		return goodsDispDao.getInterestGoodsYN(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispService.java
	 * - 작성일		: 2021. 02. 24.
	 * - 작성자		: valfac
	 * - 설명		: 신상품 조회
	 *
	 * </pre>
	 * @param so
	 * or
	 * @param stId          사이트 ID
	 * @param dispClsfNo    전시 카테고리 NO
	 * @param icons         아이콘s
	 * @param deviceGb      웹모바일 구분
	 * @param salePeriodYn  판매기간 내 상품 조회 여부 (Y : 판매기간 내 , N : 판매기간 전체
	 * @param saleOutYn     품절상품 조회 여부
	 * @param order         정렬
	 * @param page          현재 페이지
	 * @param rows          조회 갯수
	 * @throws Exception
	 */
	@Override
	public int countGoodsNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.icons(icons)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return countGoodsNew(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public int countGoodsNew(GoodsDispSO so) {
		return goodsDispDao.countGoodsNew(so);
	}
	
	@Override
	public List getGoodsCategoryNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn) {
		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.icons(icons)
				.build();

		return getGoodsCategoryNew(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsCategoryNew(GoodsDispSO so) {
		return goodsDispDao.selectGoodsCategoryNew(so);
	}
	
	public List getGoodsNew(long stId, Long mbrNo, Long dispClsfNo, String[] icons, String deviceGb, String salePeriodYn, String saleOutYn, String order, Integer page, Integer rows) {
		page = page == null ? 0 : page;

		GoodsDispSO so  = GoodsDispSO.builder()
				.stId(stId)
				.mbrNo(mbrNo)
				.dispClsfNo(dispClsfNo)
				.deviceGb(StringUtils.isNotEmpty(deviceGb) ? deviceGb : AdminConstants.DEVICE_GB_10)
				.salePeriodYn(StringUtils.isNotEmpty(salePeriodYn) ? salePeriodYn : AdminConstants.COMM_YN_Y)
				.saleOutYn(StringUtils.isNotEmpty(saleOutYn) ? saleOutYn : AdminConstants.COMM_YN_N)
				.icons(icons)
				.order(order)
				.page(page)
				.rows(rows)
				.build();

		return getGoodsNew(so);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List getGoodsNew(GoodsDispSO so) {
		return goodsDispDao.selectGoodsNew(so);
	}
}
