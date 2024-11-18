package biz.app.goods.service;

import java.util.*;

import biz.app.display.model.DisplayGoodsPO;
import biz.app.display.model.SeoInfoPO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.model.*;
import biz.app.goods.model.SkuInfoVO.Ntfc;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.common.service.CacheService;
import biz.interfaces.cis.service.CisGoodsService;
import framework.common.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.attribute.model.AttributeSO;
import biz.app.goods.dao.GoodsBulkUploadDao;
import biz.app.goods.validation.GoodsValidator;
import biz.app.statistics.model.GoodsSO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class GoodsBulkUploadServiceImpl implements GoodsBulkUploadService {

	@Autowired private CacheService cacheService;

	@Autowired private GoodsService goodsService;

	@Autowired private ItemService itemService;

	@Autowired private GoodsPriceService goodsPriceService;

	@Autowired private GoodsDescService goodsDescService;

	@Autowired private CisGoodsService cisGoodsService;

	@Autowired private GoodsNaverEpInfoService goodsNaverEpInfoService;

	@Autowired private GoodsTagMapService goodsTagMapService;

	@Autowired private DisplayService displayService;

	@Autowired private GoodsNotifyService goodsNotifyService;

	@Autowired private GoodsIconService goodsIconService;
	@Autowired private SeoService seoService;

	@Autowired private GoodsBulkUploadDao goodsBulkUploadDao;

	@Autowired private GoodsBaseDao goodsBaseDao;

	@Autowired private TagDao tagDao;;

	@Autowired private Properties bizConfig;

	@Autowired
	private MessageSourceAccessor message;

	@Override
	@Deprecated
	public List<GoodsBulkUploadPO> bulkUploadGoods(List<GoodsBulkUploadPO> goodsBulkUploadPOList) {
		// Bean Copy
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
		GoodsValidator goodsValidator = new GoodsValidator();

		if(goodsBulkUploadPOList != null && !goodsBulkUploadPOList.isEmpty()) {
			for (GoodsBulkUploadPO goodsBulkPO : goodsBulkUploadPOList) {

				log.debug("= {} GOODS 일괄 등록", goodsBulkPO.toString());

				// 최종적으로 다시 한번 검사
				if (!goodsValidator.validateGoodsBase(goodsBulkPO)) {
					// 오류가 있으면 다음것 진행
					continue;
				}

				try {
					uploadGood(goodsValidator, goodsBulkPO);

					goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_Y);
					goodsBulkPO.setResultMessage(goodsBulkPO.getGoodsId());

				} catch (CustomException e) {
					goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_N);
					goodsBulkPO.setResultMessage(e.getExCode());
				} catch (Exception e) {
					goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_N);
					goodsBulkPO.setResultMessage(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		return goodsBulkUploadPOList;
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public GoodsBulkUploadPO uploadGood(GoodsValidator goodsValidator, GoodsBulkUploadPO goodsBulkPO) throws Exception {
		// Bean 복사를 위한 처리
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
		GoodsBasePO goodsBasePO = null;

		// 상품 기본정보
		goodsBasePO = new GoodsBasePO();
		BeanUtils.copyProperties(goodsBasePO, goodsBulkPO );

		goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_10 );	// 대기
		goodsBasePO.setGoodsCstrtTpCd(AdminConstants.GOODS_CSTRT_TP_ITEM);
		goodsBasePO.setItemMngYn(AdminConstants.COMM_YN_Y);
		goodsBasePO.setGoodsTpCd(AdminConstants.GOODS_TP_10);

		// 상품 개별 SEO 설정
		if(CommonConstants.COMM_YN_Y.equals(goodsBulkPO.getPageYn())) {
			SeoInfoPO seoInfoPO = new SeoInfoPO();
			seoInfoPO.setSeoSvcGbCd(AdminConstants.SEO_SVC_GB_CD_10); // 사이트 구분
			seoInfoPO.setSeoTpCd(AdminConstants.SEO_TP_20); //SEO 유형코드
			seoInfoPO.setPageTtl(goodsBulkPO.getPageTtl()); //페이지 타이틀
			seoInfoPO.setPageAthr(goodsBulkPO.getPageAthr()); //페이지 저자
			seoInfoPO.setPageDscrt(goodsBulkPO.getPageDscrt()); //페이지 설명
			seoInfoPO.setPageKwd(goodsBulkPO.getPageKwd()); //페이지 키워드

			//[등록] 상품 개별 SEO 등록
			seoService.saveSeoInfo(seoInfoPO);
			goodsBasePO.setSeoInfoNo(seoInfoPO.getSeoInfoNo());
		}

		//[등록] 상품 기본 등록
		goodsBasePO = goodsService.insertGoodsBase(goodsBasePO);
		String goodsId = goodsBasePO.getGoodsId();
		goodsBulkPO.setGoodsId(goodsId);

		GoodsPricePO goodsPricePO  = new GoodsPricePO();
		BeanUtils.copyProperties(goodsPricePO, goodsBulkPO );
		
		//[등록] 상품 가격정보 등록
		goodsPricePO.setSaleStrtDtm(DateUtil.getTimestamp());
		goodsPricePO = goodsPriceService.insertGoodsPrice(goodsPricePO, goodsBasePO);

		//[등록] 사이트별 상품 수수료 정보를 등록
		goodsService.insertStGoodsMap(goodsBasePO, goodsPricePO, new ArrayList<StGoodsMapPO>());

		// 단품 옵션 조회
		List<AttributeSO> attributeSOList = getGoodsAttribute(goodsBasePO, goodsBulkPO);
		
		List<ItemSO> itemSOList = getGoodsItem(goodsId, goodsBulkPO);
		//[등록] 단품 등록
		itemService.insertItemWithSkuCd(goodsId, attributeSOList, itemSOList, goodsBasePO);

		// 상품 설명 정보
		List<GoodsDescPO> goodsDescPOList = new ArrayList<GoodsDescPO>();
		
		// 상품 설명 PC
		GoodsDescPO goodsDescPcPO = new GoodsDescPO();
		goodsDescPcPO.setSvcGbCd(AdminConstants.WEB_MOBILE_GB_10);
		goodsDescPcPO.setContent(goodsBulkPO.getContentPc());
		goodsDescPOList.add(goodsDescPcPO);
		
		// 상품 설명 MOBILE
		if(StringUtil.isNotEmpty(goodsBulkPO.getContentMobile())) {
			GoodsDescPO goodsDescMobilePO = new GoodsDescPO();
			goodsDescMobilePO.setSvcGbCd(AdminConstants.WEB_MOBILE_GB_20);
			goodsDescMobilePO.setContent(goodsBulkPO.getContentMobile());
			goodsDescPOList.add(goodsDescMobilePO);
		}

		//[등록] 상품 설명 정보 등록
		goodsDescService.insertGoodsDesc(goodsId, goodsDescPOList);

		//[등록] 상품 이미지 처리.
		String rprsImg = uploadGoodsImage(goodsId, goodsBulkPO);
		
		// 상품 고시 정보
		NotifyItemSO notifyItemSO = new NotifyItemSO();
		notifyItemSO.setNtfId(goodsBulkPO.getNtfId());
		
		List<NotifyItemVO> notifyItemVOList = goodsService.listNotifyItem(notifyItemSO);
		//상품 고시정보  default값
		//String desc = message.getMessage("column.goods.ntf.desc" );
	
		notifyItemVOList.get(0).setItemVal(goodsBulkPO.getItemVal1());
		notifyItemVOList.get(1).setItemVal(goodsBulkPO.getItemVal2());
		notifyItemVOList.get(2).setItemVal(goodsBulkPO.getItemVal3());
		notifyItemVOList.get(3).setItemVal(goodsBulkPO.getItemVal4());
		notifyItemVOList.get(4).setItemVal(goodsBulkPO.getItemVal5());
		
		
		List<GoodsNotifyPO> goodsNotifyPOList = new ArrayList();
		for(NotifyItemVO notifyItemVO : notifyItemVOList) { 	
			GoodsNotifyPO goodsNotifyPO = new GoodsNotifyPO();
			BeanUtils.copyProperties(goodsNotifyPO, notifyItemVO );
			goodsNotifyPOList.add(goodsNotifyPO);
		}
	
		
		
		//[등록] 상품 고시 정보 등록
		goodsNotifyService.insertGoodsNotify(goodsId, goodsNotifyPOList);
		
		// 전시 카테고리 정보 세팅
		List<DisplayGoodsPO> displayGoodsPOList= new ArrayList<>();
		DisplayGoodsPO displayGoodsPO = new DisplayGoodsPO();
		displayGoodsPO.setGoodsId(goodsId);
		displayGoodsPO.setDispClsfNo(goodsBulkPO.getCateCdS());
		displayGoodsPO.setDlgtDispYn(CommonConstants.COMM_YN_Y);
		displayGoodsPOList.add(displayGoodsPO);
		
		//[등록] 전시 카테고리 정보 등록
		displayService.insertDisplayGoods(goodsId, displayGoodsPOList);

		// 상품 아이콘
		if(StringUtils.isNotEmpty(goodsBulkPO.getIcons())) {

			List<CodeDetailVO> limitedIconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_Y, null, null, null, null) ;

			List<GoodsIconPO> goodsIconList = new ArrayList<>();
			String[] icons = goodsBulkPO.getIcons().split(",");
			for(String icon : icons) {
				GoodsIconPO goodsIconPO = new GoodsIconPO();
				goodsIconPO.setGoodsIconCd(icon);
				long limitCnt = limitedIconCodeList.stream().filter(p -> StringUtils.equals(icon, p.getDtlCd())).count();
				if(limitCnt > 0) {
					goodsIconPO.setStrtDtm((goodsBulkPO.getIconStrtDtm() == null) ? DateUtil.getTimestampToString(goodsBulkPO.getSaleStrtDtm(), "yyyy-MM-dd HH:mm:ss") : goodsBulkPO.getIconStrtDtm() + " 00:00:00");
					goodsIconPO.setEndDtm((goodsBulkPO.getIconEndDtm() == null) ? "9999-12-31 23:59:59" : goodsBulkPO.getIconEndDtm() + " 23:59:59");
				}
				goodsIconList.add(goodsIconPO);
			}
			if(goodsIconList.size() > 0) {
				//[등록] 상품 아이콘 등록
				goodsIconService.insertGoodsIcon(goodsId, goodsIconList);
			}
		}

		// 태그 세팅
		if(StringUtils.isNotEmpty(goodsBulkPO.getTagsNm())) {

			String[] tagsNms = goodsBulkPO.getTagsNm().split(",");
			String[] tagsNos = new String[tagsNms.length];

			int i = 0;
			for(String tagNm : tagsNms) {
				TagBaseSO so = new TagBaseSO();
				so.setTagNm(tagNm);
				TagBaseVO tagBaseVO = tagDao.getTagInfo(so);

				if(tagBaseVO != null) {
					tagsNos[i] = tagBaseVO.getTagNo();
				} else {
					//생성
					TagBasePO tagBasePO = new TagBasePO();
					tagBasePO.setTagNm(tagNm);
					tagBasePO.setSrcCd(AdminConstants.TAG_SRC_M);
					tagBasePO.setStatCd(AdminConstants.COMM_YN_Y);
					tagDao.insertTagBase(tagBasePO);
					String tagNo = tagBasePO.getTagNo();
					tagsNos[i] = tagNo;
				}
				i ++;
			}

			// 상품 태그 매핑 등록
			List<GoodsTagMapPO> GoodsTagMapPOList = new ArrayList();
			for(String tagNo : tagsNos) {
				GoodsTagMapPO goodsTagMapPO = new GoodsTagMapPO();
				goodsTagMapPO.setTagNo(tagNo);
				GoodsTagMapPOList.add(goodsTagMapPO);
			}
			if(GoodsTagMapPOList.size() > 0) {
				//[등록] 태그 등록
				goodsTagMapService.insertGoodsTagMap(goodsId, GoodsTagMapPOList);
			}
		}

		GoodsNaverEpInfoPO goodsNaverEpInfoPO = new GoodsNaverEpInfoPO();

		// 네이버쇼핑 노출여부
		if(CommonConstants.COMM_YN_Y.equals(goodsBulkPO.getSndYn())) {
			goodsNaverEpInfoPO.setSndYn(goodsBulkPO.getSndYn());
			goodsNaverEpInfoPO.setSaleTpCd(goodsBulkPO.getSaleTpCd());
			goodsNaverEpInfoPO.setGoodsSrcCd(goodsBulkPO.getGoodsSrcCd());
			goodsNaverEpInfoPO.setSaleTpCd(goodsBulkPO.getSaleTpCd());
			goodsNaverEpInfoPO.setStpUseAgeCd(goodsBulkPO.getStpUseAgeCd());
			goodsNaverEpInfoPO.setStpUseGdCd(goodsBulkPO.getStpUseGdCd());
			goodsNaverEpInfoPO.setSrchTag(goodsBulkPO.getSrchTag());
			goodsNaverEpInfoPO.setNaverCtgId(goodsBulkPO.getNaverCtgId());
			goodsNaverEpInfoPO.setPrcCmprPageId(goodsBulkPO.getPrcCmprPageId());

		} else {
			goodsNaverEpInfoPO.setSndYn(CommonConstants.COMM_YN_N);
		}

		//[등록] 네이버 쇼핑 정보 등록
		goodsNaverEpInfoService.insertGoodsNaverEpInfo(goodsNaverEpInfoPO, goodsId);

		String resultMsg = "";
		
		// CIS
		if(StringUtils.equals(goodsBasePO.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM)) {
			try {
				SkuInfoSO skuInfoSO = new SkuInfoSO();
				skuInfoSO.setGoodsId(goodsId);
				skuInfoSO.setBatchYn(CommonConstants.COMM_YN_N);
				skuInfoSO.setGoodsCstrtTpCd(goodsBasePO.getGoodsCstrtTpCd());
				skuInfoSO.setSendType("insert");
//				List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);
				
				// CIS전송용 vo (select 시 트랜젝션 문제로 조회 되지 않아 수정)
				GoodsSO gso = new GoodsSO();
				gso.setNtfId(goodsBulkPO.getNtfId());
				gso.setTaxGbNm(goodsBulkPO.getTaxGbNm());
				gso.setDlvrcPlcNo(goodsBulkPO.getDlvrcPlcNo());
				gso.setCompNo((int) (long)goodsBulkPO.getCompNo());
				SkuInfoVO cisInfo = cisGoodsService.getInfoForBulkCisSend(gso);
				SkuInfoVO cisSivo = new SkuInfoVO();
				cisSivo.setSkuCd(goodsId);
				cisSivo.setPrdtCd(goodsId);
				cisSivo.setSkuNm(goodsBulkPO.getGoodsNm());
				cisSivo.setStatCd(CommonConstants.GOODS_STAT_10);
				cisSivo.setCompCd(Long.toString(goodsBulkPO.getCompNo()));
				cisSivo.setCateCdL(Long.toString(goodsBulkPO.getCateCdL()));
				cisSivo.setCateNmL(goodsBulkPO.getCateNmL());
				cisSivo.setCateCdM(Long.toString(goodsBulkPO.getCateCdM()));
				cisSivo.setCateNmM(goodsBulkPO.getCateNmM());
				cisSivo.setCateCdS(Long.toString(goodsBulkPO.getCateCdS()));
				cisSivo.setCateNmS(goodsBulkPO.getCateNmS());
				cisSivo.setCateCdD("");
				cisSivo.setCateNmD("");
				cisSivo.setExpDdCtrYn(goodsBulkPO.getExpMngYn());
				cisSivo.setExpDd(goodsBulkPO.getExpMonth());
				cisSivo.setUnitNm("EA");
				cisSivo.setSpcfNm("");
				cisSivo.setPrdtNm(goodsBulkPO.getGoodsNm());
				cisSivo.setPrice((int) (long)goodsBulkPO.getSaleAmt());
				cisSivo.setConsumerPrice((int) (long)goodsBulkPO.getOrgSaleAmt());
				cisSivo.setSupplyPrice((int) (long)goodsBulkPO.getSplAmt());
				if(goodsBulkPO.getPhsCompNo() == null) {
					cisSivo.setVndrCd(cisInfo.getVndrCd());
				}
				cisSivo.setMnftNm(goodsBulkPO.getMmft());
				cisSivo.setOrgnNm(goodsBulkPO.getCtrOrgNm());
				cisSivo.setImptNm(goodsBulkPO.getImporter());
				cisSivo.setStrdCd(goodsBulkPO.getPrdStdCd());
				cisSivo.setModlNm(goodsBulkPO.getMdlNm());
				cisSivo.setBrndNo((int) (long)goodsBulkPO.getBndNo());
				cisSivo.setGoodsPrcNo(goodsPricePO.getGoodsPrcNo());
				cisSivo.setPetTpNm(goodsBulkPO.getPetGbNm());
				if(CommonConstants.COMM_YN_Y.equals(goodsBulkPO.getFreeDlvrYn())){
					cisSivo.setDlvChrgTpCd("001");
				}
				cisSivo.setImgSrc(rprsImg);
				cisSivo.setDtlTxt(goodsBulkPO.getContentPc());
				cisSivo.setClltSendYn(goodsBulkPO.getShoplinkerSndYn());
				cisSivo.setTwcSendYn(goodsBulkPO.getIgdtInfoLnkYn());
				cisSivo.setGoodsCstrtTpCd(AdminConstants.GOODS_CSTRT_TP_ITEM);
				ArrayList<Ntfc> ntfcList = new ArrayList<>();
				Ntfc ntfc1 = new Ntfc();
				ntfc1.setNtfcNo("3501");
				ntfc1.setNtfcTxt(goodsBulkPO.getItemVal1());
				ntfcList.add(ntfc1);
				Ntfc ntfc2 = new Ntfc();
				ntfc2.setNtfcNo("3502");
				ntfc2.setNtfcTxt(goodsBulkPO.getItemVal2());
				ntfcList.add(ntfc2);
				Ntfc ntfc3 = new Ntfc();
				ntfc3.setNtfcNo("3503");
				ntfc3.setNtfcTxt(goodsBulkPO.getItemVal3());
				ntfcList.add(ntfc3);
				Ntfc ntfc4 = new Ntfc();
				ntfc4.setNtfcNo("3504");
				ntfc4.setNtfcTxt(goodsBulkPO.getItemVal4());
				ntfcList.add(ntfc4);
				Ntfc ntfc5 = new Ntfc();
				ntfc5.setNtfcNo("3505");
				ntfc5.setNtfcTxt(goodsBulkPO.getItemVal5());
				ntfcList.add(ntfc5);
				cisSivo.setNtfcList(ntfcList);
				cisSivo.setDlvChrgTpCd(cisInfo.getDlvChrgTpCd());
				cisSivo.setDlvChrg(cisInfo.getDlvChrg());
				cisSivo.setTaxTpCd(cisInfo.getTaxTpCd());
				cisSivo.setNtfcCd(cisInfo.getNtfcCd());
				List<SkuInfoVO> list = new ArrayList<SkuInfoVO>();
				list.add(cisSivo);
				HashMap result = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), list);
				HashMap resultMsgMap = (HashMap) result.get(goodsId);
	
				//CIS 응답코드
				String resCd = (String) resultMsgMap.keySet().toArray()[0];
	
				if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
					resultMsg = (String) resultMsgMap.get(resCd);
					throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
				}else {
					Integer cisNo = (Integer) resultMsgMap.get(resCd);
					goodsBaseDao.updateGoodsCisNo(cisNo, goodsId);
				}
	
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
			}
		}
		return goodsBulkPO;
	}

	/**
	 * 아이템 so
	 * @param goodsId
	 * @param bulkUploadPO
	 * @return
	 */
	public List<ItemSO> getGoodsItem(String goodsId, GoodsBulkUploadPO bulkUploadPO) {
		List<ItemSO> itemSOList = new ArrayList<>();
		ItemSO itemSO = new ItemSO();
		itemSO.setGoodsId(goodsId);
		itemSO.setItemNm(bulkUploadPO.getGoodsNm());
		if(bulkUploadPO.getWebStkQty() != null) {
			itemSO.setWebStkQty(bulkUploadPO.getWebStkQty());
		} else {
			itemSO.setWebStkQty(0L);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr1No())) {
			itemSO.setAttr1No(bulkUploadPO.getAttr1No());
			itemSO.setAttr1Nm(bulkUploadPO.getAttr1Nm());
			//itemSO.setAttr1ValNo(Long.parseLong(bulkUploadPO.getAttr1ValNo()));
			itemSO.setAttr1Val(bulkUploadPO.getAttr1Val());
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr2No())) {
			itemSO.setAttr2No(bulkUploadPO.getAttr2No());
			itemSO.setAttr2Nm(bulkUploadPO.getAttr2Nm());
			//itemSO.setAttr2ValNo(Long.parseLong(bulkUploadPO.getAttr2ValNo()));
			itemSO.setAttr2Val(bulkUploadPO.getAttr2Val());
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr3No())) {
			itemSO.setAttr3No(bulkUploadPO.getAttr3No());
			itemSO.setAttr3Nm(bulkUploadPO.getAttr3Nm());
			//itemSO.setAttr3ValNo(Long.parseLong(bulkUploadPO.getAttr3ValNo()));
			itemSO.setAttr3Val(bulkUploadPO.getAttr3Val());
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr4No())) {
			itemSO.setAttr4No(bulkUploadPO.getAttr4No());
			itemSO.setAttr4Nm(bulkUploadPO.getAttr4Nm());
			//itemSO.setAttr4ValNo(Long.parseLong(bulkUploadPO.getAttr4ValNo()));
			itemSO.setAttr4Val(bulkUploadPO.getAttr4Val());
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr5No())) {
			itemSO.setAttr5No(bulkUploadPO.getAttr5No());
			itemSO.setAttr5Nm(bulkUploadPO.getAttr5Nm());
			//itemSO.setAttr5ValNo(Long.parseLong(bulkUploadPO.getAttr5ValNo()));
			itemSO.setAttr5Val(bulkUploadPO.getAttr5Val());
		}

		itemSOList.add(itemSO);

		return itemSOList;
	}

	/**
	 * 단품 옵션 만들기
	 * @param goodsbasePO
	 * @param bulkUploadPO
	 * @return
	 */
	public List<AttributeSO> getGoodsAttribute(GoodsBasePO goodsbasePO, GoodsBulkUploadPO bulkUploadPO) {
		List<AttributeSO> attributeSOList = new ArrayList();

		

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr1No())) {
			AttributeSO attributeSO = new AttributeSO();
			attributeSO.setAttrNo(bulkUploadPO.getAttr1No());
			attributeSO.setAttrNm(bulkUploadPO.getAttr1Nm());
			attributeSO.setAttrValNo(bulkUploadPO.getAttr1ValNo());
			attributeSO.setAttrVal(bulkUploadPO.getAttr1Val());
			attributeSO.setUseYn(CommonConstants.COMM_YN_Y);
			attributeSOList.add(attributeSO);
			
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonVar = new JSONObject();
			jsonVar.put("attrNo",bulkUploadPO.getAttr1No());
			jsonVar.put("attrNm",bulkUploadPO.getAttr1Nm());
			jsonVar.put("attrValNo",bulkUploadPO.getAttr1ValNo());
			jsonVar.put("attrVal",bulkUploadPO.getAttr1Val());
			jsonVar.put("useYn",CommonConstants.COMM_YN_Y);
			jsonArray.add(jsonVar);

			String attrValJson = jsonArray.toString();
			attributeSO.setAttrValJson(attrValJson);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr2No())) {
			AttributeSO attributeSO = new AttributeSO();
			attributeSO.setAttrNo(bulkUploadPO.getAttr2No());
			attributeSO.setAttrNm(bulkUploadPO.getAttr2Nm());
			attributeSO.setAttrVal(bulkUploadPO.getAttr2Val());
			attributeSO.setUseYn(CommonConstants.COMM_YN_Y);
			attributeSOList.add(attributeSO);
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonVar = new JSONObject();
			jsonVar.put("attrNo",bulkUploadPO.getAttr2No());
			jsonVar.put("attrNm",bulkUploadPO.getAttr2Nm());
			jsonVar.put("attrVal",bulkUploadPO.getAttr2Val());
			jsonVar.put("useYn",CommonConstants.COMM_YN_Y);
			jsonArray.add(jsonVar);

			String attrValJson = jsonArray.toString();
			attributeSO.setAttrValJson(attrValJson);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr3No())) {
			AttributeSO attributeSO = new AttributeSO();
			attributeSO.setAttrNo(bulkUploadPO.getAttr3No());
			attributeSO.setAttrNm(bulkUploadPO.getAttr3Nm());
			attributeSO.setAttrVal(bulkUploadPO.getAttr3Val());
			attributeSO.setUseYn(CommonConstants.COMM_YN_Y);
			attributeSOList.add(attributeSO);
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonVar = new JSONObject();
			jsonVar.put("attrNo",bulkUploadPO.getAttr3No());
			jsonVar.put("attrNm",bulkUploadPO.getAttr3Nm());
			jsonVar.put("attrVal",bulkUploadPO.getAttr3Val());
			jsonVar.put("useYn",CommonConstants.COMM_YN_Y);
			jsonArray.add(jsonVar);

			String attrValJson = jsonArray.toString();
			attributeSO.setAttrValJson(attrValJson);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr4No())) {
			AttributeSO attributeSO = new AttributeSO();
			attributeSO.setAttrNo(bulkUploadPO.getAttr4No());
			attributeSO.setAttrNm(bulkUploadPO.getAttr4Nm());
			attributeSO.setAttrVal(bulkUploadPO.getAttr4Val());
			attributeSO.setUseYn(CommonConstants.COMM_YN_Y);
			attributeSOList.add(attributeSO);
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonVar = new JSONObject();
			jsonVar.put("attrNo",bulkUploadPO.getAttr4No());
			jsonVar.put("attrNm",bulkUploadPO.getAttr4Nm());
			jsonVar.put("attrVal",bulkUploadPO.getAttr4Val());
			jsonVar.put("useYn",CommonConstants.COMM_YN_Y);
			jsonArray.add(jsonVar);

			String attrValJson = jsonArray.toString();
			attributeSO.setAttrValJson(attrValJson);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getAttr5No())) {
			AttributeSO attributeSO = new AttributeSO();
			attributeSO.setAttrNo(bulkUploadPO.getAttr5No());
			attributeSO.setAttrNm(bulkUploadPO.getAttr5Nm());
			attributeSO.setAttrVal(bulkUploadPO.getAttr5Val());
			attributeSO.setUseYn(CommonConstants.COMM_YN_Y);
			attributeSOList.add(attributeSO);
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonVar = new JSONObject();
			jsonVar.put("attrNo",bulkUploadPO.getAttr5No());
			jsonVar.put("attrNm",bulkUploadPO.getAttr5Nm());
			jsonVar.put("attrVal",bulkUploadPO.getAttr5Val());
			jsonVar.put("useYn",CommonConstants.COMM_YN_Y);
			jsonArray.add(jsonVar);

			String attrValJson = jsonArray.toString();
			attributeSO.setAttrValJson(attrValJson);
		}

		return attributeSOList;
	}

	/**
	 * 이미지 등록
	 * @param goodsId
	 * @param bulkUploadPO
	 */
	public String uploadGoodsImage(String goodsId, GoodsBulkUploadPO bulkUploadPO) {
		String rprsImg = "";
		if(StringUtil.isNotBlank(bulkUploadPO.getImg1Url())) {
			rprsImg = getGoodsImageSeq(goodsId, bulkUploadPO.getImg1Url(), 1);
		}else {
			rprsImg = getGoodsImageSeq(goodsId, "https://aboutpet.co.kr/_images/common/img_default_thumbnail_2@2x.png", 1);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg2Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg2Url(), 2);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg3Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg3Url(), 3);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg4Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg4Url(), 4);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg5Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg5Url(), 5);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg6Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg6Url(), 6);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg7Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg7Url(), 7);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg8Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg8Url(), 8);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg9Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg9Url(), 9);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getImg10Url())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getImg10Url(), 10);
		}

		if(StringUtil.isNotEmpty(bulkUploadPO.getBannerImgUrl())) {
			getGoodsImageSeq(goodsId, bulkUploadPO.getBannerImgUrl(), 11);
		}
		
		return rprsImg;
	}

	/**
	 * 이미지 등록
	 * @param imageDownUtil
	 * @param ftpImgUtil
	 * @param goodsId
	 * @param imgUrl
	 * @param imgSeq
	 */
	public String getGoodsImageSeq(String goodsId, String imgUrl, int imgSeq) {
		String rprsImg ="";
		GoodsImgPrcsListPO goodsImgPrcsListPO = new GoodsImgPrcsListPO();
		goodsImgPrcsListPO.setGoodsId(goodsId);
		goodsImgPrcsListPO.setPrcsSeq(imgSeq);
		goodsImgPrcsListPO.setImgPrcsYn(CommonConstants.COMM_YN_Y);

		try {
			GoodsImgPO po = new GoodsImgPO();
			po.setGoodsId(goodsId);
			po.setDlgtYn(CommonConstants.COMM_YN_N);
			po.setImgTpCd(CommonConstants.IMG_TP_10);
			po.setImgSeq(imgSeq);
			
			//대표 이미지 세팅
			if(imgSeq == 1) {
				po.setDlgtYn(CommonConstants.COMM_YN_Y);
			}

			//배너 이미지
			if(imgSeq == 11) {
				po.setImgTpCd(CommonConstants.IMG_TP_30);
			}

			if(StringUtils.startsWithIgnoreCase(imgUrl, "http")) {
				ImageDownUtil imageDownUtil = new ImageDownUtil(bizConfig);
				String returnImgUrl = imageDownUtil.fetchFile(imgUrl);
				imgUrl = returnImgUrl.replace("\\", "/");
			}
			
			int result = 0;
			if(StringUtil.isNotBlank(imgUrl) ) {
				FtpImgUtil ftpImgUtil =  new FtpImgUtil();
				String filePath = ftpImgUtil.uploadFilePath(imgUrl, AdminConstants.GOODS_IMAGE_PATH + FileUtil.SEPARATOR + po.getGoodsId());
				ftpImgUtil.upload(imgUrl, filePath, false);
				po.setImgPath(filePath);
				
				// 이미지 등록
				result = goodsService.insertGoodsImg(po );
			}

			if(result > 0) {
				// 이력 등록
				GoodsImgChgHistPO goodsImgChgHistPO = new GoodsImgChgHistPO ();
				goodsImgChgHistPO.setGoodsId(po.getGoodsId() );
				goodsImgChgHistPO.setImgSeq(po.getImgSeq());
				goodsImgChgHistPO.setImgPath(po.getImgPath());
				goodsImgChgHistPO.setRvsImgPath(po.getRvsImgPath());
				goodsImgChgHistPO.setDlgtYn(po.getDlgtYn());
				goodsImgChgHistPO.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
				goodsImgChgHistPO.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);

				goodsService.insertGoodsImgChgHist(goodsImgChgHistPO );

				updateGoodsImgPrcsList(goodsImgPrcsListPO);
				
				if(imgSeq == 1) {
					rprsImg = po.getImgPath();
				}
			}
		} catch (Exception e) {
			goodsImgPrcsListPO.setImgPrcsYn(CommonConstants.COMM_YN_N);
			goodsImgPrcsListPO.setMemo(e.toString() + ": " + e.getMessage());
			updateGoodsImgPrcsList(goodsImgPrcsListPO);
		}
		return rprsImg;
	}

	@Override
	public List<GoodsBulkUploadPO> validateBulkUpladGoods (List<GoodsBulkUploadPO> goodsBulkUploadPOList ) {
		GoodsValidator goodsValidator = new GoodsValidator();
		for(GoodsBulkUploadPO po : goodsBulkUploadPOList ) {
			goodsValidator.validateGoodsBase(po);
		}
		return goodsBulkUploadPOList;
	}

	@Override
	public List<GoodsImgPrcsListVO> getGoodsImgPrcsList() {
		return goodsBulkUploadDao.getGoodsImgPrcsList();
	}

	@Override
	public int updateGoodsImgPrcsList(GoodsImgPrcsListPO po) {
		return goodsBulkUploadDao.updateGoodsImgPrcsList(po);
	}
}
