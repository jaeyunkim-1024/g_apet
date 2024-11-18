package biz.app.display.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import com.google.common.collect.Lists;

import biz.app.banner.model.BannerVO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.company.dao.CompanyDao;
import biz.app.company.model.CompDispMapSO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanySO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DispCornerItemTagMapPO;
import biz.app.display.model.DisplayBannerPO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayBrandPO;
import biz.app.display.model.DisplayBrandSO;
import biz.app.display.model.DisplayBrandVO;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayClsfCornerPO;
import biz.app.display.model.DisplayClsfCornerSO;
import biz.app.display.model.DisplayClsfCornerVO;
import biz.app.display.model.DisplayCornerItemPO;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerItemVO;
import biz.app.display.model.DisplayCornerPO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.DisplayCornerVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.display.model.DisplayGoodsSO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayGroupBuySO;
import biz.app.display.model.DisplayGroupBuyVO;
import biz.app.display.model.DisplayPO;
import biz.app.display.model.DisplayPetLogVO;
import biz.app.display.model.DisplayTemplatePO;
import biz.app.display.model.DisplayTemplateSO;
import biz.app.display.model.DisplayTemplateVO;
import biz.app.display.model.DisplayTreeVO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupVO;
import biz.app.display.validation.DisplayGoodsValidator;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsFiltAttrSO;
import biz.app.goods.model.GoodsFiltAttrVO;
import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.goods.service.GoodsDispService;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberInterestBrandSO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.service.PetService;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogListSO;
import biz.app.pettv.model.ApetContentsWatchHistVO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.service.TvDetailService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.RequestUtil;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import lombok.extern.slf4j.Slf4j;

/**
 * 사이트 ServiceImpl
 * 
 * @author snw
 * @since 2015.06.11
 */
@Slf4j
@Service
@Transactional
public class DisplayServiceImpl implements DisplayService {

	@Autowired
	private DisplayDao displayDao;

	@Autowired private CompanyDao companyDao;

	@Autowired
	private BizService bizService;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private GoodsDispService goodsDispService;

	@Autowired
	private StService stService;

	@Autowired
	private Properties webConfig;

	@Autowired
	private DispCornerItemTagMapService dispCornerItemTagMapService;

	@Autowired
	private PetService petService;

	@Autowired
	private SearchApiUtil searchApiUtil;

	@Autowired
	private TagService tagService;

	@Autowired
	private CacheService cacheService;

	@Autowired
	private TvDetailService tvDetailService;


