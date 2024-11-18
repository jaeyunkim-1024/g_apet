package biz.common.service;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.service.DisplayService;
import biz.app.goods.dao.FilterDao;
import biz.app.goods.dao.GoodsDispDao;
import biz.app.goods.model.GoodsDispSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.CodeGroupVO;
import biz.common.dao.BizDao;
import com.google.gson.Gson;
import framework.admin.handler.CacheHandler;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("cacheService")
public class CacheServiceImpl implements CacheService {

	@Autowired
	private BizDao bizDao;
	
	@Autowired
	private GoodsDispDao goodsDispDao;
	
	@Autowired
	private FilterDao filterDao;
	
	@Autowired
	private DisplayDao dispDao;

	@Autowired
	private DisplayService displayService;

	@Autowired
	private CacheHandler cacheHandler;

	
	/***************************************
	 * 공통 코드 캐쉬
	 ***************************************/

	/*
	 * 공통코드 목록
	 * @see biz.common.service.CacheService#listCodeCache()
	 */
	@Override
	public void listCodeCache() {
		List<CodeGroupVO> list = bizDao.listCodeAll();

		Map<String, List<CodeDetailVO>> codeMap = new HashMap<>();

		Map<String, Map<String, String>> codeValueMap = new HashMap<>();

		for(CodeGroupVO groupCode : list){
			Map<String, String> code = new HashMap<>();
			for(CodeDetailVO detailCode : groupCode.getListCodeDetailVO()){
				code.put(detailCode.getDtlCd(), detailCode.getDtlNm());
			}

			codeValueMap.put(groupCode.getGrpCd(), code);
			codeMap.put(groupCode.getGrpCd(), groupCode.getListCodeDetailVO());
		}

		cacheHandler.put(CommonConstants.CACHE_CODE_GROUP, list);

		cacheHandler.put(CommonConstants.CACHE_CODE, codeMap);

		cacheHandler.put(CommonConstants.CACHE_CODE_VALUE, codeValueMap);
		
	}

	/*
	 * 공통 코드 목록 재설정
	 * @see biz.common.service.CacheService#listCodeCacheRefresh()
	 */
	@Override
	public void listCodeCacheRefresh() {
		List<CodeGroupVO> list = bizDao.listCodeAll();

		Map<String, List<CodeDetailVO>> codeMap = new HashMap<>();

		Map<String, Map<String, String>> codeValueMap = new HashMap<>();

		for(CodeGroupVO groupCode : list){
			Map<String, String> code = new HashMap<>();
			for(CodeDetailVO detailCode : groupCode.getListCodeDetailVO()){
				code.put(detailCode.getDtlCd(), detailCode.getDtlNm());
			}

			codeValueMap.put(groupCode.getGrpCd(), code);
			codeMap.put(groupCode.getGrpCd(), groupCode.getListCodeDetailVO());
		}

		if(cacheHandler.getElement(CommonConstants.CACHE_CODE_GROUP) == null) {
			cacheHandler.put(CommonConstants.CACHE_CODE_GROUP, list);
		} else {
			cacheHandler.replace(CommonConstants.CACHE_CODE_GROUP, list);
		}

		if(cacheHandler.getElement(CommonConstants.CACHE_CODE) == null) {
			cacheHandler.put(CommonConstants.CACHE_CODE, codeMap);
		} else {
			cacheHandler.replace(CommonConstants.CACHE_CODE, codeMap);
		}

		if(cacheHandler.getElement(CommonConstants.CACHE_CODE_VALUE) == null) {
			cacheHandler.put(CommonConstants.CACHE_CODE_VALUE, codeValueMap);
		} else {
			cacheHandler.replace(CommonConstants.CACHE_CODE_VALUE, codeValueMap);
		}

	}

	/*
	 * 공토코드 목록 조회 (캐쉬)
	 * @see biz.common.service.CacheService#listCodeCache(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public List<CodeDetailVO> listCodeCache(String grpCd, String usrDfn1Val,String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val) {

		return this.listCodeCache(grpCd, false, usrDfn1Val,usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);
	}

	/*
	 * 공토코드 목록 조회 (캐쉬)
	 * useYn 이 true 면 Y 인것만 꺼내고 true 가 아니면 Y/N 구분없이 전체를 꺼낸다.
	 * @see biz.common.service.CacheService#listCodeCache(java.lang.String, boolean, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<CodeDetailVO> listCodeCache(String grpCd, boolean useYn, String usrDfn1Val,String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val) {

		Map<String, List<CodeDetailVO>> codeMap = (Map<String, List<CodeDetailVO>>) cacheHandler.getValue(CommonConstants.CACHE_CODE);

		List<CodeDetailVO> list = codeMap.get(grpCd);

		List<CodeDetailVO> tempList = new ArrayList<>();

		List<CodeDetailVO> newList = new ArrayList<>();

		if(list != null && !list.isEmpty()){
			final Boolean CODE_USING = Boolean.TRUE;
			if (CODE_USING == useYn) {
				// useYn 이 Y 인 코드를 필터링한다.
				for(CodeDetailVO codeDetail : list) {
					if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, codeDetail.getUseYn())) {
						tempList.add(codeDetail);
					}
				}
			}

			if(StringUtil.isBlank(usrDfn1Val) && StringUtil.isBlank(usrDfn2Val) && StringUtil.isBlank(usrDfn3Val) && StringUtil.isBlank(usrDfn4Val) && StringUtil.isBlank(usrDfn5Val) ){
				if (CODE_USING == useYn) {
					return tempList;
				} else {
					return list;
				}
			}

			if (CODE_USING == useYn) {
				list = tempList;
			}

			for(CodeDetailVO vo : list) {
				Boolean addCheck = true;
				if(CommonConstants.USE_YN_Y.equals(vo.getUseYn())){
					if(StringUtil.isNotBlank(usrDfn1Val) && !usrDfn1Val.equals(vo.getUsrDfn1Val()) && addCheck){
						addCheck = false;
					}
					if(StringUtil.isNotBlank(usrDfn2Val) && !usrDfn2Val.equals(vo.getUsrDfn2Val()) && addCheck){
						addCheck = false;
					}
					if(StringUtil.isNotBlank(usrDfn3Val) && !usrDfn3Val.equals(vo.getUsrDfn3Val()) && addCheck){
						addCheck = false;
					}
					if(StringUtil.isNotBlank(usrDfn4Val) && !usrDfn4Val.equals(vo.getUsrDfn4Val()) && addCheck){
						addCheck = false;
					}
					if(StringUtil.isNotBlank(usrDfn5Val) && !usrDfn5Val.equals(vo.getUsrDfn5Val()) && addCheck){
						addCheck = false;
					}
					
					if(addCheck){
						newList.add(vo);
					}
				}
			}
		}

		return newList;
	}

	/*
	 * 공통코드 단건 조회(캐쉬)
	 * @see biz.common.service.CacheService#getCodeCache(java.lang.String, java.lang.String)
	 */
	@Override
	public CodeDetailVO getCodeCache(String grpCd, String dtlCd) {
		CodeDetailVO codeDetail = null;

		Map<String, List<CodeDetailVO>> codeMap = (Map<String, List<CodeDetailVO>>) cacheHandler.getValue(CommonConstants.CACHE_CODE);

		List<CodeDetailVO> list = codeMap.get(grpCd);

		if(list != null && !list.isEmpty()){

			for(CodeDetailVO vo : list) {
				if(vo.getDtlCd().equals(dtlCd)){
					codeDetail = vo;
				}
			}
		}
		return codeDetail;
	}