	// ========================================================================
	// BO
	// ========================================================================

	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DisplayServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 전시 상품 등록
	 * </pre>
	 *
	 * @param goodsId
	 * @param displayGoodsPOList
	 */
	@Override
	public void insertDisplayGoods(String goodsId, List<DisplayGoodsPO> displayGoodsPOList) {
		if (CollectionUtils.isNotEmpty(displayGoodsPOList)) {
			for (DisplayGoodsPO po : displayGoodsPOList) {
				po.setGoodsId(goodsId);
				displayDao.insertDisplayGoods(po);
			}
		}
	}

	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DisplayServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 전시 상품 수정
	 * </pre>
	 *
	 * @param goodsId
	 * @param displayGoodsPOList
	 */
	@Override
	public void updateDisplayGoods(String goodsId, List<DisplayGoodsPO> displayGoodsPOList) {
		if (CollectionUtils.isNotEmpty(displayGoodsPOList)) {
			displayDao.deleteDisplayGoodsAll(goodsId);
			insertDisplayGoods(goodsId, displayGoodsPOList);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public List<DisplayTemplateVO> listDisplayTemplateGrid(DisplayTemplateSO so) {
		return displayDao.listDisplayTemplateGrid(so);
	}

	@Override
	@Transactional(readOnly = true)
	public DisplayTemplateVO getDisplayTemplateDetail(DisplayTemplateSO so) {
		return displayDao.getDisplayTemplateDetail(so);
	}

	@Override
	public void insertDisplayTemplate(DisplayTemplatePO po) {
		int result = displayDao.insertDisplayTemplate(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void updateDisplayTemplate(DisplayTemplatePO po) {
		int result = displayDao.updateDisplayTemplate(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteDisplayTemplate(DisplayTemplatePO po) {
		DisplayTemplateSO so = new DisplayTemplateSO();
		so.setTmplNo(po.getTmplNo());

		// 템플릿 사용여부 확인
		DisplayCornerVO vo = displayDao.getDisplayCorner(so);
		if (vo != null) {
			throw new CustomException(ExceptionConstants.ERROR_DISPLAY_TEMPLATE_IN_USE);
		}

		// 템플릿 삭제
		int result = displayDao.deleteDisplayTemplate(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayTemplateVO> listDisplayTemplate(DisplayTemplateSO so) {
		return displayDao.listDisplayTemplate(so);
	}

	@Override
	@Transactional(readOnly = true)
	public List<DisplayTreeVO> listDisplayTree(DisplayCategorySO so) {
		return displayDao.listDisplayTree(so);
	}

	/**
	 * 업체/전시 카테고리 팝업 레이어
	 */
	@Override
	public List<DisplayCategoryVO> displayListTreeFilter(DisplayCategorySO so) {

		List<DisplayCategoryVO> resultList = new ArrayList<>();

		CompanySO companySO = new CompanySO();
		companySO.setCompNo(so.getCompNo());
		CompanyBaseVO companyBaseVO = companyDao.getCompany(companySO);

		// 해당 업체에 할당된 카테고리 목록 가져오기 . 세카테고리목록
		if(companyBaseVO.getCompTpCd() == CommonConstants.COMP_TP_30) {
			return resultList;
		}

		List<DisplayCategoryVO> siteCategoryList = new ArrayList<>();
		List<DisplayCategoryVO> viewCategories = new ArrayList<>();

		List<DisplayCategoryVO> allCategory = displayDao.listDisplayCategoryFO(so);

		CompDispMapSO cdSo = new CompDispMapSO();
		cdSo.setCompNo(so.getCompNo()); // 업체번호
		cdSo.setStId(so.getStId()); // 사이트아이디
		cdSo.setDispClsfCd(so.getDispClsfCd());

		// 해당 업체에 할당된 카테고리 목록 가져오기 . 세카테고리목록
		/*
		List<DisplayCategoryVO> compCateResultList = compCateResultListdisplayDao.listCompDisp(cdSo);

		List<DisplayCategoryVO> bgList = new ArrayList<>();

		for (DisplayCategoryVO temp : compCateResultList) {

			for (DisplayCategoryVO category : allCategory) {
				DisplayCategoryVO tempBg = new DisplayCategoryVO();
				if (temp.getDispClsfNo().intValue() == category.getDispClsfNo().intValue()) {
					tempBg.setDispClsfNo(category.getMastDispNo());
					tempBg.setCompNo(temp.getCompNo());
					tempBg.setStId(temp.getStId());
					tempBg.setStNm(temp.getStNm());
					DisplayCategorySO pso = new DisplayCategorySO();
					pso.setDispClsfNo(category.getMastDispNo());
					DisplayCategoryVO masterCateVO = this.getDisplayBase(pso);
					tempBg.setDispPriorRank(masterCateVO.getDispPriorRank());

					bgList.add(tempBg);
				}
			}
		}
		*/

		List<DisplayCategoryVO> bgList = new ArrayList<>();

		for (DisplayCategoryVO category : allCategory) {
			DisplayCategoryVO tempBg = new DisplayCategoryVO();
			tempBg.setDispClsfNo(category.getMastDispNo());
			tempBg.setCompNo(companyBaseVO.getCompNo());
			tempBg.setStId(so.getStId());
			//tempBg.setStNm(vo.getStNm());
			DisplayCategorySO pso = new DisplayCategorySO();
			pso.setDispClsfNo(category.getMastDispNo());
			DisplayCategoryVO masterCateVO = this.getDisplayBase(pso);
			tempBg.setDispPriorRank(masterCateVO.getDispPriorRank());
			bgList.add(tempBg);
		}

		bgList.sort((DisplayCategoryVO obj1, DisplayCategoryVO obj2) -> {
			if (obj1.getDispPriorRank() < obj2.getDispPriorRank()) {
				return -1;
			} else if (obj1.getDispPriorRank() > obj2.getDispPriorRank()) {
				return 1;
			} else {
				return 0;
			}
		});

		/*
		 * log.debug("bgList====>" + bgList); // 대카만
		 */
		List<DisplayCategoryVO> uniqBigCate = new ArrayList<>(new LinkedHashSet<DisplayCategoryVO>(bgList));

		log.debug("uniqBigCateSize >" + uniqBigCate.size());

		for (int i = 0; i < uniqBigCate.size(); i++) {
			for (DisplayCategoryVO category : allCategory) {
				if ((uniqBigCate.get(i).getDispClsfNo() == category.getDispClsfNo().intValue())
						|| (uniqBigCate.get(i).getDispClsfNo() == category.getMastDispNo().intValue())) {

					if (category.getLeafYn().equals("N")) {
						category.setCompNo(uniqBigCate.get(i).getCompNo());
						category.setDispClsfCd(category.getDispClsfCd());
						category.setStNm(uniqBigCate.get(i).getStNm());
						siteCategoryList.add(category);

					} else {
						for (DisplayCategoryVO checkLeafBrand : allCategory) {
							if (category.getDispClsfNo().intValue() == checkLeafBrand.getDispClsfNo().intValue()) {
								category.setCompNo(uniqBigCate.get(i).getCompNo());
								category.setDispClsfCd(category.getDispClsfCd());
								category.setStNm(uniqBigCate.get(i).getStNm());
								siteCategoryList.add(category);
							}
						}
					}
				}
			}
		}
		/*
		 * log.debug("uniqBigCate >" + uniqBigCate);
		 * log.debug("=================================================");
		 * log.debug("= {} : {}", "★★★★★★★★ siteCategory ★★★", siteCategoryList);
		 * log.debug("=================================================");
		 */
		// List<DisplayCategoryVO> bmList = new ArrayList<DisplayCategoryVO>();
		// // 브랜드몰
		// List<DisplayCategoryVO> wmList = new ArrayList<DisplayCategoryVO>();
		// // 월드몰

		Map<Long, ArrayList<DisplayCategoryVO>> resultStCMap = new HashMap<>();

		ArrayList<DisplayCategoryVO> t = new ArrayList<>();

		List<DisplayCategoryVO> templistBig = new ArrayList<>(); // 대카
		List<DisplayCategoryVO> templistUniqMid = new ArrayList<>(); // 중복제거한
																		// 중카
		List<DisplayCategoryVO> templistMid = new ArrayList<>(); // 중카

		//List<DisplayCategoryVO> resultList = new ArrayList<>();

		for (DisplayCategoryVO cate1 : siteCategoryList) {

			StStdInfoSO stso = new StStdInfoSO();
			stso.setCompNo(so.getCompNo());
			List<StStdInfoVO> strs = stService.getStList(stso);

			t.add(cate1);
			for (StStdInfoVO a : strs) {
				if (cate1.getStId().equals(a.getStId())) {
					resultStCMap.put(cate1.getStId(), t);
				}
			}

		}
		/*
		 * log.debug("=================================================");
		 * log.debug("= {} : {}", "resultStCMap", resultStCMap);
		 * log.debug("=================================================");
		 */
		for (Map.Entry<Long, ArrayList<DisplayCategoryVO>> entry : resultStCMap.entrySet()) {
			Long mapKey = entry.getKey();
			List<DisplayCategoryVO> cateList = entry.getValue();

			if (mapKey.equals(so.getStId())) {

				for (DisplayCategoryVO cate1 : cateList) {
					if (cate1.getLevel() == 1) { // 대카
						templistBig.add(cate1);
					}

					for (DisplayCategoryVO cate2 : cateList) { // 중카
						if (cate2.getLevel().intValue() == 2
								&& cate1.getUpDispClsfNo().intValue() == cate2.getDispClsfNo().intValue()) {
							templistMid.add(cate2);
						}
					}
				}

				LinkedHashSet<DisplayCategoryVO> hs = new LinkedHashSet<>(templistMid);
				Iterator<DisplayCategoryVO> it = hs.iterator();
				while (it.hasNext()) {

					templistUniqMid.add(it.next());
				}
				/* log.info("templistUniqMid >>>>" + templistUniqMid); */

				for (DisplayCategoryVO big : templistBig) {

					Long level1CateNo = big.getDispClsfNo();

					if (!templistUniqMid.isEmpty()) {
						for (DisplayCategoryVO cate2 : templistUniqMid) { // 중카테
							if (cate2.getUpDispClsfNo().intValue() == level1CateNo) {
								Long level2CateNo = cate2.getDispClsfNo(); // 중카테번호
								for (DisplayCategoryVO cate3 : siteCategoryList) {

									if (cate3.getLevel().intValue() == 3
											&& cate3.getUpDispClsfNo().intValue() == level2CateNo) {
										resultList.add(cate3);
									}
								}
							}

						}
					}
					viewCategories.add(big);
				}
				resultList.addAll(templistUniqMid);
				resultList.addAll(templistBig);

				/* log.info("resultList> " + resultList); */

			}
		}

		/*
		 * log.debug("=================================================");
		 * log.debug("= {} : {}", "★★★★★★★★ viewCategories ★★★ ", viewCategories);
		 * log.debug("=================================================");
		 */

		return resultList;
	}

	@Override
	public DisplayCategoryVO getDisplayBase(DisplayCategorySO so) {
		return displayDao.getDisplayBase(so);
	}

	@Override
	public void saveDisplayBase(DisplayCategoryPO po) {
		int result = 0;
		DisplayBannerPO displayBannerPO = new DisplayBannerPO();

		Long bnrNo = po.getDispBnrNo();
		if (bnrNo == null || bnrNo == 0) {
			bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BNR_SEQ);
//			// hjko 추가 수정  2017.12.21
//			if(this.dbmsType.equalsIgnoreCase("mysql")){
//				bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BNR_SEQ);
//			}else if(this.dbmsType.equalsIgnoreCase("oracle")){
//				bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BANNER_SEQ);
//			}else{
//				throw new CustomException(ExceptionConstants.ERROR_MAINDB_REQUIRED);
//			}
//			// hjko 추가 수정 끝 
		}

		displayBannerPO.setDispBnrNo(bnrNo);

		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		// PC이미지 처리
		if (ftpImgUtil.tempFileCheck(po.getBnrImgPath())) {
			String filePath = ftpImgUtil.uploadFilePath(po.getBnrImgPath(),
					AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
			ftpImgUtil.upload(po.getBnrImgPath(), filePath);
			po.setBnrImgPath(filePath);
		}

		// MOBILE이미지 처리
		if (ftpImgUtil.tempFileCheck(po.getBnrMobileImgPath())) {
			String filePath = ftpImgUtil.uploadFilePath(po.getBnrMobileImgPath(),
					AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
			ftpImgUtil.upload(po.getBnrMobileImgPath(), filePath);
			po.setBnrMobileImgPath(filePath);
		}

		DisplayCategorySO so = new DisplayCategorySO();
		so.setDispClsfNo(po.getDispClsfNo());
		DisplayCategoryVO vo = displayDao.getDisplayBase(so);

		if (vo != null) {
			// 수정
			if (CommonConstants.DISP_CLSF_10.equals(po.getDispClsfCd())) {
				// 최하위 여부를 변경한 경우,
				if (!StringUtils.equalsIgnoreCase(vo.getLeafYn(), po.getLeafYn())) {
					if (AdminConstants.LEAF_YN_Y.equals(po.getLeafYn())) {
						if (vo.getLowerDispCnt() > 0) {
							throw new CustomException(ExceptionConstants.ERROR_DISPLAY_CATEGORY_LOWER_IN_USE);
						}
					} else {
						int cnt = displayDao.getDisplayBaseLeafCheck(po);
						if (cnt > 0) {
							throw new CustomException(ExceptionConstants.ERROR_DISPLAY_LEAF);
						}
					}
				}

				try {
					// 대카테고리 이미지 처리, 대카테고리 등록일 때만 이미지를 등록함.
					if (ftpImgUtil.tempFileCheck(po.getTnImgPath())) {
						String filePath = ftpImgUtil.uploadFilePath(po.getTnImgPath(),
								AdminConstants.DISP_CLSF_IMAGE_PATH + FileUtil.SEPARATOR + po.getDispClsfNo());
						ftpImgUtil.upload(po.getTnImgPath(), filePath);
						po.setTnImgPath(filePath);
					}
				} catch (Exception e) {
					log.warn("대카테고리 이미지 수정 처리 중 에러 발생했습니다. {}", e);
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
			}

			// 전시 수정
			result = displayDao.updateDisplayBase(po);

			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			if (CommonConstants.DISP_CLSF_20.equals(po.getDispClsfCd()) && po.getDispLvl() == 2) {
				// 전시 배너 수정
				displayBannerPO.setDispClsfNo(po.getDispClsfNo());
				displayBannerPO.setBnrImgNm(po.getBnrImgNm());
				displayBannerPO.setBnrImgPath(po.getBnrImgPath());
				displayBannerPO.setBnrMobileImgNm(po.getBnrMobileImgNm());
				displayBannerPO.setBnrMobileImgPath(po.getBnrMobileImgPath());
				result = displayDao.updateDisplayBanner(displayBannerPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}

			// 전시 코너 drag&drop 우선순위 반영
			if (po.getDisplayCornerPOlist() != null && !po.getDisplayCornerPOlist().isEmpty()) {
				DisplayCornerPO displayCornerPO = new DisplayCornerPO();

				for (int i = 0; i < po.getDisplayCornerPOlist().size(); i++) {
					displayCornerPO.setDispCornNo(po.getDisplayCornerPOlist().get(i).getDispCornNo());
					displayCornerPO.setTmplNo(po.getDisplayCornerPOlist().get(i).getTmplNo());
					displayCornerPO.setDispPriorRank(po.getDisplayCornerPOlist().get(i).getDispPriorRank());

					result = displayDao.updateDisplayCorner(displayCornerPO);

					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}

			}
		} else {
			// 등록
			po.setDelYn(CommonConstants.DEL_YN_N);
			// hjko 추가. 2017.12.22
			po.setCfmYn(CommonConstants.COMM_YN_Y);

			if (CommonConstants.DISP_CLSF_10.equals(po.getDispClsfCd())) {
				/*
				 * 상위 카테고리가 최하위 여부 판단 2019.12.13 JYS
				 */
				so.setDispClsfNo(po.getUpDispClsfNo());
				vo = displayDao.getDisplayBase(so);

				if (vo != null && AdminConstants.LEAF_YN_Y.equals(vo.getLeafYn())) {
					throw new CustomException(ExceptionConstants.ERROR_DISPLAY_UP_LEAF);
				}

				/*
				 * 버그 : 신규 등록일 경우 getDispClsfNo가 NULL로 파일 경로가 저장됨. 수정 : DB저장 후 파일 업로드되게 수정
				 * 2019.12.13 JYS
				 * 
				 * try { // 대카테고리 이미지 처리, 대카테고리 등록일 때만 이미지를 등록함. if
				 * (ftpImgUtil.tempFileCheck(po.getTnImgPath())) { String filePath =
				 * ftpImgUtil.uploadFilePath(po.getTnImgPath(),
				 * AdminConstants.DISP_CLSF_IMAGE_PATH + FileUtil.SEPARATOR +
				 * po.getDispClsfNo()); ftpImgUtil.upload(po.getTnImgPath(), filePath);
				 * po.setTnImgPath(filePath); } } catch (Exception e) {
				 * log.warn("대카테고리 이미지 등록 처리 중 에러 발생했습니다. {}", e);
				 * log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e); }
				 * 
				 * // 전시 기본 등록 result = displayDao.insertDisplayBase(po);
				 * 
				 * if (result == 0) { throw new
				 * CustomException(ExceptionConstants.ERROR_CODE_DEFAULT); }
				 */

				// 전시 기본 등록
				result = displayDao.insertDisplayBase(po);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				} else {
					try {
						// 대카테고리 이미지 처리, 대카테고리 등록일 때만 이미지를 등록함.
						if (ftpImgUtil.tempFileCheck(po.getTnImgPath())) {
							String filePath = ftpImgUtil.uploadFilePath(po.getTnImgPath(),
									AdminConstants.DISP_CLSF_IMAGE_PATH + FileUtil.SEPARATOR + po.getDispClsfNo());
							ftpImgUtil.upload(po.getTnImgPath(), filePath);
							po.setTnImgPath(filePath);
						}
					} catch (Exception e) {
						log.warn("대카테고리 이미지 등록 처리 중 에러 발생했습니다. {}", e);
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}

					// 실제 이미지 경로로 변경
					displayDao.updateDisplayBase(po);
				}

			} else {
				po.setLeafYn(CommonConstants.LEAF_YN_N);

				if (po.getDispLvl() == 2) {
					po.setLeafYn(CommonConstants.LEAF_YN_Y);
				} else if (CommonConstants.DISP_CLSF_20.equals(po.getDispClsfCd()) && po.getDispLvl() == 3) {
					po.setLeafYn(CommonConstants.LEAF_YN_Y);
				}

				// 전시 기본 등록
				result = displayDao.insertDisplayBase(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				if (CommonConstants.DISP_CLSF_20.equals(po.getDispClsfCd()) && po.getDispLvl() == 2) {
					// 전시 배너 등록
					displayBannerPO.setDispClsfNo(po.getDispClsfNo());
					displayBannerPO.setBnrImgNm(po.getBnrImgNm());
					displayBannerPO.setBnrImgPath(po.getBnrImgPath());
					displayBannerPO.setBnrMobileImgNm(po.getBnrMobileImgNm());
					displayBannerPO.setBnrMobileImgPath(po.getBnrMobileImgPath());
					displayBannerPO.setDftBnrYn(CommonConstants.COMM_YN_Y);
					displayDao.insertDisplayBanner(displayBannerPO);
				}
			}

			// display_template 데이터 생성
			Long tmplNo = this.insertDisplayTmplNo(po);

			// display_category 업데이트
			if (tmplNo > 0) {
				DisplayCategoryPO updatePo = new DisplayCategoryPO();
				updatePo.setTmplNo(tmplNo);
				updatePo.setDispClsfNo(po.getDispClsfNo());
				displayDao.updateDisplayBase(updatePo);
			}
		}
		// 카테고리 필터 저장
		this.saveCategoryFilterInfo(po);
	}

	private Long insertDisplayTmplNo(DisplayCategoryPO po) {
		DisplayTemplatePO tmplPo = new DisplayTemplatePO();
		tmplPo.setStId(po.getStId().intValue());
		tmplPo.setTmplNm(po.getDispClsfNm());

		this.insertDisplayTemplate(tmplPo);
		return !ObjectUtils.isEmpty(tmplPo.getTmplNo()) ? tmplPo.getTmplNo() : 0L;
	}

	private void saveCategoryFilterInfo(DisplayCategoryPO po) {
		if (!CommonConstants.DISP_CLSF_10.equals(po.getDispClsfCd())) {
			return;
		}
		if (po.getDispLvl() < 2 || po.getDispClsfNo() == 0) {
			return;
		}

		// 기존 카테고리 필터 데이터 삭제
		int result = displayDao.deleteCategoryFilter(po);

		if (ObjectUtils.isEmpty(po.getCategoryFilters())) {
			return;
		}

		// 선택된 카테고리 필터 데이터 생성
		result = displayDao.insertCategoryFilter(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return;
	}

	@Override
	public void deleteDisplayBase(DisplayCategoryPO po) {
		// 전시 하위 카테고리 존재 여부 확인
		DisplayCategorySO so = new DisplayCategorySO();
		so.setDispClsfNo(po.getDispClsfNo());
		DisplayCategoryVO vo = displayDao.getDisplayBase(so);

		if (vo.getLowerDispCnt() <= 0) {
			// 카테고리에 해당하는 템플릿 데이터 삭제
			if (!ObjectUtils.isEmpty(po.getTmplNo())) {
				DisplayTemplatePO tmplPo = new DisplayTemplatePO();
				tmplPo.setTmplNo(po.getTmplNo());
				displayDao.deleteDisplayTemplate(tmplPo);
			}

			po.setDelYn(CommonConstants.DEL_YN_Y);

			int result = displayDao.deleteDisplayBase(po);

			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_DISPLAY_CATEGORY_LOWER_IN_USE);
		}
	}

	@Override
	public List<DisplayCornerVO> listDisplayCornerGrid(DisplayCornerSO so) {
		return displayDao.listDisplayCornerGrid(so);
	}

	@Override
	public void saveDisplayCorner(DisplayCornerPO po) {

		if (po.getDisplayCornerPOlist() != null && !po.getDisplayCornerPOlist().isEmpty()) {
			DisplayCornerPO displayCornerPO = new DisplayCornerPO();

			for (int i = 0; i < po.getDisplayCornerPOlist().size(); i++) {
				displayCornerPO.setDispCornNo(po.getDisplayCornerPOlist().get(i).getDispCornNo());
				displayCornerPO.setTmplNo(po.getDisplayCornerPOlist().get(i).getTmplNo());
				displayCornerPO.setDispPriorRank(po.getDisplayCornerPOlist().get(i).getDispPriorRank());

				int result = displayDao.updateDisplayCorner(displayCornerPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}

		} else {
			int result = 0;

			if (po.getDispCornNo() != null) {
				// 전시 코너 수정
				result = displayDao.updateDisplayCorner(po);
			} else {
				// 전시 코너 등록
				result = displayDao.insertDisplayCorner(po);
			}

			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}

	@Override
	public void SaveDisplayCornerAndDisplayClsfCorner(DisplayCornerPO po) {

		int result = 0;

		if (po.getDispCornNo() != null) {
			
			if(!StringUtil.equals(po.getDispCornTpCd(), po.getOrgValue())) {
				// 전시 코너에 속한 아이템 삭제
				displayDao.deleteDisplayCornerAllItem(po);
			}
			
			// 전시 코너 수정
			result = displayDao.updateDisplayCorner(po);
			
			if(StringUtil.isNotEmpty(po.getDispClsfCornNo()) && StringUtil.isNotEmpty(po.getDispYn()) && result != 0) {
				DisplayClsfCornerPO dccPo = new DisplayClsfCornerPO();
				dccPo.setDispClsfCornNo(po.getDispClsfCornNo());
				dccPo.setDispClsfCornerStrtdt(po.getDispStrtdt());
				dccPo.setDispClsfCornerEnddt(po.getDispEnddt());
				dccPo.setDispPrdSetYn(StringUtil.equals(po.getDispYn(), CommonConstants.COMM_YN_Y) ? "N" : "Y" );
				result = displayDao.updateDisplayClsfCorner(dccPo);
			}
			
		} else {
			// 전시 코너 등록
			result = displayDao.insertDisplayCorner(po);
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public int deleteDisplayCorner(DisplayCornerPO po) {
		int result = 0;

		// 전시 코너에 속한 아이템 삭제
		displayDao.deleteDisplayCornerAllItem(po);

		// 전시 코너에 속한 전시 분류 코너 삭제
		displayDao.deleteDisplayClsfCornerAll(po);

		// 전시 코너 삭제
		result = displayDao.deleteDisplayCorner(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}

	@Override
	public void saveDisplayCornerItem(DisplayPO po, DisplayCornerItemPO displayCornerItemPO, String[] tagNos) {
		int result = 0;
		DisplayCornerItemVO displayCornerItemVO = null;
		DisplayBannerPO displayBannerPO = new DisplayBannerPO();
		List<DisplayCornerItemPO> displayCornerItemPOList = po.getDisplayCornerItemPOList();
		DispCornerItemTagMapPO tmpo = new DispCornerItemTagMapPO();

		if (displayCornerItemPOList != null && !displayCornerItemPOList.isEmpty()) {
			for (DisplayCornerItemPO item : displayCornerItemPOList) {
				// 전시 코너 아이템 생성 여부 확인
				displayCornerItemVO = checkDisplayCornerItem(item);

				if (CommonConstants.DISP_CORN_TP_20.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_30.equals(item.getDispCornTpCd())) { // 배너 TEXT 수정 / 메뉴 리스트
					// 전시 배너 수정
					displayBannerPO.setDispClsfNo(item.getDispClsfNo());
					displayBannerPO.setDispBnrNo(item.getDispBnrNo());
					displayBannerPO.setBnrText(item.getBnrText());
					displayBannerPO.setBnrLinkUrl(item.getBnrLinkUrl());
					displayBannerPO.setBnrMobileLinkUrl(item.getBnrMobileLinkUrl());
					displayDao.updateDisplayBanner(displayBannerPO);
					// 전시 코너 아이템 수정
					displayDao.updateDisplayCornerItem(item);

					result++;
//				} else if (CommonConstants.DISP_CORN_TP_60.equals(item.getDispCornTpCd()) ||	// 상품
//							 CommonConstants.DISP_CORN_TP_80.equals(item.getDispCornTpCd()) || 	// 태그 리스트
//							 CommonConstants.DISP_CORN_TP_30.equals(item.getDispCornTpCd()) ||
//							 CommonConstants.DISP_CORN_TP_30.equals(item.getDispCornTpCd())	 )  {	
//					if (displayCornerItemVO == null) {
//						// 전시 코너 아이템 등록
//						item.setDelYn(CommonConstants.DEL_YN_N);
//						displayDao.insertDisplayCornerItem(item);
//
//						result++;
//					} else {
//						// 전시 코너 아이템 수정
//						displayDao.updateDisplayCornerItem(item);
//
//						result++;
//					}
				} else if (CommonConstants.DISP_CORN_TP_71.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_72.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_73.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_74.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_75.equals(item.getDispCornTpCd())
						|| CommonConstants.DISP_CORN_TP_132.equals(item.getDispCornTpCd())//시리즈 미고정
						|| CommonConstants.DISP_CORN_TP_133.equals(item.getDispCornTpCd())//동영상 미고정
								) { // 배너 이미지+동영상 / 시리즈
					if (item.getDispCnrItemNo() != null) {
						// 전시 코너 아이템 수정
						displayDao.updateDisplayCornerItem(item);

						result++;
					} else {
						// 전시 코너 아이템 등록
						item.setDelYn(CommonConstants.DEL_YN_N);
						displayDao.insertDisplayCornerItem(item);

						result++;
					}
				} else {
					if (displayCornerItemVO == null) {
						// 전시 코너 아이템 등록
						item.setDelYn(CommonConstants.DEL_YN_N);
						displayDao.insertDisplayCornerItem(item);

						result++;
					} else {
						// 전시 코너 아이템 수정
						displayDao.updateDisplayCornerItem(item);

						result++;
					}
				}
				/*
				 * } else if (CommonConstants.DISP_CORN_TP_70.equals(item.getDispCornTpCd())) {
				 * // 상품평 if (displayCornerItemVO == null) { // 전시 코너 아이템 등록
				 * item.setDelYn(CommonConstants.DEL_YN_N);
				 * displayDao.insertDisplayCornerItem(item);
				 * 
				 * result++; } else { // 전시 코너 아이템 수정 displayDao.updateDisplayCornerItem(item);
				 * 
				 * result++; } }
				 */
			}
		} else {
			// 전시 코너 아이템(배너 TEXT / 배너 HTML / 배너 이미지 / 배너 복합 / 배너 이미지 큐브 / 10초 동영상)
			Long bnrNo = displayCornerItemPO.getDispBnrNo();
			if (bnrNo == null || bnrNo == 0) {

				bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BNR_SEQ);

				// hjko 추가 수정 2017.12.21
//				if(this.dbmsType.equalsIgnoreCase("mysql")){
//					bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BNR_SEQ);
//				}else if(this.dbmsType.equalsIgnoreCase("oracle")){
//					bnrNo = bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_BANNER_SEQ);
//				}else{
//					throw new CustomException(ExceptionConstants.ERROR_MAINDB_REQUIRED);
//				}
				displayBannerPO.setDispBnrNo(bnrNo);
			}

			FtpImgUtil ftpImgUtil = new FtpImgUtil();

			// PC이미지 처리
			if (ftpImgUtil.tempFileCheck(displayCornerItemPO.getBnrImgPath()) && StringUtils.isNotBlank(displayCornerItemPO.getBnrImgPath())) {
				String filePath = ftpImgUtil.uploadFilePath(displayCornerItemPO.getBnrImgPath(),
						AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
				ftpImgUtil.upload(displayCornerItemPO.getBnrImgPath(), filePath);
				displayCornerItemPO.setBnrImgPath(filePath);
			}

			// MOBILE이미지 처리
			if (ftpImgUtil.tempFileCheck(displayCornerItemPO.getBnrMobileImgPath()) && StringUtils.isNotBlank(displayCornerItemPO.getBnrMobileImgPath())) {
				String filePath = ftpImgUtil.uploadFilePath(displayCornerItemPO.getBnrMobileImgPath(),
						AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
				ftpImgUtil.upload(displayCornerItemPO.getBnrMobileImgPath(), filePath);
				displayCornerItemPO.setBnrMobileImgPath(filePath);
			}
			if (CommonConstants.DISP_CORN_TP_10.equals(displayCornerItemPO.getDispCornTpCd())
					|| CommonConstants.DISP_CORN_TP_20.equals(displayCornerItemPO.getDispCornTpCd())
					|| CommonConstants.DISP_CORN_TP_30.equals(displayCornerItemPO.getDispCornTpCd())
					|| CommonConstants.DISP_CORN_TP_72.equals(displayCornerItemPO.getDispCornTpCd())
					|| CommonConstants.DISP_CORN_TP_73.equals(displayCornerItemPO.getDispCornTpCd())
					|| CommonConstants.DISP_CORN_TP_75.equals(displayCornerItemPO.getDispCornTpCd())
//					|| CommonConstants.DISP_CORN_TP_40.equals(displayCornerItemPO.getDispCornTpCd())
			// ||
			// CommonConstants.DISP_CORN_TP_83.equals(displayCornerItemPO.getDispCornTpCd())
			) {
				if (displayCornerItemPO.getDispBnrNo() == null) {
					// 전시 배너 등록
					displayBannerPO.setBnrHtml(displayCornerItemPO.getBnrHtml());
					displayBannerPO.setDispStrtdt(displayCornerItemPO.getDispCornerItemStrtdt());
					displayBannerPO.setDispEnddt(displayCornerItemPO.getDispCornerItemEnddt());
					displayBannerPO.setBnrText(displayCornerItemPO.getBnrText());
					displayBannerPO.setBnrImgPath(displayCornerItemPO.getBnrImgPath());
					displayBannerPO.setBnrMobileImgPath(displayCornerItemPO.getBnrMobileImgPath());
					displayBannerPO.setDispClsfNo(displayCornerItemPO.getDispClsfNo());
					displayBannerPO.setBnrImgNm(displayCornerItemPO.getBnrImgNm());
					displayBannerPO.setBnrMobileImgNm(displayCornerItemPO.getBnrMobileImgNm());
					displayBannerPO.setBnrLinkUrl(displayCornerItemPO.getBnrLinkUrl());
					displayBannerPO.setBnrMobileLinkUrl(displayCornerItemPO.getBnrMobileLinkUrl());
					displayBannerPO.setBnrGbCd(displayCornerItemPO.getBnrGbCd());
					displayBannerPO.setBnrDscrt(displayCornerItemPO.getBnrDscrt());

					if (CommonConstants.DISP_CORN_TP_10.equals(displayCornerItemPO.getDispCornTpCd())) {
						displayBannerPO.setBnrGbCd(AdminConstants.BNR_GB_40);
					}
					if (CommonConstants.DISP_CORN_TP_72.equals(displayCornerItemPO.getDispCornTpCd())
							&& displayCornerItemPO.getBnrVodGb().equals("vod")) {
						displayBannerPO.setBnrGbCd(AdminConstants.BNR_GB_20);
					}
					if (CommonConstants.DISP_CORN_TP_72.equals(displayCornerItemPO.getDispCornTpCd())
							&& displayCornerItemPO.getBnrVodGb().equals("bnr")) {
						displayBannerPO.setBnrGbCd(AdminConstants.BNR_GB_10);
					}

					displayDao.insertDisplayBanner(displayBannerPO);

					// 전시 코너 아이템 등록
					displayCornerItemPO.setDispBnrNo(displayBannerPO.getDispBnrNo());
					displayCornerItemPO.setDelYn(CommonConstants.DEL_YN_N);
					result = displayDao.insertDisplayCornerItem(displayCornerItemPO);

					// Long dispCnrItemNo =
					// bizService.getSequence(AdminConstants.SEQUENCE_DISPLAY_CORNER_ITEM_SEQ);

					if (tagNos != null && tagNos.length > 0) {
						Long maxNo = displayDao.maxDispItemNo();
						for (int i = 0; i < tagNos.length; i++) {

							tmpo.setDispCnrItemNo(maxNo);
							tmpo.setTagNo(tagNos[i]);

							result = dispCornerItemTagMapService.insertDispCornerItemTag(tmpo);
						}
					}
				} else {
					// 전시 배너 수정
					displayBannerPO.setBnrHtml(displayCornerItemPO.getBnrHtml());
					displayBannerPO.setDispStrtdt(displayCornerItemPO.getDispCornerItemStrtdt());
					displayBannerPO.setDispEnddt(displayCornerItemPO.getDispCornerItemEnddt());
					displayBannerPO.setBnrText(displayCornerItemPO.getBnrText());
					displayBannerPO.setDispClsfNo(displayCornerItemPO.getDispClsfNo());
					displayBannerPO.setDispBnrNo(displayCornerItemPO.getDispBnrNo());
					displayBannerPO.setBnrImgNm(displayCornerItemPO.getBnrImgNm());
					displayBannerPO.setBnrMobileImgNm(displayCornerItemPO.getBnrMobileImgNm());
					displayBannerPO.setBnrLinkUrl(displayCornerItemPO.getBnrLinkUrl());
					displayBannerPO.setBnrMobileLinkUrl(displayCornerItemPO.getBnrMobileLinkUrl());
					displayBannerPO.setBnrGbCd(displayCornerItemPO.getBnrGbCd());
					displayBannerPO.setBnrDscrt(displayCornerItemPO.getBnrDscrt());
					displayBannerPO.setBnrImgPath(displayCornerItemPO.getBnrImgPath());
					displayBannerPO.setBnrMobileImgPath(displayCornerItemPO.getBnrMobileImgPath());

					displayDao.updateDisplayBanner(displayBannerPO);

					// 전시 코너 아이템 태그 수정
					dispCornerItemTagMapService.deleteDispCornItemTag(displayCornerItemPO);

					if (tagNos != null && tagNos.length > 0) {
						for (int i = 0; i < tagNos.length; i++) {

							tmpo.setDispCnrItemNo(displayCornerItemPO.getDispCnrItemNo());
							tmpo.setTagNo(tagNos[i]);

							dispCornerItemTagMapService.insertDispCornerItemTag(tmpo);
						}
					}

					// 전시 코너 아이템 수정
					result = displayDao.updateDisplayCornerItem(displayCornerItemPO);

				}
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	public DisplayCornerItemVO checkDisplayCornerItem(DisplayCornerItemPO po) {
		DisplayCornerItemSO so = new DisplayCornerItemSO();

		so.setDispClsfCornNo(po.getDispClsfCornNo());
		so.setDispCornTpCd(po.getDispCornTpCd());
		so.setGoodsId(po.getGoodsId());
		so.setGoodsEstmNo(po.getGoodsEstmNo());
		so.setDispBnrNo(po.getDispBnrNo());
		so.setVdId(po.getVdId());
		so.setBnrNo(po.getBnrNo());
		so.setTagNo(po.getTagNo());
		so.setMbrNo(po.getMbrNo());
		so.setPetLogNo(po.getPetLogNo());
		so.setSrisNo(po.getSrisNo());

		return displayDao.getDisplayCornerItem(so);
	}

	@Override
	public void deleteDisplayCornerItem(DisplayPO po) {
		int result = 0;
		List<DisplayCornerItemPO> displayCornerItemPOList = po.getDisplayCornerItemPOList();

		if (displayCornerItemPOList != null && !displayCornerItemPOList.isEmpty()) {
			for (DisplayCornerItemPO item : displayCornerItemPOList) {
				// 전시 배너 삭제
				// displayDao.deleteDisplayBanner(item);
				// 전시 코너 아이템 삭제
				item.setDelYn(CommonConstants.DEL_YN_Y);
				displayDao.deleteDisplayCornerItem(item);

				result++;
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerGoodsGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerGoodsGrid(so);
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerGoodsEstmGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerGoodsEstmGrid(so);
	}

	@Override
	public List<DisplayBannerVO> listDisplayCornerBnrItemGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerBnrItemGrid(so);
	}

	@Override
	public List<DisplayGoodsVO> listDisplayGoodsGrid(DisplayGoodsSO so) {
		return displayDao.listDisplayGoodsGrid(so);
	}

	@Override
	public void saveDisplayGoods(DisplayPO po) {
		int result = 0;
		List<DisplayGoodsPO> displayGoodsPOList = po.getDisplayGoodsPOList();

		if (displayGoodsPOList != null && !displayGoodsPOList.isEmpty()) {

			DisplayCategorySO so = new DisplayCategorySO();
			so.setDispClsfNo(displayGoodsPOList.get(0).getDispClsfNo());
			DisplayCategoryVO vo = displayDao.getDisplayBase(so);

			if (AdminConstants.LEAF_YN_Y.equals(vo.getLeafYn())) {
				for (DisplayGoodsPO item : displayGoodsPOList) {
					// 대표 전시 여부를 체크한 경우,
					if (CommonConstants.DISP_YN_Y.equals(item.getDlgtDispYn())) {
						// 전시 상품 대표 전시 여부 모두 'N' 업데이트
						displayDao.updateAllDlgtDispN(item);
					}

					// 전시 상품 수정
					displayDao.updateDisplayGoods(item);

					// 쇼룸 전시 분류 번호
//					displayDao.deleteDisplayGoodsShowroom(item);

					if (StringUtil.isNotBlank(item.getSrDispClsfNoArr())) {
						String[] srDispClsfNoArr = item.getSrDispClsfNoArr().split(",");

						if (srDispClsfNoArr != null && srDispClsfNoArr.length > 0) {
							for (String srNo : srDispClsfNoArr) {
								item.setSrDispClsfNo(srNo);
								// 전시 상품 쇼룸 등록
//								displayDao.insertDisplayGoodsShowroom(item);
							}
						}
					}

					// 대표 전시 여부를 체크 안한 경우,
					if (CommonConstants.DISP_YN_N.equals(item.getDlgtDispYn())) {
						// 전시 상품 대표 존재 여부 체크
						int cnt = displayDao.getDisplyGoodsCheck(item);

						// 현재 카테고리에서 대표 여부가 없다면,
						if (cnt == 0) {
							throw new CustomException(ExceptionConstants.ERROR_DISPLAY_GOODS_DELEGATE_NO_USE);
						}

					}

					result++;
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void insertDisplayGoods(List<DisplayGoodsPO> list) {
		if (list != null && !list.isEmpty()) {
			DisplayCategorySO so = new DisplayCategorySO();
			so.setDispClsfNo(list.get(0).getDispClsfNo());
			DisplayCategoryVO vo = displayDao.getDisplayBase(so);
			if (AdminConstants.LEAF_YN_Y.equals(vo.getLeafYn())) {
				for (DisplayGoodsPO po : list) {
					int result = displayDao.insertDisplayGoods(po);

					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteDisplayGoods(DisplayPO po) {
		int result = 0;
		List<DisplayGoodsPO> displayGoodsPOList = po.getDisplayGoodsPOList();

		if (displayGoodsPOList != null && !displayGoodsPOList.isEmpty()) {
			for (DisplayGoodsPO item : displayGoodsPOList) {
				// 전시 상품 삭제
				displayDao.deleteDisplayGoods(item);
				// 전시 상품 쇼룸 삭제
				displayDao.deleteDisplayGoodsShowroom(item);

				result++;
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayBrandVO> listDisplayBrandGrid(DisplayBrandSO so) {
		return displayDao.listDisplayBrandGrid(so);
	}

	@Override
	public void saveDisplayBrand(DisplayPO po) {
		int result = 0;
		List<DisplayBrandPO> displayBrandPOList = po.getDisplayBrandPOList();

		if (displayBrandPOList != null && !displayBrandPOList.isEmpty()) {
			DisplayCategorySO so = new DisplayCategorySO();
			so.setDispClsfNo(displayBrandPOList.get(0).getDispClsfNo());
			DisplayCategoryVO vo = displayDao.getDisplayBase(so);
			if (AdminConstants.LEAF_YN_Y.equals(vo.getLeafYn())) {
				for (DisplayBrandPO item : displayBrandPOList) {
					result = displayDao.updateDisplayBrand(item);
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void insertDisplayBrand(DisplayPO po) {
		List<DisplayBrandPO> displayBrandPOList = po.getDisplayBrandPOList();

		if (displayBrandPOList != null && !displayBrandPOList.isEmpty()) {
			DisplayCategorySO so = new DisplayCategorySO();
			so.setDispClsfNo(displayBrandPOList.get(0).getDispClsfNo());
			DisplayCategoryVO vo = displayDao.getDisplayBase(so);
			if (AdminConstants.LEAF_YN_Y.equals(vo.getLeafYn())
					|| (1 == vo.getDispLvl() && AdminConstants.DISP_CLSF_40.equals(vo.getDispClsfCd()))) {
				for (DisplayBrandPO brand : displayBrandPOList) {
					int result = displayDao.insertDisplayBrand(brand);

					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteDisplayBrand(DisplayPO po) {
		int result = 0;
		List<DisplayBrandPO> displayBrandPOList = po.getDisplayBrandPOList();

		if (displayBrandPOList != null && !displayBrandPOList.isEmpty()) {
			for (DisplayBrandPO item : displayBrandPOList) {
				result = displayDao.deleteDisplayBrand(item);
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public List<DisplayCategoryVO> listDisplayShowRoomCategory() {
		return displayDao.listDisplayShowRoomCategory();
	}

	@Override
	public List<DisplayGoodsVO> listDisplayShowRoomGoodsGrid(DisplayGoodsSO so) {
		return displayDao.listDisplayShowRoomGoodsGrid(so);
	}

	@Override
	public void insertDisplayShowRoomGoods(List<DisplayGoodsPO> list) {
		if (list != null && !list.isEmpty()) {
			for (DisplayGoodsPO po : list) {
				DisplayCategorySO so = new DisplayCategorySO();
				// 상품번호에 따른 전시분류번호 가져오기.
				so.setGoodsId(po.getGoodsId());

				DisplayCategoryVO vo = displayDao.getDispClsfNo(so);

				if (vo != null) {
					po.setDispClsfNo(vo.getDispClsfNo());

					int result = displayDao.insertDisplayShowRoomGoods(po);

					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				} else {
					throw new CustomException(ExceptionConstants.ERROR_DISPLAY_GOODS_DELEGATE_NO_USE);
				}
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteDisplayShowRoomGoods(DisplayPO po) {
		int result = 0;
		List<DisplayGoodsPO> displayGoodsPOList = po.getDisplayGoodsPOList();

		if (displayGoodsPOList != null && !displayGoodsPOList.isEmpty()) {
			for (DisplayGoodsPO item : displayGoodsPOList) {
				// 전시 상품 쇼룸 삭제
				displayDao.deleteDisplayGoodsShowroom(item);

				result++;
			}
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayClsfCornerVO> listDisplayClsfCornerGrid(DisplayClsfCornerSO so) {
		return displayDao.listDisplayClsfCornerGrid(so);
	}

	@Override
	public void saveDisplayClsfCorner(DisplayClsfCornerPO po) {
		int result = 0;

		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		// 2017.12.22 hjko 수정
		Long dispClsfCornNo = po.getDispClsfCornNo();
		dispClsfCornNo = bizService.getSequence(AdminConstants.SEQUENCE_DISP_CLSF_CORN_SEQ);

//		if (dispClsfCornNo == null || dispClsfCornNo == 0) {
//			if(this.dbmsType.equalsIgnoreCase("mysql")){
//				dispClsfCornNo = bizService.getSequence(AdminConstants.SEQUENCE_DISP_CLSF_CORN_SEQ);
//			}else if(this.dbmsType.equalsIgnoreCase("oracle")){
//				dispClsfCornNo = bizService.getSequence(AdminConstants.SEQUENCE_DISP_CLSF_CORNER_SEQ);
//			}else{
//				throw new CustomException(ExceptionConstants.ERROR_MAINDB_REQUIRED);
//			}
//			// hjko 추가 수정 끝
//		}

		// PC이미지 처리
		if (ftpImgUtil.tempFileCheck(po.getCornImgPath())) {
			String filePath = ftpImgUtil.uploadFilePath(po.getCornImgPath(),
					AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + dispClsfCornNo);
			ftpImgUtil.upload(po.getCornImgPath(), filePath);
			po.setCornImgPath(filePath);
		}

		// MOBILE이미지 처리
		if (ftpImgUtil.tempFileCheck(po.getCornMobileImgPath())) {
			String filePath = ftpImgUtil.uploadFilePath(po.getCornMobileImgPath(),
					AdminConstants.DISPLAY_IMAGE_PATH + FileUtil.SEPARATOR + dispClsfCornNo);
			ftpImgUtil.upload(po.getCornMobileImgPath(), filePath);
			po.setCornMobileImgPath(filePath);
		}

		if (po.getDispClsfCornNo() != null) {
			// 전시 분류 코너 수정
			result = displayDao.updateDisplayClsfCorner(po);
		} else {
			// 전시 분류 코너 등록
			po.setDispClsfCornNo(dispClsfCornNo);
			result = displayDao.insertDisplayClsfCorner(po);
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteDisplayClsfCorner(DisplayPO po) {
		int result = 0;
		List<DisplayClsfCornerPO> displayClsfCornerPOList = po.getDisplayClsfCornerPOList();
		DisplayCornerItemPO dciPO = new DisplayCornerItemPO();

		if (displayClsfCornerPOList != null && !displayClsfCornerPOList.isEmpty()) {
			for (DisplayClsfCornerPO item : displayClsfCornerPOList) {
				// 전시 분류 코너 삭제
				item.setDelYn(CommonConstants.DEL_YN_Y);
				displayDao.deleteDisplayClsfCorner(item);
				result++;

				if (result == 1) {
					dciPO.setDispClsfCornNo(item.getDispClsfCornNo());
					dciPO.setDelYn(item.getDelYn());
				}
			}
			// 전시 분류 코너에 속한 아이템 삭제
			displayDao.deleteDisplayCornerItemAll(dciPO);
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayCategoryVO> listDisplayCategory(DisplayCategorySO so) {
		return displayDao.listDisplayCategory(so);
	}

	@Override
	public void displayGoodsUpload(DisplayPO po) {
		int result = 0;
		List<DisplayGoodsPO> dipslayGoodsUploadPOList = po.getDipslayGoodsUploadPOList();

		if (dipslayGoodsUploadPOList != null && !dipslayGoodsUploadPOList.isEmpty()) {
			for (DisplayGoodsPO item : dipslayGoodsUploadPOList) {
				item.setDlgtDispYn(CommonConstants.COMM_YN_N);

				result = displayDao.insertDisplayGoods(item);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DisplayGoodsPO> validateBulkUpladGoods(List<DisplayGoodsPO> dipslayGoodsUploadPOList) {
		// 기획전 상품 엑셀 데이터 유효성 검사
		DisplayGoodsValidator goodsValidator = new DisplayGoodsValidator();

		for (DisplayGoodsPO po : dipslayGoodsUploadPOList) {
			goodsValidator.validateDisplayGoods(po);

		}

		return dipslayGoodsUploadPOList;
	}

	// ========================================================================
	// FO
	// ========================================================================

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: yhkim
	 * - 설명		: Category List 가져오기
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<DisplayCategoryVO> listCategory(DisplayCategorySO so) {
		return displayDao.listCategory(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: hjko
	 * - 설명		: leaf node 로 조상 node 찾기 (하위카테고리로 상위 카테고리 찾기)
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<DisplayCategoryVO> listAncestorCategory(DisplayCategorySO so) {
		return displayDao.listAncestorCategory(so);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayService.java
	* - 작성일		: 2016. 7. 22.
	* - 작성자		: hjko
	* - 설명		: leaf node 로 navigation[] 만들기
	 * </pre>
	 * 
	 * @param dispClsfNo
	 * @return
	 */
	@Override
	public Map<Long, String> getFullCategoryNaviList(Long dispClsfNo) {
		LinkedHashMap<Long, String> navigationStrMap = null;
		List<DisplayCategoryVO> navigationList = new ArrayList<>();
		DisplayCategorySO naviso = null;
		DisplayCategoryVO category = null;

		if (dispClsfNo != null) {
			navigationStrMap = new LinkedHashMap<>();
			naviso = new DisplayCategorySO();
			naviso.setDispClsfNo(dispClsfNo);
			category = this.displayDao.getDisplayBaseNavigation(naviso);

			navigationList.add(category);

			while (!category.getDispClsfCd().equals(category.getUpDispClsfNo().toString())) {
				naviso = new DisplayCategorySO();
				naviso.setDispClsfNo(category.getUpDispClsfNo());
				category = this.displayDao.getDisplayBaseNavigation(naviso);
				navigationList.add(category);

			}

			for (int i = navigationList.size() - 1; i >= 0; i--) {
				navigationStrMap.put(navigationList.get(i).getDispClsfNo(), navigationList.get(i).getDispClsfNm());
			}
		}

		return navigationStrMap;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 05. 29.
	 * - 작성자		: wyjeong
	 * - 설명		: 상품이 존재하는 전시 카테고리 목록 조회
	 * </pre>
	 * 
	 * @param so
	 */
	@Override
	public List<DisplayCategoryVO> listDisplayCategoryByGoodsYn(DisplayCategorySO so) {

		List<DisplayCategoryVO> viewCategories = new ArrayList<>();

		List<DisplayCategoryVO> allCategory = displayDao.listDisplayCategoryByDispYn(so);

		/*
		 * log.debug("=================================================");
		 * log.debug("= {} : {}", "★★★ all category ★★★", allCategory);
		 * log.debug("=================================================");
		 */

		for (DisplayCategoryVO cate : allCategory) {
			// 상품이 있는 카테고리만 add
			if (getGoodsCnt(cate, allCategory) > 0) {
				viewCategories.add(cate);
			}
		}

		for (DisplayCategoryVO cate : viewCategories) {
			if (cate.getLeafYn().equals("N")) { // 서브 카테고리가 있으면..
				List<DisplayCategoryVO> subCateList = viewCategories.stream()
						.filter(item -> Objects.equals(item.getUpDispClsfNo(), cate.getDispClsfNo()))
						.collect(Collectors.toList());

				cate.setSubDispCateList(subCateList);
			}
		}
		/*
		 * log.debug("=================================================");
		 * log.debug("= {} : {}", "★★★ display category ★★★ ", viewCategories);
		 * log.debug("=================================================");
		 */

		return viewCategories;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 05. 29.
	 * - 작성자		: wyjeong
	 * - 설명		: 해당 카테고리, 서브 카테고리의 상품 개수 조회
	 * </pre>
	 * 
	 * @param category
	 * @param cateList
	 */
	private int getGoodsCnt(DisplayCategoryVO category, List<DisplayCategoryVO> cateList) {
		int goodsCnt = 0;

		List<DisplayCategoryVO> subCateList = cateList.stream()
				.filter(item -> Objects.equals(item.getUpDispClsfNo(), category.getDispClsfNo()))
				.collect(Collectors.toList());

		if (subCateList == null || subCateList.isEmpty()) {
			return category.getGoodsCnt();
		}

		for (DisplayCategoryVO cate : subCateList) {
			goodsCnt += getGoodsCnt(cate, cateList);
		}

		return goodsCnt;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 07. 07.
	 * - 작성자		: wyjeong
	 * - 설명		: 스토어, 디자이너, 브랜드 샵 전시 카테고리 목록 조회
	 * </pre>
	 * 
	 * @param so
	 */
	@Override
	public List<DisplayCategoryVO> listDisplayCategoryByComp(DisplayCategorySO so) {
		List<DisplayCategoryVO> categories = displayDao.listDisplayCategoryByComp(so);

		for (DisplayCategoryVO cate : categories) {
			if (cate.getLeafYn().equals("N")) { // 서브 카테고리가 있으면..
				List<DisplayCategoryVO> subCateList = categories.stream()
						.filter(item -> Objects.equals(item.getUpDispClsfNo(), cate.getDispClsfNo()))
						.collect(Collectors.toList());

				cate.setSubDispCateList(subCateList);
			}
		}

		return categories;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시 분류별 전시 코너 정보 전체 조회
	 * </pre>
	 * 
	 * @param dispClsfNo
	 * @param gso
	 * @return
	 */
	@Override
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalFO(Long dispClsfNo, GoodsListSO gso) {
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();

		// 1. 전시번호에 해당하는 코너목록 가져오기
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCorner(dispClsfNo);

		// 2. 코너 타입별 코너 아이템 조회
		DisplayCornerSO so = new DisplayCornerSO();

		for (DisplayCornerTotalVO corner : cornList) {

			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_10) || // 배너 HTML
					corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20) || // 배너 TEXT
					corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_30) || // 배너 이미지
					corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_75)) { // 배너

				so.setDispClsfNo(dispClsfNo);
				so.setDispCornNo(corner.getDispCornNo());
				so.setRows(corner.getShowCnt().intValue());
				List<DisplayBannerVO> bannerList = displayDao.pageDisplayCornerItemBnrFO(so);
				corner.setListBanner(bannerList);
			}

			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_60)) { // 상품

				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}

				gso.setDispClsfNo(dispClsfNo);
				gso.setDispCornNo(corner.getDispCornNo());
				gso.setRows(corner.getShowCnt().intValue());
				corner.setGoodsList(goodsService.pageGoodsByDispClsfCornNo(gso));
			}

			cornTotalList.add(corner);
		}

		return cornTotalList;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: CJA
	 * - 설명		: 전시 분류별 전시 코너 정보 전체 조회
	 * </pre>
	 * 
	 * @param dispClsfNo
	 * @param session
	 * @return
	 */
	@Override
	public List<DisplayCornerTotalVO> getPetTvDisplayCornerItemTotalFO(Long dispClsfNo, Session session,
			DisplayCornerSO cornSo) throws Exception {
		if (dispClsfNo == null) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();

		// 1. 전시번호에 해당하는 코너목록 가져오기
		// List<DisplayCornerTotalVO> cornList =
		// displayDao.listDisplayClsfCorner(dispClsfNo);

		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCornerDate(cornSo);
		
		String dupleNos = webConfig.getProperty("disp.corn.duple.no.main");
		String[] dupleNoStr = dupleNos.split(":");
		
		List<DisplayCornerTotalVO> dupleCornList = new ArrayList<DisplayCornerTotalVO>();
		
		//중복 제거 순서에 맞춰 생성 ( 567:570:568:569:572 = 순서[신규영상:최근본영상:인기영상:맞춤추천영상:관심TAG] )
		for(int i=0; i < dupleNoStr.length; i++) {
			DisplayCornerTotalVO tempVo = new DisplayCornerTotalVO();
			for (DisplayCornerTotalVO corner : cornList) {
				if(dupleNoStr[i].equals(corner.getDispCornNo().toString())) {
					tempVo = corner;
					dupleCornList.add(tempVo);
				}
			}
		}
		
		List<DisplayCornerTotalVO> notDupleCornList = new ArrayList<DisplayCornerTotalVO>(cornList);
		notDupleCornList.removeAll(dupleCornList);
		
		/*for (DisplayCornerTotalVO dupleCorner : dupleCornList) {
			for (DisplayCornerTotalVO corner : cornList) {
				if(dupleCorner.getDispCornNo().equals(corner.getDispCornNo())) {
					dupleCorner = corner;
				}
			}
		}*/

		// 2. 코너 타입별 코너 아이템 조회
		// DisplayCornerSO so = new DisplayCornerSO();
		
		// 중복 제거할 vdId 목록
		List<String> dupleVdIds = new ArrayList<String>();

		for (DisplayCornerTotalVO corner : dupleCornList) {
			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_10) || // 배너 HTML
					corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20) || // 배너 TEXT
					corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_30)) { // 배너 이미지

				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue());
				List<DisplayBannerVO> bannerList = displayDao.pageDisplayCornerItemBnrFO(cornSo);
				corner.setListBanner(bannerList);
			}
			
			// tv 최상단 배너
			if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.top.banner")))) {
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue());

				List<DisplayBannerVO> mainBannerList = displayDao.pageDisplayCornerItemMainBnrFO(cornSo);

				for (DisplayBannerVO mainBanner : mainBannerList) {
					Long dispCnrItemNo = mainBanner.getDispCnrItemNo();

					List<TagBaseVO> mainTagList = displayDao.bannerTagList(dispCnrItemNo);

					mainBanner.setBannerTagList(mainTagList);
				}

				corner.setMainBannerList(mainBannerList);
				corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			}
			// BO에서 등록한 신규 영상 리스트
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.new.vod")))) {
				
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue());
				List<VodVO> newVodList = this.pageDisplayCornerItemNewVodFOList(cornSo);
				
				// 신규영상은 1순위이기 때문에 중복제거 하지 않음. 중복제거할 vdid만 set
				if(newVodList.size() > 0) {
					for(VodVO newVod : newVodList) {
						dupleVdIds.add(newVod.getVdId());
					}
				}

				corner.setNewVodList(newVodList);
				corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			}
			// 최근 시청한 영상 목록 조회
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.recently.vod")))) {
				if (!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
					TvDetailSO tso = new TvDetailSO();

					tso.setMbrNo(session.getMbrNo());
					tso.setDupleVdIds(dupleVdIds);// 중복제거될 vdId
					List<TvDetailVO> recentVdoList = tvDetailService.selectRecentVdoList(tso);
							
					// 중복제거 조건추가.
					if(recentVdoList.size() > 0) {
						//for(TvDetailVO recentVod : recentVdoList) {
						//dupleVdIds.add(recentVod.getVdId());
						for(int i=0; i < 8; i++) {
							if(recentVdoList.size() > i){
								if(StringUtil.isNotEmpty(recentVdoList.get(i).getVdId())) {
									dupleVdIds.add(recentVdoList.get(i).getVdId());
								}
							}
						}
					}
					
					corner.setRecentlyList(recentVdoList);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				}
			}
			// BO에서 등록한 인기 영상 리스트
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.popular.vod")))) {
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue());
				cornSo.setDupleVdIds(dupleVdIds);
				List<VodVO> vodList = this.pageDisplayCornerItemPopVodFOList(cornSo);

				// 노출 개수보다 작으면 인기영상 추가
				if (vodList.size() < corner.getShowCnt().intValue()) {
					int showCnt = corner.getShowCnt().intValue();
					// 조회순 오리지널 인기영상
					VodSO vso = new VodSO();

					List<String> vdIds = new ArrayList<String>();
					for (int i = 0; i < vodList.size(); i++) {
						vdIds.add(vodList.get(i).getVdId());
					}
					
					vso.setDupleVdIds(dupleVdIds);
					vso.setVodList(vdIds);
					vso.setTpCd(CommonConstants.APET_TP_20);
					vso.setLimit(0);
					vso.setOffset(3);
					List<VodVO> vodNextList = this.pageDisplayCornerItemVodNexFO(vso);
					
					vodList.addAll(vodNextList);

					// 조회순 인기영상
					if (vodList.size() < corner.getShowCnt().intValue()) {
						int listCnt = vodList.size();
						int minValCnt = showCnt - listCnt;

						VodSO popso = new VodSO();

						List<String> vdIdList = new ArrayList<String>();
						for (int i = 0; i < vodList.size(); i++) {
							vdIdList.add(vodList.get(i).getVdId());
						}

						popso.setDupleVdIds(dupleVdIds);
						popso.setVodList(vdIdList);
						popso.setLimit(0);
						popso.setOffset(minValCnt);
						List<VodVO> vodPopNextList = this.pageDisplayCornerItemVodNexFO(popso);

						vodList.addAll(vodPopNextList);
					}
				}
				
				// 중복제거 조건추가.
				if(vodList.size() > 0) {
					for(VodVO vod : vodList) {
						dupleVdIds.add(vod.getVdId());
					}
				}

				corner.setPopularList(vodList);
				corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			}
			// 맞춤 추천 영상
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.custom.vod")))) {
				if (!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
					Map<String, String> requestParam = new HashMap<String, String>();
					requestParam.put("INDEX", "TV");
					requestParam.put("TARGET_INDEX", "tv-optimal");
					requestParam.put("MBR_NO", String.valueOf(session.getMbrNo()));
					requestParam.put("EXCLUDE_TVS", String.join(",", dupleVdIds)); // 제외할 vdId 
					requestParam.put("FROM", "1");
					requestParam.put("SIZE", String.valueOf(corner.getShowCnt().intValue()));

					List<VodVO> optimalVodList = new ArrayList<>();

					try {
						String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
						if (res != null) {
							ObjectMapper objectMapper = new ObjectMapper();
							Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
							Map<String, Object> statusMap = (Map) resMap.get("STATUS");
							if (((Integer) statusMap.get("CODE")).equals(200)) {
								Map<String, Object> dataMap = (Map) resMap.get("DATA");

								if ((int) dataMap.get("TOTAL") > 0) {
									List<Map<String, Object>> items = (List) dataMap.get("ITEM");
									VodVO vo;
									VodSO vso = new VodSO();
									vso.setMbrNo(session.getMbrNo());
									
									for (Map<String, Object> item : items) {
										vso.setVdId(String.valueOf(item.get("VD_ID")));
										vo = this.getVodDetail(vso); //영상 정보 조회
										if(vo != null) {
											vo.setTtl(String.valueOf(item.get("TTL")));
											vo.setThumPath(String.valueOf(item.get("THUM_PATH")));
											vo.setIntRate(Integer.valueOf(String.valueOf(item.get("RATE"))));
											optimalVodList.add(vo);
										}
									}

									// 중복제거 조건추가.
									if(optimalVodList.size() > 0) {
										for(VodVO optimalVod : optimalVodList) {
											dupleVdIds.add(optimalVod.getVdId());
										}
									}
									
									corner.setCustomList(optimalVodList);
									corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			// 회원의 경우 등록한 관심 태그의 관련 영상 노출
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.interested.vod")))) {
				if (!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
					cornSo.setDispClsfNo(dispClsfNo);
					cornSo.setDispCornNo(corner.getDispCornNo());
					cornSo.setRows(corner.getShowCnt().intValue());

					TagBaseSO tso = new TagBaseSO();

					tso.setMbrNo(session.getMbrNo());
					List<TagBaseVO> interestTagList = tagService.listTagBase(tso);

					if (interestTagList.size() < corner.getShowCnt().intValue()) {
						int showCnt = corner.getShowCnt().intValue();
						int listCnt = interestTagList.size();

						int minValCnt = showCnt - listCnt;

						List<String> tagNos = new ArrayList<String>();

						for (int i = 0; i < interestTagList.size(); i++) {
							tagNos.add(interestTagList.get(i).getTagNo());
						}

						cornSo.setListTag(tagNos);
						cornSo.setLimit(0);
						cornSo.setOffset(minValCnt);

						// BO에서 등록한 태그 리스트
						List<TagBaseVO> addTagList = displayDao.pageDisplayCornerTagListFO(cornSo);

						interestTagList.addAll(addTagList);

					}

					// 관심 태그 랜덤 리스트
					Collections.shuffle(interestTagList);
					
					tso.setTagNo(interestTagList.get(0).getTagNo());
					tso.setRows(10);
					// 관심 태그 영상 리스트
					tso.setDupleVdIds(dupleVdIds);
					tso.setSidx("HITS");
					tso.setSord("DESC");
					List<VodVO> interestVodList = this.tagVodList(tso);

					// 중복제거 조건추가.
					/*if(interestVodList.size() > 0) {
						for(VodVO interestVod : interestVodList) {
							dupleVdIds.add(interestVod.getVdId());
						}
					}*/
					
					// 관심 태그 영상 랜덤 리스트
					//Collections.shuffle(interestVodList);

					corner.setInterestTagList(interestTagList);
					corner.setInterestVodList(interestVodList);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				} else {
					cornSo.setDispClsfNo(dispClsfNo);
					cornSo.setDispCornNo(corner.getDispCornNo());
					cornSo.setLimit(0);
					cornSo.setOffset(corner.getShowCnt().intValue());
					List<TagBaseVO> tagList = displayDao.pageDisplayCornerTagListFO(cornSo);

					if (!StringUtil.isEmpty(tagList)) {
						TagBaseSO tso = new TagBaseSO();
						tso.setTagNo(tagList.get(0).getTagNo());
						tso.setRows(10);
						// 인기 태그 관련 영상 리스트
						tso.setDupleVdIds(dupleVdIds);
						tso.setSidx("HITS");
						tso.setSord("DESC");
						List<VodVO> relationVodList = this.tagVodList(tso);

						// 중복제거 조건추가.
						/*if(relationVodList.size() > 0) {
							for(VodVO relationVod : relationVodList) {
								dupleVdIds.add(relationVod.getVdId());
							}
						}*/
						
						// 관심 태그 영상 랜덤 리스트
						//Collections.shuffle(relationVodList);

						corner.setInterestTagList(tagList);
						corner.setInterestVodList(relationVodList);
						corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
					}
				}
				
				corner.setDupleVdIds(StringUtils.join(dupleVdIds, ", ")); //제외 영상vdIds 목록

			}
			// 광고 배너
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.advertising.banner")))) {
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setLimit(corner.getShowCnt().intValue());
				List<BannerVO> bannerList = displayDao.pageDisplayCornerItemBannerFO(cornSo);
				
				corner.setBannerList(bannerList);
				corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			}
			// 펫스쿨
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.petschool.vod")))) {
				MemberBaseSO mso = new MemberBaseSO();

				mso.setMbrNo(session.getMbrNo());
				
				//마지막 시청 이력 조회
				List<VodVO> vodHistList = this.apetEducationHist(mso);

				//마지막 시청 이력이 있으면 교육영상 시청기록유무 Y
				if (!StringUtil.isEmpty(vodHistList)) {
					vodHistList.get(0).setSchlViewYn("Y");
				}
				
				//마지막 시청 이력이 없으면 기본 펫스쿨영상 조회
				if (StringUtil.isEmpty(vodHistList)) {
					VodSO vso = new VodSO();
					
					//로그인 후 대표펫이 있으면 대표펫으로 검색
					if (!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
						if(StringUtil.isNotEmpty(session.getPetGbCd())) {//대표펫 등록 했으면						
							vso.setPetGbCd(session.getPetGbCd());
						}
					}
					
					vso.setLimit(corner.getShowCnt().intValue());
					List<VodVO> baseEduVod = this.baseEduVod(vso);

					corner.setPetSchoolList(baseEduVod);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				} else {
					List<CodeDetailVO> codeList = cacheService.listCodeCache(CommonConstants.EUD_CONTS_CTG_M, true, null, null, null, null, null);

					VodSO vso = new VodSO();

					List<String> vdIds = new ArrayList<String>();
					vdIds.add(vodHistList.get(0).getVdId());

					vso.setVodList(vdIds); //영상조회시 마지막 시청 이력 제거
					vso.setMbrNo(session.getMbrNo());
					vso.setPetGbCd(vodHistList.get(0).getPetGbCd());
					vso.setEudContsCtgMCd(vodHistList.get(0).getEudContsCtgMCd());
					List<VodVO> eduNextVod = this.eduNextVod(vso);

					vodHistList.addAll(eduNextVod);

					String defaultVal = vodHistList.get(vodHistList.size() - 1).getEudContsCtgMCd();
					String dtlCd = vodHistList.get(vodHistList.size() - 1).getEudContsCtgMCd();
					String nextDtlCd = "";

					loop: for (int i = 0; i < codeList.size(); i++) {
						for (int j = 0; j < codeList.size(); j++) {
							if(vodHistList.size() < corner.getShowCnt().intValue()){
								if (dtlCd.equals(codeList.get(j).getDtlCd())) {
									if (codeList.get(codeList.size() - 1).getDtlCd().equals(dtlCd)) {
										nextDtlCd = codeList.get(0).getDtlCd();
										dtlCd = codeList.get(0).getDtlCd();
										
										if (defaultVal.equals(nextDtlCd)) {
											break loop;
										}
										
										vso.setMbrNo(session.getMbrNo());
										vso.setPetGbCd(vodHistList.get(0).getPetGbCd());
										vso.setEudContsCtgMCd(nextDtlCd);
										vso.setLimit(corner.getShowCnt().intValue() - vodHistList.size());
										List<VodVO> eduNextVods = this.eduNextVod(vso);
										
										vodHistList.addAll(eduNextVods);
									} else {
										nextDtlCd = codeList.get(j + 1).getDtlCd();
										dtlCd = codeList.get(j + 1).getDtlCd();
										
										if (defaultVal.equals(nextDtlCd)) {
											break loop;
										}
										
										vso.setMbrNo(session.getMbrNo());
										vso.setPetGbCd(vodHistList.get(0).getPetGbCd());
										vso.setEudContsCtgMCd(nextDtlCd);
										vso.setLimit(corner.getShowCnt().intValue() - vodHistList.size());
										List<VodVO> eduNextVods = this.eduNextVod(vso);
										
										vodHistList.addAll(eduNextVods);
									}
								}
							}
						}
					}

					corner.setPetSchoolList(vodHistList);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				}
			}
			// BO에서 등록한 시리즈 목록
			else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.vod")))) {
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue());
				List<SeriesVO> seriesList = displayDao.pageDisplayCornerItemSeriesFO(cornSo);

				if (seriesList.size() < corner.getShowCnt().intValue()) {
					int showCnt = corner.getShowCnt().intValue();
					int listCnt = seriesList.size();

					int minValCnt = showCnt - listCnt;

					SeriesSO sso = new SeriesSO();

					List<Long> srisIds = new ArrayList<Long>();
					for (int i = 0; i < seriesList.size(); i++) {
						srisIds.add(seriesList.get(i).getSrisNo());
					}
					sso.setSeriesList(srisIds);
					sso.setLimit(0);
					sso.setOffset(minValCnt);

					// 인기 오리지널 시리즈 목록
					List<SeriesVO> list = displayDao.getOriginSeries(sso);

					seriesList.addAll(list);
				}

				corner.setSeriesList(seriesList);
				corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			}
			
			cornTotalList.add(corner);
		}
		
		
		//TV 전시 코너 추가 - 시리즈 TAG, 동영상 TAG 조회
		cornSo.setDupleVdIds(null);
		for(DisplayCornerTotalVO corner : notDupleCornList) {
			if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_130)) { //시리즈 TAG
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				
				List<TagBaseVO> tagList = displayDao.pageDisplayCornerTagListFO(cornSo); // BO에서 등록한 태그 리스트
				if(!StringUtil.isEmpty(tagList)) {
					List<String> tagNoList = new ArrayList<>();
					for(TagBaseVO vo : tagList) {
						tagNoList.add(vo.getTagNo());
					}
					cornSo.setCornTagNoList(tagNoList);
					cornSo.setLimit(0);
					cornSo.setOffset(corner.getShowCnt().intValue()+1);//더보기 버튼 컨트롤 위해 +1 해줌.
					
					List<SeriesVO> seriesList = displayDao.selectSeriesTagList(cornSo);
					if(!StringUtil.isEmpty(seriesList)) {
						Collections.shuffle(seriesList);
						corner.setSeriesTagList(seriesList);
						corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
					}
				}
			}else if(corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_131)) { //동영상 TAG
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				
				List<TagBaseVO> tagList = displayDao.pageDisplayCornerTagListFO(cornSo); // BO에서 등록한 태그 리스트
				if(!StringUtil.isEmpty(tagList)) {
					List<String> tagNmList = new ArrayList<>();
					for(TagBaseVO vo : tagList) {
						tagNmList.add(vo.getTagNm());
					}
					
					String tagNms = StringUtils.join(tagNmList, ",");
					
					Map<String,String> requestParam = new HashMap<String,String>();
					requestParam.put("INDEX","TV"); //추천대상서비스
					requestParam.put("TARGET_INDEX", "tag-related-tv"); //태그 관련 영상
					//requestParam.put("SIZE", corner.getShowCnt().toString());
					requestParam.put("SIZE", String.valueOf(corner.getShowCnt().intValue()+1));//더보기 버튼 컨트롤 위해 +1 해줌.
					requestParam.put("TAG_NM", tagNms);
					
					String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
					if(res != null) {
						List<VodVO> vodList = new ArrayList<>();
						
						ObjectMapper objectMapper = new ObjectMapper();
						Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
						Map<String, Object> statusMap = (Map)resMap.get("STATUS");
						if( ((Integer)statusMap.get("CODE")).equals(200) ) {
							Map<String, Object> dataMap = (Map)resMap.get("DATA");
							
							if( (int)dataMap.get("TOTAL") > 0 ) {
								List<Map<String, Object>> items = (List)dataMap.get("ITEM");
								VodVO vo;
								VodSO vso = new VodSO();
								vso.setMbrNo(session.getMbrNo());
								
								for (Map<String, Object> item : items) {
									vso.setVdId(String.valueOf(item.get("VD_ID")));
									vo = this.getVodDetail(vso); //영상 정보 조회
									if(vo != null) {
										vo.setThumPath(String.valueOf(item.get("THUM_PATH")));
										vodList.add(vo);
									}
								}

								corner.setTagVodList(vodList);
								corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
			        		}
			        	}
					}
				}
			}else if(corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_132)) { //시리즈 미고정
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue()+1);//더보기 버튼 컨트롤 위해 +1 해줌.
				cornSo.setDispCornTpCd(corner.getDispCornTpCd());				
				List<SeriesVO> seriesList = displayDao.pageDisplayCornerItemSeriesFO(cornSo); // BO에서 등록한 시리즈 리스트
				if(!StringUtil.isEmpty(seriesList)) {
					corner.setSeriesTagList(seriesList);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				}
				
				cornSo.setDispCornTpCd(null);
			}else if(corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_133)) { //동영상 미고정
				cornSo.setDispClsfNo(dispClsfNo);
				cornSo.setDispCornNo(corner.getDispCornNo());
				cornSo.setRows(corner.getShowCnt().intValue()+1);//더보기 버튼 컨트롤 위해 +1 해줌.
				
				List<VodVO> vodList = this.pageDisplayCornerItemPopVodFOList(cornSo); // BO에서 등록한 동영상 리스트
				if(!StringUtil.isEmpty(vodList)) {
					corner.setTagVodList(vodList);
					corner.setDispCornPage(getCornerPetTvPage(corner.getDispCornNo()));
				}
			}
			
			cornTotalList.add(corner);
		}
		
		
		List<DisplayCornerTotalVO> cornDispList = new ArrayList<>();
		// 중복 제거 순서에서 다시 노출 순서로 재정의
		for (DisplayCornerTotalVO corner : cornList) {
			for (DisplayCornerTotalVO totalCorner : cornTotalList) {
				if(corner.getDispCornNo().equals(totalCorner.getDispCornNo())) {
					corner = totalCorner;
				}
			}
			cornDispList.add(corner);
		}
		
		return cornDispList;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: YJU
	 * - 설명			: 전시 분류별 전시 코너 정보 전체 조회 ( PETSHOP )
	 * </pre>
	 * 
	 * @param dispClsfNo
	 * @param gso
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalPetShopFOTest(Long dispClsfNo, GoodsDispSO gso)
			throws JsonParseException, JsonMappingException, IOException {
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();

		// 1. 전시번호에 해당하는 코너목록 가져오기
		DisplayCornerSO so = new DisplayCornerSO();
		so.setDispClsfNo(dispClsfNo);
		so.setPreviewDt(gso.getPreviewDt());
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCornerDate(so);

		// seo번호 넣기
		if (cornList.size() > 0) {
			cornTotalList = getCornTotalList(dispClsfNo, gso, so, cornList);
		}
		return cornTotalList;
	}
	
	@SuppressWarnings("unchecked")
	private List<DisplayCornerTotalVO> getCornTotalList(Long dispClsfNo, GoodsDispSO gso, DisplayCornerSO so, List<DisplayCornerTotalVO> cornList) {
		DisplayCornerTotalVO tvo = new DisplayCornerTotalVO();
		tvo.setSeoInfoNo(cornList.get(0).getSeoInfoNo());
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<DisplayCornerTotalVO> ();
		for (DisplayCornerTotalVO corner : cornList) {

			if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.top.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.top.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.top.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.top.banner")))) {
				// 상단 배너
				so.setDispClsfNo(dispClsfNo);
				so.setDispCornNo(corner.getDispCornNo());
				so.setLimit(FrontConstants.PAGE_ROWS_20);
				List<BannerVO> topBannerList = displayDao.pageDisplayCornerItemBannerFO(so);
				if (topBannerList.size() > 0) {
					corner.setTopBannerList(topBannerList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
				}

			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.shortcut")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.shortcut")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.shortcut")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.shortcut")))) {
				// 바로가기 영역
				DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
				dciSo.setDispClsfNo(dispClsfNo);
				dciSo.setDispCornNo(corner.getDispCornNo());
				dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
				dciSo.setPreviewDt(so.getPreviewDt());
				List<DisplayBannerVO> shortCutList = displayDao.getBnrImgListFO(dciSo);
				
				if (shortCutList.size() > 0) {
					corner.setShortCutList(shortCutList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.recommend.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.recommend.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.recommend.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.recommend.goods")))) {
				// 사용자 맞춤
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				} else if (gso.getMbrNo() != null && gso.getMbrNo() != 0) {
					
					if (!StringUtil.isEmpty(gso.getPetNos())) {
						PetBaseSO petSO = new PetBaseSO();
						List<List<GoodsDispVO>> recommendTotalGoodsList = new ArrayList<>();
						String[] petNoArr = gso.getPetNos().split(",");
//							for(String petNoStr : petNoArr) {
						for(int j=0; j<petNoArr.length; j++) {
							
							Long petNo = new Long(petNoArr[j]).longValue();
							// 반려 동물 정보
							petSO.setPetNo(petNo);
							PetBaseVO petInfo = petService.getPetInfo(petSO);
							
							// PC/MOBILE 구분 코드
							String webMobileGbCd = 
								StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
								? CommonConstants.WEB_MOBILE_GB_10
								: CommonConstants.WEB_MOBILE_GB_20;
							// API
							Map<String, String> requestParam = new HashMap<String, String>();
							requestParam.put("INDEX", "SHOP"); // 추천대상서비스
							requestParam.put("TARGET_INDEX", "shop-optimal");
							requestParam.put("MBR_NO", String.valueOf(gso.getMbrNo()));
							requestParam.put("PET_NO", String.valueOf(petNo));
							requestParam.put("FROM", "1");
							requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
							requestParam.put("SIZE", "32");

							try {
								String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND,	requestParam);
								if (res != null) {
									ObjectMapper objectMapper = new ObjectMapper();
									Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
									Map<String, Object> statusMap = (Map) resMap.get("STATUS");

									if (((Integer) statusMap.get("CODE")).equals(200)) {
										Map<String, Object> dataMap = (Map) resMap.get("DATA");
										if ((int) dataMap.get("TOTAL") > 0) {
											List<Map<String, Object>> items = (List) dataMap.get("ITEM");
											String[] recoGoodsIds = new String[items.size()];
											for (int i=0 ; items.size() > i ; i++) {
												recoGoodsIds[i] = (String) items.get(i).get("GOODS_ID");
											}
											
											// 상품 정보(태그리스트, img, 찜여부 포함)
											PetBaseSO recoSo = new PetBaseSO();
											recoSo.setGoodsIds(recoGoodsIds);
											recoSo.setWebMobileGbCd(webMobileGbCd);
											recoSo.setMbrNo(gso.getMbrNo());
											List<GoodsDispVO> recommendGoodsList = displayDao.selectRecommendTotalGoodsList(recoSo);
											List<GoodsDispVO> returnRecommendGoodsList =  new ArrayList<>();
											for( GoodsDispVO gdvo: recommendGoodsList) { // 펫정보 추가
												GoodsDispVO returnVo = new GoodsDispVO();
												returnVo.setGoodsId(gdvo.getGoodsId());
												returnVo.setGoodsNm(gdvo.getGoodsNm());
												returnVo.setImgPath(gdvo.getImgPath());
												returnVo.setInterestYn(gdvo.getInterestYn());
												returnVo.setSaleAmt(gdvo.getSaleAmt());
												returnVo.setPetNm(petInfo.getPetNm());
												returnVo.setPetNo(petInfo.getPetNo());
												returnVo.setPetGbCd(petInfo.getPetGbCd());
												returnRecommendGoodsList.add(returnVo);
											}
											recommendTotalGoodsList.add(returnRecommendGoodsList);
										}
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						corner.setRecommendTotalGoodsList(recommendTotalGoodsList);
						corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
						corner.setDispCornNm(corner.getDispCornNm());
						corner.setDispClsfCornNo(corner.getDispClsfCornNo());
					} else {
						// 반려 동물 미등록 일 시 반려동물 등록 페이지 노출
						corner.setDispCornPage("petshopRegBanner.jsp");
					}
				} else {
					// 비회원 일 시 회원가입 페이지 노출
					corner.setDispCornPage("petshopRegMemberBanner.jsp");
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.offen.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.offen.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.offen.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.offen.goods")))) {
				// 자주 구매한 상품
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				} else if (gso.getMbrNo() != null && gso.getMbrNo() != 0) {
					List<GoodsDispVO> offenGoodsList = goodsDispService.getGoodsFrequentOrder(gso.getStId(), gso.getMbrNo(), gso.getDispClsfNo()
							, gso.getDeviceGb(), 32, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
					if (offenGoodsList.size() > 0) {
						corner.setOffenGoodsList(offenGoodsList);
						corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
						corner.setDispCornNm(corner.getDispCornNm());
						corner.setDispClsfCornNo(corner.getDispClsfCornNo());
					}
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.time.deal")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.time.deal")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.time.deal")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.time.deal")))) {
				// 타임딜
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> timeDealList = goodsDispService.getGoodsTimeDeal(gso.getStId(), gso.getMbrNo(),
						null, gso.getDispClsfNo(), corner.getDispClsfCornNo(), gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null);
				if (timeDealList.size() > 0) {
					int goodsCount = goodsDispService.countGoodsMain(gso.getStId(), gso.getMbrNo(), AdminConstants.GOODS_MAIN_DISP_TYPE_DEAL, gso.getDispClsfNo(),
							corner.getDispClsfCornNo(), gso.getDeviceGb(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null);
					corner.setTimeDealList(timeDealList);
					corner.setGoodsCount(goodsCount);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.stock.imminent")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.stock.imminent")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.stock.imminent")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.stock.imminent")))) {
				// 재고임박 폭풍할인
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> stockGoodsList = goodsDispService.getGoodsDc(gso.getStId(), gso.getMbrNo(), CommonConstants.GOODS_AMT_TP_50, gso.getDispClsfNo()
					, corner.getDispClsfCornNo(), gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
				if (stockGoodsList.size() > 0) {
					corner.setStockGoodsList(stockGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.expiration.date")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.expiration.date")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.expiration.date")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.expiration.date")))) {
				// 유통기한 임박 폭풍할인
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> expGoodsList = goodsDispService.getGoodsDc(gso.getStId(), gso.getMbrNo(), CommonConstants.GOODS_AMT_TP_40, gso.getDispClsfNo()
					, corner.getDispClsfCornNo(), gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
				if (expGoodsList.size() > 0) {
					corner.setExpGoodsList(expGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.ad.banner")))) {
				// 광고배너
				so.setDispClsfNo(dispClsfNo);
				so.setDispCornNo(corner.getDispCornNo());
				so.setLimit(corner.getShowCnt().intValue());
				List<BannerVO> adBannerList = displayDao.pageDisplayCornerItemBannerFO(so);
				if (adBannerList.size() > 0) {
					corner.setAdBannerList(adBannerList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.md.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.md.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.md.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.md.goods")))) {
				// MD 추천상품
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> mdGoodsList = goodsDispService.getGoodsMd(gso.getStId(), gso.getMbrNo(), null, gso.getDispClsfNo(), corner.getDispClsfCornNo()
					, gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
				if (mdGoodsList.size() > 0) {
					corner.setMdGoodsList(mdGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.best")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.best")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.best")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.best")))) {
				// 베스트 20
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				gso.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_MANUAL);
				// 수동 확인
				List<GoodsDispVO> bestGoodsList = goodsDispService.getGoodsBest(gso.getStId(), gso.getMbrNo(),
						gso.getDispType(), corner.getDispClsfCornNo(), gso.getDispClsfNo(), gso.getDeviceGb(), 20, 
						CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null, 20,	null);

				if (bestGoodsList.size() == 0) {
					gso.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO);
					bestGoodsList = goodsDispService.getGoodsBest(gso.getStId(), gso.getMbrNo(),
							gso.getDispType(), corner.getDispClsfCornNo(), gso.getDispClsfNo(), gso.getDeviceGb(), 20, 
							CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null, 20,	null);
				}
				
				if (bestGoodsList.size() > 0) {
					
					if(StringUtils.equals(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_MANUAL, gso.getDispType())) {
						Set<GoodsDispVO> bestGoodsCategorySet = new LinkedHashSet<>();
						// Manual
						List<String> cateCdMStr = bestGoodsList.stream().map(GoodsDispVO::getCateCdMStr).collect(Collectors.toList());
						List<String> cateNmMStr = bestGoodsList.stream().map(GoodsDispVO::getCateNmM).collect(Collectors.toList());
						int idx = 0;
						for(String cateCdMarr : cateCdMStr) {
							String[] cateCdMs = cateCdMarr.split(",");
							String[] cateNmMs = cateNmMStr.get(idx).split(",");
							int cateIdx = 0;
							for(String cateCdM : cateCdMs) {
								String cateNmM = cateNmMs[cateIdx];
								GoodsDispVO category = new GoodsDispVO();
								category.setCateSeq(Long.parseLong(cateCdM.split("_")[0]));
								category.setCateCdM(Long.parseLong(cateCdM.split("_")[1]));
								category.setCateNmM(cateNmM.split("_")[1]);
								bestGoodsCategorySet.add(category);
								cateIdx ++;
							}
							idx ++;
						}
						ArrayList bestGoodsCategoryList = new ArrayList(bestGoodsCategorySet.stream().sorted(Comparator.comparing(GoodsDispVO::getCateSeq)).collect(Collectors.toList()));
						corner.setBestGoodsCategoryList(bestGoodsCategoryList);
					} 
					corner.setBestGoodsList(bestGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.only.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.only.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.only.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.only.goods")))) {
				// 펫샵 단독 상품
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> onlyGoodsList = goodsDispService.getGoodsPetShop(gso.getStId(), gso.getMbrNo(), null, gso.getDispClsfNo()
					, corner.getDispClsfCornNo(), gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
				if (onlyGoodsList.size() > 0) {
					corner.setOnlyGoodsList(onlyGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.package.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.package.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.package.goods")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.package.goods")))) {
				// 패키지 상품
				if (gso == null) {
					throw new CustomException(ExceptionConstants.ERROR_PARAM);
				}
				List<GoodsDispVO> packageGoodsList = goodsDispService.getGoodsPackage(gso.getStId(), gso.getMbrNo(), null, gso.getDispClsfNo()
					, corner.getDispClsfCornNo(), null, gso.getDeviceGb(), corner.getShowCnt().intValue(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, 0, null, null);
				if (packageGoodsList.size() > 0) {
					corner.setPackageGoodsList(packageGoodsList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.poppetlog")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.poppetlog")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.poppetlog")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.poppetlog")))) {
				// 인기있는 펫로그
				List<DisplayPetLogVO> popPetLogList = goodsDispService.getDispPetLog(gso.getStId(), null, corner.getDispClsfCornNo(), corner.getShowCnt().intValue());
				if (popPetLogList.size() > 0) {
					corner.setPopPetLogList(popPetLogList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
					corner.setDispCornNm(corner.getDispCornNm());
				}
			} else if (corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.battom.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.battom.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.battom.ad.banner")))
					|| corner.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.battom.ad.banner")))) {
				// 광고배너 2
				so.setDispClsfNo(dispClsfNo);
				so.setDispCornNo(corner.getDispCornNo());
				so.setLimit(corner.getShowCnt().intValue());
				List<BannerVO> bottomAdBannerList = displayDao.pageDisplayCornerItemBannerFO(so);
				
				if (bottomAdBannerList.size() > 0) {
					corner.setAdBannerList(bottomAdBannerList);
					corner.setDispCornPage(getCornerPetShopPage(corner.getDispCornNo()));
				}
			}
			cornTotalList.add(corner);
		}
		cornTotalList.add(tvo);
		return cornTotalList;
	}

	@Override
	public List<DisplayCornerTotalVO> dvsnCorner1(Long dispClsfNo, GoodsDispSO gso)
			throws JsonParseException, JsonMappingException, IOException {
		DisplayCornerSO so = new DisplayCornerSO();
		so.setDispClsfNo(dispClsfNo);
		so.setPreviewDt(gso.getPreviewDt());
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCornerDate(so);
		int dvsnCornerCnt = 6;
		if(gso.getDvsnCornerCnt() != null) {
			dvsnCornerCnt = gso.getDvsnCornerCnt().intValue();
		}
		List<DisplayCornerTotalVO> dvsn1cornList = Lists.newArrayList(cornList.subList(0, cornList.size()< dvsnCornerCnt?cornList.size():dvsnCornerCnt));
		return getDisplayCornerItemTotalPetShopFO(dispClsfNo, gso, dvsn1cornList);
	}
	
	@Override
	public List<DisplayCornerTotalVO> dvsnCorner2(Long dispClsfNo, GoodsDispSO gso)
			throws JsonParseException, JsonMappingException, IOException {
		DisplayCornerSO so = new DisplayCornerSO();
		so.setDispClsfNo(dispClsfNo);
		so.setPreviewDt(gso.getPreviewDt());
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCornerDate(so);
		int dvsnCornerCnt = 6;
		if(gso.getDvsnCornerCnt() != null) {
			dvsnCornerCnt = gso.getDvsnCornerCnt().intValue();
		}
		List<DisplayCornerTotalVO> dvsn2cornList = Lists.newArrayList(cornList.subList(cornList.size()< dvsnCornerCnt?cornList.size():dvsnCornerCnt, cornList.size()));
		return getDisplayCornerItemTotalPetShopFO(dispClsfNo, gso, dvsn2cornList);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 08. 21.
	 * - 작성자		: ValFac
	 * - 설명		: 전시 분류별 전시 코너 정보 전체 조회 ( PETSHOP )
	 * </pre>
	 * 
	 * @param dispClsfNo
	 * @param gso
	 * @param cornList
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalPetShopFO(Long dispClsfNo, GoodsDispSO gso, List<DisplayCornerTotalVO> cornList)
			throws JsonParseException, JsonMappingException, IOException {
		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();

		// 1. 전시번호에 해당하는 코너목록 가져오기
		DisplayCornerSO so = new DisplayCornerSO();
		so.setDispClsfNo(dispClsfNo);
		so.setPreviewDt(gso.getPreviewDt());

		// 분류별 코너 셋팅
		if (cornList.size() > 0) {
			cornTotalList = getCornTotalList(dispClsfNo, gso, so, cornList);
		}
		return cornTotalList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 특정 전시 코너 정보 조회
	 * </pre>
	 * 
	 * @param dso
	 * @param gso
	 * @return
	 */
	@Override
	public DisplayCornerTotalVO getDisplayCornerItemFO(DisplayCornerSO dso, GoodsListSO gso) {
		DisplayCornerTotalVO cornerInfo = new DisplayCornerTotalVO();

		// 1. 전시번호에 해당하는 코너목록 가져오기
		List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCorner(dso.getDispClsfNo());

		// 2. 코너 타입별 코너 아이템 조회
		DisplayCornerSO so = new DisplayCornerSO();

		for (DisplayCornerTotalVO corner : cornList) {
			if (corner.getDispCornNo().equals(dso.getDispCornNo())) {
				if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_10) || // 배너 HTML
						corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20) || // 배너 TEXT
						corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_30)) { // 배너 이미지

					so.setDispClsfNo(dso.getDispClsfNo());
					so.setDispCornNo(corner.getDispCornNo());
					so.setRows(corner.getShowCnt().intValue());
					List<DisplayBannerVO> bannerList = displayDao.pageDisplayCornerItemBnrFO(so);
					corner.setListBanner(bannerList);
				}

				if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_60)) { // 상품

					if (gso == null) {
						throw new CustomException(ExceptionConstants.ERROR_PARAM);
					}

					gso.setDispClsfNo(dso.getDispClsfNo());
					gso.setDispCornNo(corner.getDispCornNo());
					gso.setRows(corner.getShowCnt().intValue());
					corner.setGoodsList(goodsService.pageGoodsByDispClsfCornNo(gso));
				}

				cornerInfo = corner;
				break;
			}
		}

		return cornerInfo;
	}

	@Override
	public List<DisplayCategoryVO> listDisplayHopeCategory(DisplayCategorySO so) {
		return displayDao.listDisplayHopeCategory(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 07. 05.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 카테고리 별 MD 추천상품 조회
	 * </pre>
	 * 
	 * @param so
	 */
	@Override
	public List<GoodsListVO> listMdRcomGoodsFO(GoodsListSO so) {
		return displayDao.listMdRcomGoodsFO(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 리스트 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<DisplayGroupBuyVO> pageGroupBuyGoods(DisplayGroupBuySO so) {
		return displayDao.pageGroupBuyGoods(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 상품이 속한 페이지 번호 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public DisplayGroupBuySO getGroupBuyGoodPage(DisplayGroupBuySO so) {
		return displayDao.getGroupBuyGoodPage(so);
	}

	@Override
	@Transactional(readOnly = true)
	public List<CodeDetailVO> getDistinctDispClsfCds(Long siteId) {
		return displayDao.getDistinctDispClsfCds(siteId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2020. 12. 23
	 * - 작성자		: valueFactory
	 * - 설명		: 카테고리 필터목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsFiltGrpPO> getCategoryFilters(DisplayCategorySO so) {
		return displayDao.getCategoryFilters(so);
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerBnrVdBnrGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerBnrVdBnrGrid(so);
	}

	// cja
	@Override
	public List<DisplayCornerItemVO> listDisplayCornerBannerGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerBannerGrid(so);
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerVdGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerVdGrid(so);
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerSeriesGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerSeriesGrid(so);
	}

	@Override
	public List<ApetContentsWatchHistVO> getContentWatchHist(Long mbrNo) {
		return displayDao.getContentWatchHist(mbrNo);
	}

	public String getCornerPetTvPage(Long dispCornNo) {

		String dispCornPage = "";

		if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.top.banner")).equals(dispCornNo)) {
			// 최상단 배너
			dispCornPage = "tvMainBanner.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.custom.vod")).equals(dispCornNo)) {
			// 맞춤 영상
			dispCornPage = "customVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.recently.vod")).equals(dispCornNo)) {
			// 최근 본 영상
			dispCornPage = "recentlyVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.new.vod")).equals(dispCornNo)) {
			// 신규 영상
			dispCornPage = "newVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.popular.vod")).equals(dispCornNo)) {
			// 인기 영상
			dispCornPage = "popularVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.advertising.banner")).equals(dispCornNo)) {
			// 광고 배너
			dispCornPage = "tvBanner.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.petschool.vod")).equals(dispCornNo)) {
			// 펫스쿨
			dispCornPage = "petSchoolVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.interested.vod")).equals(dispCornNo)) {
			// 내가 등록한 관심 TAG
			dispCornPage = "interestTagVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.vod")).equals(dispCornNo)) {
			// 오리지널 시리즈
			dispCornPage = "seriesVod.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_1")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_2")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_3")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_4")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_5")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_6")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_7")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_8")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_9")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.tag_10")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_1")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_2")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_3")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_4")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_5")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_6")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_7")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_8")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_9")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.tv.vod.tag_10")).equals(dispCornNo)
				) {
			// 시리즈 TAG, 동영상TAG, 시리즈(미고정), 동영상(미고정)
			dispCornPage = "srisVdoTag.jsp";
		}
		
		return dispCornPage;
	}
	// cja

	// yjy
	@Override
	public List<DisplayBannerVO> listDisplayCornerTagsGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerTagsGrid(so);
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMemberGrid(DisplayCornerItemSO so) {
		
		List<DisplayCornerItemVO> petLogMemberList = displayDao.listDisplayCornerPetLogMemberGrid(so);
		petLogMemberList.stream().forEach(v->{
            String replaceLoginId = bizService.twoWayDecrypt(v.getLoginId());
            if (StringUtil.isNotEmpty(replaceLoginId)) {
                v.setLoginId(replaceLoginId);
            }
        });
		
		return petLogMemberList;
	}

	@Override
	public List<DisplayCornerItemVO> listDisplayCornerLogsGrid(DisplayCornerItemSO so) {
		
		List<DisplayCornerItemVO> petLogList = displayDao.listDisplayCornerLogsGrid(so);
		petLogList.stream().forEach(v->{
            String replaceLoginId = bizService.twoWayDecrypt(v.getLoginId());
            if (StringUtil.isNotEmpty(replaceLoginId)) {
                v.setLoginId(replaceLoginId);
            }
        });
		
		return petLogList;
	}

	@Override
	public List<DisplayCategoryVO> listDisplayCategoryByDispYn(DisplayCategorySO so) {

		List<DisplayCategoryVO> viewCategories = new ArrayList<>();

		List<DisplayCategoryVO> allCategory = displayDao.listDisplayCategoryByDispYn(so);

		for (DisplayCategoryVO cate : allCategory) {
			if (StringUtil.equals(cate.getLeafYn(), "N")) { // 서브 카테고리가 있으면..
				List<DisplayCategoryVO> subCateList = allCategory.stream()
						.filter(item -> Objects.equals(item.getUpDispClsfNo(), cate.getDispClsfNo()))
						.sorted(Comparator.comparing(DisplayCategoryVO::getDispPriorRank))
						.collect(Collectors.toList());
				cate.setSubDispCateList(subCateList);
			}
			viewCategories.add(cate);
		}
		return viewCategories;
	}

	@Override
	public DisplayBannerVO getBnrTextFO(DisplayCornerItemSO so) {
		return displayDao.getBnrTextFO(so);
	}

	@Override
	public List<GoodsListVO> pageDisplayCornerItemBestGoodsFO(GoodsListSO so) {
		return displayDao.pageDisplayCornerItemBestGoodsFO(so);
	}

	// yjy

	@Override
	public List<DisplayBannerVO> listDisplayCornerBnrVodTagGrid(DisplayCornerItemSO so) {
		return displayDao.listDisplayCornerBnrVodTagGrid(so);
	}

	@Override
	public List<VodVO> pageDisplayCornerItemVodFO(VodSO so) {
		return displayDao.pageDisplayCornerItemVodFO(so);
	}

	@Override
	public List<VodVO> pageDisplayCornerItemVodNexFO(VodSO so) {
		return displayDao.pageDisplayCornerItemVodNexFO(so);
	}

	@Override
	public List<VodVO> pageDisplayCornerItemNewVodFO(VodSO so) {
		return displayDao.pageDisplayCornerItemNewVodFO(so);
	}

	@Override
	public List<VodVO> apetEducationHist(MemberBaseSO so) {
		return displayDao.apetEducationHist(so);
	}

	@Override
	public List<VodVO> baseEduVod(VodSO so) {
		return displayDao.baseEduVod(so);
	}

	@Override
	public List<VodVO> tagVodList(TagBaseSO so) {
		return displayDao.tagVodList(so);
	}

	@Override
	public List<VodVO> eduNextVod(VodSO so) {
		return displayDao.eduNextVod(so);
	}

	@Override
	public Long maxDispItemNo() {
		return displayDao.maxDispItemNo();
	}

	@Override
	public List<VodVO> schoolEduVod(VodSO so) {
		return displayDao.schoolEduVod(so);
	}

	@Override
	public List<DisplayBannerVO> pageDisplayCornerItemMainBnrFO(DisplayCornerSO so) {
		return displayDao.pageDisplayCornerItemMainBnrFO(so);
	}

	@Override
	public List<TagBaseVO> bannerTagList(Long dispCnrItemNo) {
		return displayDao.bannerTagList(dispCnrItemNo);
	}

	@Override
	public List<VodVO> schoolMainBanner(VodSO so) {
		return displayDao.schoolMainBanner(so);
	}

	public String getCornerPetShopPage(Long dispCornNo) {

		String dispCornPage = "";

		if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.top.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.top.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.top.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.top.banner")).equals(dispCornNo)) {
			// 상단 배너
			dispCornPage = "petshopTopBanner.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.shortcut")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.shortcut")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.shortcut")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.shortcut")).equals(dispCornNo)) {
			// 바로가기 영역
			dispCornPage = "petshopShortCut.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.recommend.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.recommend.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.recommend.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.recommend.goods")).equals(dispCornNo)) {
			// 사용자 맞춤 추천상품
			dispCornPage = "petshopRecommendGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.offen.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.offen.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.offen.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.offen.goods")).equals(dispCornNo)) {
			// 자주 구매한 상품
			dispCornPage = "petshopOffenGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.time.deal")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.time.deal")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.time.deal")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.time.deal")).equals(dispCornNo)) {
			// 타임딜
			dispCornPage = "petshopTimeDeal.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.ad.banner")).equals(dispCornNo)) {
			// 광고배너
			dispCornPage = "petshopAdBanner.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.stock.imminent")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.stock.imminent")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.stock.imminent")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.stock.imminent")).equals(dispCornNo)) {
			// 재고임박(폭풍할인)
			dispCornPage = "petshopStockGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.expiration.date")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.expiration.date")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.expiration.date")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.expiration.date")).equals(dispCornNo)) {
			// 유통기한임박(폭풍할인)
			dispCornPage = "petshopExpGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.md.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.md.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.md.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.md.goods")).equals(dispCornNo)) {
			// MD 추천상품
			dispCornPage = "petshopMdGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.best")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.best")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.best")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.best")).equals(dispCornNo)) {
			// 베스트20
			dispCornPage = "petshopBestGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.only.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.only.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.only.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.only.goods")).equals(dispCornNo)) {
			// 펫샵 단독 상품
			dispCornPage = "petshopOnlyGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.package.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.package.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.package.goods")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.package.goods")).equals(dispCornNo)) {
			// 패키지 상품
			dispCornPage = "petshopPackageGoods.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.poppetlog")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.poppetlog")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.poppetlog")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.poppetlog")).equals(dispCornNo)) {
			// 인기있는 펫로그 후기
			dispCornPage = "petshopPopPetLog.jsp";
		} else if (Long.valueOf(webConfig.getProperty("disp.corn.no.dog.battom.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.cat.battom.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.fish.battom.ad.banner")).equals(dispCornNo)
				|| Long.valueOf(webConfig.getProperty("disp.corn.no.animal.battom.ad.banner")).equals(dispCornNo)) {
			// 광고배너2
			dispCornPage = "petshopAdBanner.jsp";
		}
		return dispCornPage;
	}

	public DisplayCornerTotalVO getCornerInfoToDispCornType(GoodsDispSO so) {
		return displayDao.getCornerInfoToDispCornType(so);
	}
	
	@Override
	public List<DisplayCornerTotalVO> getBestManual(GoodsDispSO so) {
		return displayDao.getBestManual(so);
	}
	
	@Override
	public void liveOnOff(DisplayCategoryPO po) {

		// 펫샵 메인 번호
		po.setUpDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop")));
		int result = displayDao.updateLiveYn(po);
		;

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<TagBaseVO> pageDisplayCornerTagListFO(DisplayCornerSO so) {
		return displayDao.pageDisplayCornerTagListFO(so);
	}

	@Override
	public List<DisplayCornerItemVO> getTagList(DisplayCornerItemSO so) {
		return displayDao.getTagList(so);
	}

	@Override
	public List<VodVO> pageDisplayCornerItemNewVodFOList(DisplayCornerSO so) {
		return displayDao.pageDisplayCornerItemNewVodFOList(so);
	}

	@Override
	public List<VodVO> pageDisplayCornerItemPopVodFOList(DisplayCornerSO so) {
		return displayDao.pageDisplayCornerItemPopVodFOList(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : 카테고리 필터 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsFiltGrpVO> foCategoryFilterInfo(GoodsFiltGrpSO so) {
		return displayDao.foCategoryFilterInfo(so);
	}

	@Override
	public List<GoodsFiltGrpVO> foSearchFilterInfo() {
		return displayDao.foSearchFilterInfo();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : 카테고리 필터 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsFiltAttrVO> foGetFiltAttr(GoodsFiltAttrSO so) {
		return displayDao.foGetFiltAttr(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 2. 18.
	 * - 작성자        : YKU
	 * - 설명          : 코너 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public DisplayCornerTotalVO getCornList(DisplayCornerSO so) {
		return displayDao.getCornList(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 2. 18.
	 * - 작성자        : CJA
	 * - 설명          : 인기 시리즈 배너 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<SeriesVO> getOriginSeries(SeriesSO so) {
		return displayDao.getOriginSeries(so);
	}

	@Override
	public VodVO getVodDetail(VodSO so) {
		return displayDao.getVodDetail(so);
	}

	@Override
	public List<DisplayCornerTotalVO> listDisplayClsfCornerDate(DisplayCornerSO so) {
		return displayDao.listDisplayClsfCornerDate(so);
	}

	@Override
	public List<DisplayBannerVO> getBnrImgListFO(DisplayCornerItemSO so) {
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}else {
			so.setPreviewDt(so.getPreviewDt());
		}
		return displayDao.getBnrImgListFO(so);
	}

	@Override
	public List<DisplayCornerTotalVO> getDisplayCornerItemCaterotyFO(GoodsDispSO gso, String dispCornTpCd) {

		List<DisplayCornerTotalVO> cornTotalList = new ArrayList<>();

		// 2dept 클릭
		if(StringUtil.equals(CommonConstants.DISP_CORN_TP_75, dispCornTpCd)) {
			DisplayCornerSO so = new DisplayCornerSO();
			// 배너만 조회
			List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCorner(gso.getCateCdM());
			for (DisplayCornerTotalVO corner : cornList) {
				if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_75)) { // 배너
					so.setDispClsfNo(gso.getCateCdM());
					so.setDispCornNo(corner.getDispCornNo());
					so.setRows(corner.getShowCnt().intValue());
					corner.setListBanner(displayDao.pageDisplayCornerItemBnrFO(so));
				}
				cornTotalList.add(corner);
				break;
			}
		}else if(StringUtil.equals(CommonConstants.DISP_CORN_TP_60, dispCornTpCd)) {
			// 싱품만 조회
			List<DisplayCornerTotalVO> cornList = displayDao.listDisplayClsfCorner(gso.getDispClsfNo());
			for (DisplayCornerTotalVO corner : cornList) {
				if (corner.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_60)) { // 상품
					corner.setRecommendGoodsList(goodsDispService.getGoodsCategory(gso.getStId(),
							corner.getDispClsfCornNo(), gso.getDeviceGb(), corner.getShowCnt().intValue(),
							CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N));
				}
				cornTotalList.add(corner);
				break;
			}
		}
		return cornTotalList;
	}

	@Override
	public DisplayCornerTotalVO getGoodsList(GoodsDispSO so) {

		DisplayCornerTotalVO goodsList = new DisplayCornerTotalVO();

		if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.recommend.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.recommend.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.recommend.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.recommend.goods")))) {
			// 사용자 맞춤
			if (so.getPetNo() != null && so.getPetNo() != 0) {
				// 반려 동물 정보
				PetBaseSO petSO = new PetBaseSO();
				petSO.setPetNo(so.getPetNo());
				petSO.setMbrNo(so.getMbrNo());
				PetBaseVO petInfo = petService.getPetInfo(petSO);
				String petNos = petService.getPetNos(petSO);
				
				if (!StringUtil.isEmpty(petInfo)) {
					// PC/MOBILE 구분 코드
					String webMobileGbCd = 
						StringUtils.equals(so.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
						? CommonConstants.WEB_MOBILE_GB_10
						: CommonConstants.WEB_MOBILE_GB_20;
					
					// API
					Map<String, String> requestParam = new HashMap<String, String>();
					requestParam.put("INDEX", "SHOP"); // 추천대상서비스
					requestParam.put("TARGET_INDEX", "shop-optimal");
					requestParam.put("MBR_NO", String.valueOf(so.getMbrNo()));
					requestParam.put("PET_NO", String.valueOf(so.getPetNo()));
					requestParam.put("FROM", String.valueOf(so.getPage() == 0 ? 1 : so.getPage()));
					requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
					requestParam.put("SIZE", String.valueOf(so.getRows()));
					
					List<GoodsDispVO> recommendGoodsList = new ArrayList<>();
					try {
						String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
						if (res != null) {
							ObjectMapper objectMapper = new ObjectMapper();
							Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
							Map<String, Object> statusMap = (Map) resMap.get("STATUS");

							if (((Integer) statusMap.get("CODE")).equals(200)) {
								Map<String, Object> dataMap = (Map) resMap.get("DATA");
								if ((int) dataMap.get("TOTAL") > 0) {
									List<Map<String, Object>> items = (List) dataMap.get("ITEM");
									GoodsDispVO vo;
									for (Map<String, Object> item : items) {
										vo = new GoodsDispVO();
										vo.setGoodsId((String) item.get("GOODS_ID"));
										vo.setGoodsNm((String) item.get("GOODS_NM"));
										vo.setSaleAmt(Long.valueOf((String) item.get("SALE_AMT")));
										vo.setIntRate(Integer.valueOf((String)item.get("RATE")));
										vo.setDispClsfCornNo(so.getDispClsfCornNo());
										recommendGoodsList.add(vo);
									}
									// 상품 태그리스트
									for (int i = 0; i < recommendGoodsList.size(); i++) {
										so.setGoodsId(recommendGoodsList.get(i).getGoodsId());
										recommendGoodsList.get(i).setGoodsTagList(
												tagService.listTagGoodsId(so.getGoodsId()));
										if(!StringUtil.isEmpty(goodsService.getGoodsMainImg(so.getGoodsId()))) {
											recommendGoodsList.get(i).setImgPath(goodsService.getGoodsMainImg(so.getGoodsId()).getImgPath());
										}
										recommendGoodsList.get(i).setInterestYn(goodsDispService.getInterestGoodsYN(so).getInterestYn());
									}
									goodsList.setRecommendGoodsList(recommendGoodsList);
									goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
									goodsList.setPetNm(petInfo.getPetNm());
									goodsList.setPetNos(petNos);
									goodsList.setGoodsCount((int) dataMap.get("TOTAL"));
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.offen.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.offen.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.offen.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.offen.goods")))) {
			// 자주 구매한 상품
			if (so.getMbrNo() != null && so.getMbrNo() != 0) {
				List<GoodsDispVO> offenGoodsList = goodsDispService.getGoodsFrequentOrder(so.getStId(), so.getMbrNo(),
						so.getCateCdL(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
						CommonConstants.COMM_YN_Y, so.getPage(), so.getRows(), so.getSearchMonth());
				int goodsCount = goodsDispService.countGoodsFrequentOrder(so.getStId(), so.getMbrNo(),
						so.getCateCdL(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
						CommonConstants.COMM_YN_Y, so.getSearchMonth());
				goodsList.setGoodsCount(goodsCount);
				goodsList.setOffenGoodsList(offenGoodsList);
				goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
			}
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.time.deal")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.time.deal")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.time.deal")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.time.deal")))) {
			// 타임딜
			List<GoodsDispVO> timeDealList = goodsDispService.getGoodsTimeDeal(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows());
			int goodsCount = goodsDispService.countGoodsMain(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(),
					so.getDispClsfCornNo(), so.getDeviceGb(), CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());
			
			goodsList.setGoodsCount(goodsCount);
			goodsList.setTimeDealList(timeDealList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.stock.imminent")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.stock.imminent")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.stock.imminent")))
				|| so.getDispCornNo()
						.equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.stock.imminent")))) {
			// 재고임박 폭풍할인
			List<GoodsDispVO> stockGoodsList = goodsDispService.getGoodsDc(so.getStId(), so.getMbrNo(),so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null,
					CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			int goodsCount = goodsDispService.countGoodsMain(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(),
					so.getDispClsfCornNo(), so.getDeviceGb(), CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());
			
			goodsList.setGoodsCount(goodsCount);
			goodsList.setStockGoodsList(stockGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.expiration.date")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.expiration.date")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.expiration.date")))
				|| so.getDispCornNo()
						.equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.expiration.date")))) {
			// 유통기한 임박 폭풍할인
			List<GoodsDispVO> expGoodsList = goodsDispService.getGoodsDc(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null,
					CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			int goodsCount = goodsDispService.countGoodsMain(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(),
					so.getDispClsfCornNo(), so.getDeviceGb(), CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());
			
			goodsList.setGoodsCount(goodsCount);
			goodsList.setExpGoodsList(expGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.md.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.md.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.md.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.md.goods")))) {
			// MD 추천상품
			List<GoodsDispVO> mdGoodsList = goodsDispService.getGoodsMd(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			int goodsCount = goodsDispService.countGoodsMain(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(),
					so.getDispClsfCornNo(), so.getDeviceGb(), CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());
			
			goodsList.setGoodsCount(goodsCount);
			goodsList.setMdGoodsList(mdGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.only.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.only.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.only.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.only.goods")))) {
			// 펫샵 단독 상품
			List<GoodsDispVO> onlyGoodsList = goodsDispService.getGoodsPetShop(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(),so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N, 
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			int goodsCount = goodsDispService.countGoodsMain(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(),
					so.getDispClsfCornNo(), so.getDeviceGb(), CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());
			
			goodsList.setGoodsCount(goodsCount);
			goodsList.setOnlyGoodsList(onlyGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.package.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.package.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.package.goods")))
				|| so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.package.goods")))) {
			// 패키지 상품			
			//기본 검색조건
			String filterConditionStr = (String) webConfig.get("disp.petshop.package.filters");
			List<String> filterCondition = (StringUtils.isNotEmpty(filterConditionStr)) ? Arrays.stream(filterConditionStr.split(",")).collect(Collectors.toList()) : null;
			so.setFilterCondition(filterCondition);
			List<GoodsDispVO> packageGoodsList = goodsDispService.getGoodsPackage(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getFilters(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N, 
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			int goodsCount = goodsDispService.countGoodsPackage(so.getStId(), so.getMbrNo(), so.getDispType(), so.getCateCdL(), so.getDispClsfCornNo(), so.getFilters(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getOrder());

			goodsList.setGoodsCount(goodsCount);
			goodsList.setPackageGoodsList(packageGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		}
		return goodsList;
	}
	
	@Override
	public DisplayCornerTotalVO getDispTypeCornerGoodsList(GoodsDispSO so) {

		DisplayCornerTotalVO goodsList = new DisplayCornerTotalVO();

		if (CommonConstants.GOODS_MAIN_DISP_TYPE_RCOM.equals(so.getDispType())) {
			// 사용자 맞춤
			if (so.getPetNo() != null && so.getPetNo() != 0) {
				
				// PC/MOBILE 구분 코드
				String webMobileGbCd = 
					StringUtils.equals(so.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
					? CommonConstants.WEB_MOBILE_GB_10
					: CommonConstants.WEB_MOBILE_GB_20;
				
				// API
				Map<String, String> requestParam = new HashMap<String, String>();
				requestParam.put("INDEX", "SHOP"); // 추천대상서비스
				requestParam.put("TARGET_INDEX", "shop-optimal");
				requestParam.put("MBR_NO", String.valueOf(so.getMbrNo()));
				requestParam.put("PET_NO", String.valueOf(so.getPetNo()));
				requestParam.put("FROM", String.valueOf(so.getPage() == 0 ? 1 : so.getPage()));
				requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
				requestParam.put("SIZE", String.valueOf(so.getRows()));
				
				List<GoodsDispVO> recommendGoodsList = new ArrayList<>();
				try {
					String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
					if (res != null) {
						ObjectMapper objectMapper = new ObjectMapper();
						Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
						Map<String, Object> statusMap = (Map) resMap.get("STATUS");

						if (((Integer) statusMap.get("CODE")).equals(200)) {
							Map<String, Object> dataMap = (Map) resMap.get("DATA");
							if ((int) dataMap.get("TOTAL") > 0) {
								List<Map<String, Object>> items = (List) dataMap.get("ITEM");
								GoodsDispVO vo;
								for (Map<String, Object> item : items) {
									vo = new GoodsDispVO();
									vo.setGoodsId((String) item.get("GOODS_ID"));
									vo.setGoodsNm((String) item.get("GOODS_NM"));
									vo.setSaleAmt(Long.valueOf((String) item.get("SALE_AMT")));
									vo.setIntRate(Integer.valueOf((String)item.get("RATE")));
									vo.setDispClsfCornNo(so.getDispClsfCornNo());
									recommendGoodsList.add(vo);
								}
								// 상품 태그리스트
								for (int i = 0; i < recommendGoodsList.size(); i++) {
									so.setGoodsId(recommendGoodsList.get(i).getGoodsId());
									recommendGoodsList.get(i).setGoodsTagList(
											tagService.listTagGoodsId(so.getGoodsId()));
									if(!StringUtil.isEmpty(goodsService.getGoodsMainImg(so.getGoodsId()))) {
										recommendGoodsList.get(i).setImgPath(goodsService.getGoodsMainImg(so.getGoodsId()).getImgPath());
									}
									recommendGoodsList.get(i).setInterestYn(goodsDispService.getInterestGoodsYN(so).getInterestYn());
								}
								goodsList.setRecommendGoodsList(recommendGoodsList);
								goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (CommonConstants.GOODS_MAIN_DISP_TYPE_OFFEN.equals(so.getDispType())) {
			// 자주 구매한 상품
			if (so.getMbrNo() != null && so.getMbrNo() != 0) {
				List<GoodsDispVO> offenGoodsList = goodsDispService.getGoodsFrequentOrder(so.getStId(), so.getMbrNo(),
						so.getCateCdL(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
						CommonConstants.COMM_YN_Y, so.getPage(), so.getRows(), so.getSearchMonth());
				goodsList.setOffenGoodsList(offenGoodsList);
				goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
			}
		} else if (CommonConstants.GOODS_MAIN_DISP_TYPE_DEAL_NOW.equals(so.getDispType()) || 
				   CommonConstants.GOODS_MAIN_DISP_TYPE_DEAL_SOON.equals(so.getDispType())) {
			// 타임딜
			List<GoodsDispVO> timeDealList = goodsDispService.getGoodsTimeDeal(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows());
			goodsList.setTimeDealList(timeDealList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (CommonConstants.GOODS_AMT_TP_50.equals(so.getDispType())) {
			// 재고임박 폭풍할인
			List<GoodsDispVO> stockGoodsList = goodsDispService.getGoodsDc(so.getStId(), so.getMbrNo(),so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null,
					CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			goodsList.setStockGoodsList(stockGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (CommonConstants.GOODS_AMT_TP_40.equals(so.getDispType())) {
			// 유통기한 임박 폭풍할인
			List<GoodsDispVO> expGoodsList = goodsDispService.getGoodsDc(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null,
					CommonConstants.COMM_YN_N, CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			goodsList.setExpGoodsList(expGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (CommonConstants.GOODS_MAIN_DISP_TYPE_MD.equals(so.getDispType())) {
			// MD 추천상품
			List<GoodsDispVO> mdGoodsList = goodsDispService.getGoodsMd(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N,
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			goodsList.setMdGoodsList(mdGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (CommonConstants.GOODS_MAIN_DISP_TYPE_PETSHOP.equals(so.getDispType())) {
			// 펫샵 단독 상품
			List<GoodsDispVO> onlyGoodsList = goodsDispService.getGoodsPetShop(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(),so.getDispClsfCornNo(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N, 
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			goodsList.setOnlyGoodsList(onlyGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		} else if (CommonConstants.GOODS_MAIN_DISP_TYPE_PACKAGE.equals(so.getDispType())) {
			// 패키지 상품			
			//기본 검색조건
			String filterConditionStr = (String) webConfig.get("disp.petshop.package.filters");
			List<String> filterCondition = (StringUtils.isNotEmpty(filterConditionStr)) ? Arrays.stream(filterConditionStr.split(",")).collect(Collectors.toList()) : null;
			so.setFilterCondition(filterCondition);
			List<GoodsDispVO> packageGoodsList = goodsDispService.getGoodsPackage(so.getStId(), so.getMbrNo(), so.getDispType()
					, so.getCateCdL(), so.getDispClsfCornNo(), so.getFilters(), so.getDeviceGb(), null, CommonConstants.COMM_YN_N, 
					CommonConstants.COMM_YN_N, so.getPage(), so.getRows(), so.getOrder());
			goodsList.setPackageGoodsList(packageGoodsList);
			goodsList.setDispCornPage(getCornerPetShopPage(so.getDispCornNo()));
		}
		return goodsList;
	}
	
	@Override
	public List<VodVO> myWishListTv(VodSO so) {
		return displayDao.myWishListTv(so);
	}

	@Override
	public List<PetLogBaseVO> myWishListLog(PetLogListSO so) {
		return displayDao.myWishListLog(so);
	}

	@Override
	public void noFavorites(TvDetailPO po) {
		int result = displayDao.noFavorites(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<BrandBaseVO> interestBrand(MemberInterestBrandSO so) {
		return displayDao.interestBrand(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 3. 3.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<BrandBaseVO> filterBrand(BrandBaseSO so) {
		return displayDao.filterBrand(so);
	}

	@Override
	public String updatePetGbCdLnbHistory(Long dispClsfNo, Long mbrNo) {

		String petGbCd = null;
		if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(dispClsfNo)) {
			petGbCd = CommonConstants.PET_GB_10;
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(dispClsfNo)) {
			petGbCd = CommonConstants.PET_GB_20;
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(dispClsfNo)) {
			petGbCd = CommonConstants.PET_GB_40;
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(dispClsfNo)) {
			petGbCd = CommonConstants.PET_GB_50;
		}

		MemberBasePO memberPo = new MemberBasePO();
		memberPo.setMbrNo(mbrNo);
		memberPo.setDlgtPetGbCd(petGbCd);
		memberPo.setSysUpdrNo(mbrNo);
		memberPo.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));

		String DlgtPetGbCd = petService.updateMemberDlgtPetGbCd(memberPo);
		
		return DlgtPetGbCd;
	}

	@Override
	public List<GoodsDispVO> getRecOtherPetGoodsList(GoodsDispSO so) {
		// 반려 동물 정보
		PetBaseSO petSO = new PetBaseSO();
		petSO.setPetNo(so.getPetNo());
		PetBaseVO petInfo = petService.getPetInfo(petSO);
		
		List<GoodsDispVO> recommendGoodsList = new ArrayList<>();
	
		if (!StringUtil.isEmpty(petInfo)) {
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getDeviceGb(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			// API
			Map<String, String> requestParam = new HashMap<String, String>();
			requestParam.put("INDEX", "SHOP"); // 추천대상서비스
			requestParam.put("TARGET_INDEX", "shop-optimal");
			requestParam.put("MBR_NO", String.valueOf(so.getMbrNo()));
			requestParam.put("PET_NO", String.valueOf(so.getPetNo()));
			requestParam.put("FROM", String.valueOf(so.getPage() == 0 ? 1 : so.getPage()));
			requestParam.put("SIZE", String.valueOf(so.getRows()));
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			
			try {
				String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
				if (res != null) {
					ObjectMapper objectMapper = new ObjectMapper();
					Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
					Map<String, Object> statusMap = (Map) resMap.get("STATUS");

					if (((Integer) statusMap.get("CODE")).equals(200)) {
						Map<String, Object> dataMap = (Map) resMap.get("DATA");
						if ((int) dataMap.get("TOTAL") > 0) {
							List<Map<String, Object>> items = (List) dataMap.get("ITEM");
							GoodsDispVO vo;
							for (Map<String, Object> item : items) {
								vo = new GoodsDispVO();
								vo.setGoodsId((String) item.get("GOODS_ID"));
								vo.setGoodsNm((String) item.get("GOODS_NM"));
								vo.setSaleAmt(Long.valueOf((String) item.get("SALE_AMT")));
								vo.setIntRate(Integer.valueOf((String)item.get("RATE")));
								vo.setPetNm(petInfo.getPetNm());
								vo.setPetGbCd(petInfo.getPetGbCd());
								vo.setGoodsCount((int) dataMap.get("TOTAL"));
								recommendGoodsList.add(vo);
							}
							// 상품 태그리스트
							for (int i = 0; i < recommendGoodsList.size(); i++) {
								so.setGoodsId(recommendGoodsList.get(i).getGoodsId());
								recommendGoodsList.get(i).setGoodsTagList(
										tagService.listTagGoodsId(so.getGoodsId()));
								if(!StringUtil.isEmpty(goodsService.getGoodsMainImg(so.getGoodsId()))) {
									recommendGoodsList.get(i).setImgPath(goodsService.getGoodsMainImg(so.getGoodsId()).getImgPath());
								}
								recommendGoodsList.get(i).setInterestYn(goodsDispService.getInterestGoodsYN(so).getInterestYn());
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return recommendGoodsList;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2021. 6. 16. 
	 * - 작성자		: 이동식
	 * - 설명			: 펫스쿨 메인 > 시청이력의 교육Intro, 교육영상 5초이상 시청한 갯수
	 * </pre>
	 * @param so
	 * @return
	 */
	public int selectEduWatchCount(VodSO so) {
		return displayDao.selectEduWatchCount(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 06. 21.
	 * - 작성자		: 이동식
	 * - 설명			: 시리즈 TAG 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> selectSeriesTagList(DisplayCornerSO so) {
		return displayDao.selectSeriesTagList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: LDS
	 * - 설명			: 공통 > 이벤트팝업 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<EventPopupVO> selectPopLayerEventList(EventPopupSO so) {
		return displayDao.selectPopLayerEventList(so);
	}

}