	/*
	 * 공통코드 상세명 조회 (캐쉬)
	 * @see biz.common.service.CacheService#getCodeName(java.lang.String, java.lang.String)
	 */
	@Override
	public String getCodeName(String grpCd, String dtlCd) {
		//2021.06.02 kjhvf01 가져오지 못하는 오류로 수정
		String result = null;
		CodeDetailVO vo = this.getCodeCache(grpCd, dtlCd);
		if(vo != null) {
			result = vo.getDtlNm();
		}
		
		return result;
	}

	/***************************************
	 * 전시 카테고리 캐쉬
	 ***************************************/

	/*
	 * 전시 카테고리 목록
	 * @see biz.common.service.CacheService#listDisplayCategoryCache(java.lang.Long)
	 */
	@Override
	public void listDisplayCategoryCache(Long stId) {
		DisplayCategorySO so = new DisplayCategorySO();
		so.setStId(stId);
		so.setDispClsfCd(CommonConstants.DISP_CLSF_10);
		List<DisplayCategoryVO> categoryList = displayService.listDisplayCategoryByDispYn(so);

		cacheHandler.put(FrontConstants.CACHE_DISPLAY_CATEGORY, categoryList);
	}

	/*
	 * 전시 카테고리 목록 재설정
	 * @see biz.common.service.CacheService#listDisplayCategoryCacheRefresh(java.lang.Long)
	 */
	@Override
	public void listDisplayCategoryCacheRefresh(Long stId) {
		DisplayCategorySO so = new DisplayCategorySO();
		so.setStId(stId);
		so.setDispClsfCd(CommonConstants.DISP_CLSF_10);
		List<DisplayCategoryVO> categoryList = displayService.listDisplayCategoryByDispYn(so);

		cacheHandler.replace(FrontConstants.CACHE_DISPLAY_CATEGORY, categoryList);
	}

	/*
	 * 전시 카테고리 목록 조회(캐쉬)
	 * @see biz.common.service.CacheService#listDisplayCategory()
	 */
	@Override
	public List<DisplayCategoryVO> listDisplayCategory() {

		return (List<DisplayCategoryVO>)cacheHandler.getValue(FrontConstants.CACHE_DISPLAY_CATEGORY);
	}

	@Override
	public void initInterestTag() {
		bizDao.initInterestTag();
	}
	
	
	// --------------------------------- [[ cache start
	@Override
	public List selectGoodsBestManual(GoodsDispSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-selectGoodsBestManual"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = goodsDispDao.selectGoodsBestManual(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List<DisplayCornerTotalVO> listDisplayClsfCornerDate(DisplayCornerSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-listDisplayClsfCornerDate"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = dispDao.listDisplayClsfCornerDate(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List selectGoodsDc(GoodsDispSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-selectGoodsDc"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = goodsDispDao.selectGoodsDc(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List selectGoodsPackage(GoodsDispSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-selectGoodsPackage"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = goodsDispDao.selectGoodsPackage(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List selectGoodsMd(GoodsDispSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-selectGoodsMd"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = goodsDispDao.selectGoodsMd(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List<BrandBaseVO> filterGoodsBrand(BrandBaseSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-filterGoodsBrand"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = filterDao.filterGoodsBrand(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public List selectGoods(GoodsDispSO so) {
		Gson gson = new Gson();
		String paramKey = gson.toJson(so);
		
		String key = "apet-selectGoods"+paramKey;
		List retValue = (List) cacheHandler.getValue(key);
		if(retValue==null) {
			retValue = goodsDispDao.selectGoods(so);
			cacheHandler.put(key, retValue);
		}
		return retValue;
	}

	@Override
	public void initApetCache() {
		cacheHandler.initCache("apet-");
	}
	
	// --------------------------------- cache finish ]]

}
