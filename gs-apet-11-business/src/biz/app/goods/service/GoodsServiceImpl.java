package biz.app.goods.service;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.dao.CompanyDao;
import biz.app.company.model.CompanySO;
import biz.app.contents.dao.ApetContentsGoodsMapDao;
import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.ApetContentsGoodsMapVO;
import biz.app.delivery.dao.DeliveryChargePolicyDao;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayHotDealVO;
import biz.app.display.service.DisplayService;
import biz.app.goods.dao.FiltAttrMapDao;
import biz.app.goods.dao.GoodsAttributeDao;
import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.dao.GoodsCommentDao;
import biz.app.goods.dao.GoodsCstrtDao;
import biz.app.goods.dao.GoodsDao;
import biz.app.goods.dao.GoodsDescDao;
import biz.app.goods.dao.GoodsFiltGrpDao;
import biz.app.goods.dao.GoodsIconDao;
import biz.app.goods.dao.GoodsImgDao;
import biz.app.goods.dao.GoodsInquiryDao;
import biz.app.goods.dao.GoodsNotifyDao;
import biz.app.goods.dao.GoodsPriceDao;
import biz.app.goods.dao.GoodsSkuDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.DayGoodsPplrtTotalSO;
import biz.app.goods.model.FiltAttrMapPO;
import biz.app.goods.model.FiltAttrMapVO;
import biz.app.goods.model.GoodsAttributeSO;
import biz.app.goods.model.GoodsAttributeVO;
import biz.app.goods.model.GoodsBaseHistPO;
import biz.app.goods.model.GoodsBaseHistSO;
import biz.app.goods.model.GoodsBaseHistVO;
import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCautionPO;
import biz.app.goods.model.GoodsCautionVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCstrtHistPO;
import biz.app.goods.model.GoodsCstrtInfoPO;
import biz.app.goods.model.GoodsCstrtInfoSO;
import biz.app.goods.model.GoodsCstrtInfoVO;
import biz.app.goods.model.GoodsCstrtPakPO;
import biz.app.goods.model.GoodsCstrtSetPO;
import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescVO;
import biz.app.goods.model.GoodsIconPO;
import biz.app.goods.model.GoodsIconVO;
import biz.app.goods.model.GoodsImgChgHistPO;
import biz.app.goods.model.GoodsImgPO;
import biz.app.goods.model.GoodsImgSO;
import biz.app.goods.model.GoodsImgVO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.goods.model.GoodsNaverEpInfoPO;
import biz.app.goods.model.GoodsNaverEpInfoVO;
import biz.app.goods.model.GoodsNotifyPO;
import biz.app.goods.model.GoodsNotifyVO;
import biz.app.goods.model.GoodsOptGrpPO;
import biz.app.goods.model.GoodsPO;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceSO;
import biz.app.goods.model.GoodsPriceTotalVO;
import biz.app.goods.model.GoodsPriceVO;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.model.GoodsTagMapPO;
import biz.app.goods.model.GoodsTagMapVO;
import biz.app.goods.model.GoodsTotalCountVO;
import biz.app.goods.model.ItemAttributeValueVO;
import biz.app.goods.model.ItemPO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.model.NotifyInfoVO;
import biz.app.goods.model.NotifyItemSO;
import biz.app.goods.model.NotifyItemVO;
import biz.app.goods.model.SkuInfoSO;
import biz.app.goods.model.SkuInfoVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.goods.model.StGoodsMapSO;
import biz.app.goods.model.StGoodsMapVO;
import biz.app.goods.model.interfaces.WmsGoodsListSO;
import biz.app.goods.model.interfaces.WmsGoodsListVO;
import biz.app.member.dao.MemberDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberGradeVO;
import biz.app.petlog.dao.PetLogDao;
import biz.app.petlog.model.PetLogBasePO;
import biz.app.petlog.model.PetLogBaseSO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogGoodsVO;
import biz.app.petlog.service.PetLogService;
import biz.app.promotion.dao.PromotionDao;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import biz.interfaces.cis.service.CisGoodsService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.model.PurgeParam;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.ImagePathUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.common.util.image.ImageHandler;
import framework.common.util.image.ImageInfoData;
import framework.common.util.image.ImageType;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsServiceImpl.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: valueFactory
* - 설명		:
* </pre>
*/
@Slf4j
@Service
@Transactional
public class GoodsServiceImpl implements GoodsService {

	@Autowired private GoodsBaseDao goodsBaseDao;
	@Autowired private GoodsSkuDao goodsSkuDao;

	@Autowired
	private GoodsDao goodsDao;

	@Autowired
	private ItemDao itemDao;

	@Autowired
	private DisplayDao displayDao;

	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private GoodsNotifyDao goodsNotifyDao;

	@Autowired
	private GoodsDescDao goodsDescDao;

	@Autowired
	private GoodsCstrtDao goodsCstrtDao;

	@Autowired
	private GoodsPriceDao goodsPriceDao;

	@Autowired
	private GoodsImgDao goodsImgDao;

	@Autowired
	private DeliveryChargePolicyDao deliveryChargePolicyDao;

	@Autowired
	private CacheService cacheService;

	@Autowired
	private PromotionDao promotionDao;

	@Autowired private GoodsAttributeDao goodsAttributeDao;

	@Autowired
	private Properties bizConfig;

	@Autowired private Properties webConfig;

	@Autowired private ItemService itemService;
	
	@Autowired private GoodsTagMapService goodsTagMapService;
	
	@Autowired private FiltAttrMapService filtAttrMapService;
	
	@Autowired private GoodsIconService goodsIconService;
	
	@Autowired private GoodsDescService goodsDescService;
	
	@Autowired private GoodsCautionService goodsCautionService;
	
	@Autowired private GoodsNotifyService goodsNotifyService;
	
	@Autowired private DisplayService displayService;
	
	@Autowired private GoodsPriceService goodsPriceService;
	
	@Autowired private GoodsCstrtSetService goodsCstrtSetService;
	
	@Autowired private GoodsCstrtPakService goodsCstrtPakService;
	
	@Autowired private GoodsOptGrpService goodsOptGrpService;
	
	@Autowired private GoodsIconDao goodsIconDao;

	@Autowired private GoodsCommentDao goodsCommentDao;

	@Autowired private GoodsInquiryDao goodsInquiryDao;

	@Autowired private FiltAttrMapDao filtAttrMapDao;
	
	@Autowired private ApetContentsGoodsMapDao apetContentsGoodsMapDao;

	@Autowired private GoodsNaverEpInfoService goodsNaverEpInfoService;

	@Autowired
	private SearchApiUtil searchApiUtil;
	
	@Autowired
	private NhnObjectStorageUtil nhnObjectStorageUtil;

	@Autowired
	private PetLogService petLogService;

	@Autowired
	private MemberDao memberDao;
	
	@Autowired private CisGoodsService cisGoodsService;
	
	@Autowired private GoodsCommentService goodsCommentService;
	
	@Autowired
	private PetLogDao petLogDao;
	
	@Autowired
	private GoodsFiltGrpDao goodsFiltGrpDao;
	
	/*
	 * 상품의 속성 및 속성값 목록 조회
	 * @see biz.app.goods.service.GoodsService#listGoodsAttribute(java.lang.String, java.lang.Boolean)
	 */
	@Override
	public List<GoodsAttributeVO> listGoodsAttribute(String goodsId, Boolean validItem) {
		GoodsAttributeSO gaso = new GoodsAttributeSO();
		gaso.setGoodsId(goodsId);
		gaso.setValidItem(validItem);
		return this.goodsAttributeDao.listGoodsAttribute(gaso);
	}

	/*
	 * 상품상세 조회
	 * @see biz.app.goods.service.GoodsService#getGoodsBase(java.lang.String)
	 */
	@Override
	public GoodsBaseVO getGoodsBase(String goodsId) {
		GoodsBaseSO gbso = new GoodsBaseSO();
		gbso.setGoodsId(goodsId);
		return this.goodsBaseDao.getGoodsBase(gbso);
	}

	@Override
	public GoodsTotalCountVO getGoodsTotalCount(String goodsId) {
		return goodsBaseDao.getGoodsTotalCount(goodsId);
	}

	/* 상품 상세 텝 메뉴 카운트
	 * @see biz.app.goods.service.GoodsService#getGoodsTotalCount(biz.app.goods.model.GoodsBaseVO)
	 */
	@Override
	public GoodsTotalCountVO getGoodsTotalCount(GoodsBaseVO vo) {
		GoodsTotalCountVO cntVO = goodsBaseDao.getGoodsTotalCount(vo.getGoodsId());
		
		GoodsCommentSO commentSO = new GoodsCommentSO();
		commentSO.setGoodsId(vo.getGoodsId());
		commentSO.setGoodsCstrtTpCd(vo.getGoodsCstrtGbCd());
		cntVO.setGoodsCommentTotal((long)goodsCommentDao.pageGoodsCommentCount(commentSO));
		GoodsInquirySO qnaSO = new GoodsInquirySO();
		qnaSO.setGoodsId(vo.getGoodsId());
		cntVO.setGoodsQnaTotal((long)goodsInquiryDao.getGoodsInquiryListCount(qnaSO));
		return cntVO;
	}
	
	/*
	 * 상품상세 조회
	 * @see biz.app.goods.service.GoodsService#goodsDlvrcPlcNoChgBatch(GoodsBaseSO)
	 */
	@Override
	public int updateGoodsDlvrcPlcNoBatch(GoodsBaseSO so){
		GoodsBasePO goodsBase = new GoodsBasePO();
		goodsBase.setCompNo(so.getCompNo());
		goodsBase.setDlvrcPlcNo(so.getDlvrcPlcNo());

		return goodsDao.updateGoodsDlvrcPlcNoBatch(goodsBase);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/*
	 * 배송비 정책 조회
	 * @see biz.app.goods.service.GoodsService#getGoodsDeliveryChargePolicy(java.lang.String)
	 */
	@Override
	public DeliveryChargePolicyVO getGoodsDeliveryChargePolicy(Long dlvrcPlcNo, ItemVO item){
		//배송비 정책 정보 조회
		DeliveryChargePolicySO dcpso = new DeliveryChargePolicySO();
		dcpso.setDlvrcPlcNo(dlvrcPlcNo);
		DeliveryChargePolicyVO deliveryChargePolicy = this.deliveryChargePolicyDao.getDeliveryChargePolicy(dcpso);
		//배송방법 코드명 조회 및 설정
		deliveryChargePolicy.setCompDlvrMtdNm(cacheService.getCodeName(CommonConstants.COMP_DLVR_MTD, deliveryChargePolicy.getCompDlvrMtdCd()));
		//배송비 안내문구 설정
		String dlvrAmtNm = "";
		if(CommonConstants.DLVRC_STD_10.equals(deliveryChargePolicy.getDlvrcStdCd())){	//배송비 기준코드(DLVRC_STD) = 10:무료배송, 20:배송비 추가
			dlvrAmtNm = cacheService.getCodeName(CommonConstants.DLVRC_STD, deliveryChargePolicy.getDlvrcStdCd());
		}else{
			dlvrAmtNm = cacheService.getCodeName(CommonConstants.DLVRC_PAY_MTD, deliveryChargePolicy.getDlvrcPayMtdCd());	//배송비 결제방법(DLVRC_PAY_MTD) 10:선불, 20:착불
			if(item == null){
				dlvrAmtNm += ", " + cacheService.getCodeName(CommonConstants.DLVRC_CDT, deliveryChargePolicy.getDlvrcCdtCd()) ;	//배송비 조건코드(DLVRC_CDT_CD)
			}else{
				dlvrAmtNm += ", " + cacheService.getCodeName(CommonConstants.DLVRC_CDT, deliveryChargePolicy.getDlvrcCdtCd()) +" "+StringUtil.formatMoney(String.valueOf(item.getDlvrAmt()))+"원";	//배송비 조건코드(DLVRC_CDT_CD)
			}

			if(CommonConstants.DLVRC_CDT_STD_20.equals(deliveryChargePolicy.getDlvrcCdtStdCd())){	//조건부 무료배송(구매가격)
				dlvrAmtNm += ", "+StringUtil.formatMoney(String.valueOf(deliveryChargePolicy.getBuyPrc()))+"원 이상 무료";
			}else if(CommonConstants.DLVRC_CDT_STD_30.equals(deliveryChargePolicy.getDlvrcCdtStdCd())){	//조건부 무료배송(구매수량)
				dlvrAmtNm += ", "+deliveryChargePolicy.getBuyQty()+"개 이상 무료";
			}
		}
		deliveryChargePolicy.setDlvrAmtNm(dlvrAmtNm);

		return deliveryChargePolicy;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: shkim
	* - 설명		: 단품, 조립비, 배송비 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@Override
	public ItemVO getGoodsItem(ItemSO so) {
		List<ItemVO> listItem= itemDao.listChooseItem(so);
		/*
		if(listItem == null || listItem.size() != 1){
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_OPTION);
		}*/
		if(!listItem.isEmpty()){
			return listItem.get(0);
		}else{
			return null;
		}
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: xerowiz@naver.com
	* - 설명		: 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	@Override
	public List<GoodsBaseVO> listGoods(GoodsBaseSO so) {
		if (so.getDispClsfNo() != null) {
			List<Long> dispClsfNoList = new ArrayList<>();
			DisplayCategorySO cateSO = new DisplayCategorySO();
			cateSO.setDispClsfNo(so.getDispClsfNo());
			List<DisplayCategoryVO> cateList = displayDao.listDescendantCategory(cateSO);

			for (DisplayCategoryVO o : cateList) {
				if (o.getDispCtgLvl1() != null && !dispClsfNoList.contains(o.getDispCtgLvl1())) {
					dispClsfNoList.add(o.getDispCtgLvl1());
				}
				if (o.getDispCtgLvl2() != null && !dispClsfNoList.contains(o.getDispCtgLvl2())) {
					dispClsfNoList.add(o.getDispCtgLvl2());
				}
				if (o.getDispCtgLvl3() != null && !dispClsfNoList.contains(o.getDispCtgLvl3())) {
					dispClsfNoList.add(o.getDispCtgLvl3());
				}
			}
			so.setDispClsfNos(dispClsfNoList.toArray(new Long[dispClsfNoList.size()]));
		}

		return goodsDao.listGoods(so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: wyjeong
	* - 설명		: BEST 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	@Override
	public List<GoodsListVO> pageBestGoods(GoodsListSO so) {
		return goodsDao.pageBestGoods(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: shkim
	* - 설명		: 상품상세 상품정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	@Override
	public GoodsBaseVO getGoodsDetailFO(GoodsBaseSO mso) {
		return goodsDao.getGoodsDetailFO(mso);
	}

	/* 상품상세, 리스트에서 flag (쿠폰, 무료배송, 신상품여부등)의 노출여부를 확인
	 * @see biz.app.goods.service.GoodsService#checkDispFlag(biz.app.goods.model.GoodsBaseVO, java.util.List)
	 */
	@Override
	public void checkDispFlag(GoodsBaseVO goods, List<ItemVO> itemList){
		String soldOutYn = (goods.getSoldOutYn()==null || goods.getSoldOutYn().equals("N")) ? CommonConstants.COMM_YN_N: CommonConstants.COMM_YN_Y;	//품절 여부(Y:품절, N:재고보유)
		String newYn = CommonConstants.COMM_YN_N;	//신상품 여부
		//쿠폰 적용여부 확인
		String couponYn = goods.getCpNo() != null ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N;  //쿠폰 적용 여부
		String freebieYn = CommonConstants.COMM_YN_N;	//사은품 여부

		

		//신상품여부 확인(상품판매시작일부터 30일까지)
		if(goods.getSaleStrtDtm() != null){
			Calendar cal = Calendar.getInstance();
			cal.setTime(goods.getSaleStrtDtm());
			cal.add(Calendar.DATE, 30);

			if(cal.compareTo(Calendar.getInstance()) > 0){
				newYn = CommonConstants.COMM_YN_Y;
			}else{
				newYn = CommonConstants.COMM_YN_N;
			}
		}

		//사은품 프로모션 여부 확인
		List<GoodsBaseVO> promotionFreebieList = promotionDao.listGoodsPromotionFreebie(goods.getGoodsId());

		if(promotionFreebieList != null && !promotionFreebieList.isEmpty()){
			freebieYn = CommonConstants.COMM_YN_Y;
		}

		/**
		 * 품절여부 확인
		 * - 상품상세 : 재고관리여부가 Y이고 단품의 재고가 없는 경우 품절
		 * - 리스트    : 상품상태(GOODS_STAT_CD)가 판매중(40)이 아닌 경우 품절
		 */
		if(itemList != null && !itemList.isEmpty()
				&& CommonConstants.COMM_YN_Y.equals(goods.getStkMngYn())){	//상품상세
			for(ItemVO o: itemList){
				if(o.getWebStkQty() <1 ){
					soldOutYn = CommonConstants.COMM_YN_Y;
					break;
				}
			}
			/*else{
				soldOutYn = CommonConstants.COMM_YN_N;
			}*/
		}/* 리스트에서는 상품목록 가져오는쿼리에서 품절체크함
		else{	//리스트에서는 단품고려하지 않음
			if(CommonConstants.GOODS_STAT_40.equals(goods.getGoodsStatCd())){
				soldOutYn = CommonConstants.COMM_YN_N;
			}else{
				soldOutYn = CommonConstants.COMM_YN_Y;
			}
		}
		*/
		//품절인 경우 다른 flag 모두 노출하지 않음
		if(CommonConstants.COMM_YN_Y.equals(soldOutYn)){
			newYn = CommonConstants.COMM_YN_N;
			couponYn = CommonConstants.COMM_YN_N;
			freebieYn = CommonConstants.COMM_YN_N;
			goods.setFreeDlvrYn(CommonConstants.COMM_YN_N);	//무료배송 여부
		}

		goods.setNewYn(newYn);
		goods.setCouponYn(couponYn);
		goods.setFreebieYn(freebieYn);
		if(itemList != null){ // 상세일경우
			goods.setSoldOutYn(soldOutYn);
		}
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public Map<String, Object> getGoodsImg(String goodsId, String imgTpCd) {
		List<GoodsImgVO> realResultList = new ArrayList<>();
		Map<String, Object> rstMap = new HashMap<>();
		GoodsImgSO goodsImgSO = new GoodsImgSO();
		goodsImgSO.setGoodsId(goodsId);
		goodsImgSO.setImgTpCd(imgTpCd);
		List<GoodsImgVO> goodsImgList = goodsImgDao.listGoodsImg(goodsImgSO);
		for(GoodsImgVO temp : goodsImgList){
			if(temp.getGoodsId() != null && (StringUtil.isNotEmpty(temp.getImgPath()))){
				realResultList.add(temp);
			}
		}
		rstMap.put("goodsImgList", realResultList);

		if(!realResultList.isEmpty()){
			for(GoodsImgVO o: realResultList){
					if("Y".equals(o.getDlgtYn())){
						rstMap.put("dlgtImgSeq", o.getImgSeq());
						rstMap.put("dlgtImgPath", o.getImgPath());
						if(o.getRvsImgPath() == null){
							rstMap.put("dlgtRvsImgPath", o.getImgPath());
						}else{
							rstMap.put("dlgtRvsImgPath", o.getRvsImgPath());
						}
					}
			}
		}
		return rstMap;
	}

	@Override
	public List<AttributeVO> getItemList(AttributePO attr){
		List<AttributeVO> goodsAttrList = this.itemDao.listGoodsAttributeFO(attr);	//속성 리스트 조회

		if(goodsAttrList != null && !goodsAttrList.isEmpty()){
			List<AttributeValueVO> goodsAttrValueList = this.itemDao.listGoodsAttributeValueFO(attr);

			for(AttributeVO attribute: goodsAttrList){
				List<AttributeValueVO> tmpAttrValList = new ArrayList<>();	//속성 값 리스트 조회

				for(AttributeValueVO attributeValue: goodsAttrValueList){
					if(attribute.getAttrNo().equals(attributeValue.getAttrNo())){
						tmpAttrValList.add(attributeValue);
					}
				}
				attribute.setAttributeValueList(tmpAttrValList);
			}
		}
		return goodsAttrList;
	}
	/* 옵션상품 속성 조회
	 * @see biz.app.goods.service.GoodsService#getItemList(biz.app.goods.model.AttributeSO)
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<AttributeVO> listGoodsItemsAttr(String goodsId, String useYn, String svcGbCd){
		AttributePO attr = new AttributePO();
		attr.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		attr.setWebMobileGbCd(svcGbCd);
		attr.setGoodsId(goodsId);
		attr.setUseYn(useYn);

		//List<AttributeVO> goodsAttrList = this.itemDao.listGoodsAttributeFO(attr);	//속성 리스트 조회
		List<AttributeVO> goodsAttrList = this.itemDao.listOptionGoodsAttributeFO(attr);	//옵션상품 옵션 리스트 조회

		if(goodsAttrList != null && !goodsAttrList.isEmpty()){
			for(AttributeVO attribute: goodsAttrList){
				attr.setAttrNo(attribute.getAttrNo());
				if(attribute.getAttrNo() != null){
					//List<AttributeValueVO> goodsAttrValueList = this.itemDao.listGoodsAttributeValueFO(attr);
					List<AttributeValueVO> goodsAttrValueList = this.itemDao.listOptionGoodsAttributeValueFO(attr);
					attribute.setAttributeValueList(goodsAttrValueList);
				}
			}
		}
		return goodsAttrList;
	}
	/* 옵션선택 속성 조회
	 * @see biz.app.goods.service.GoodsService#listGoodsItemsAttrSel(biz.app.goods.model.AttributeSO)
	 */
	
	@Override
	public List<AttributeValueVO> listGoodsItemsAttrSel(AttributePO attr){
		
		List<AttributeValueVO> goodsAttrSelValueList = this.itemDao.listOptionGoodsAttributeValueFO(attr);

		return goodsAttrSelValueList;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: shkim
	* - 설명		: 선택된 옵션으로 단품정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@Override
	public ItemVO checkGoodsOption(ItemSO so) {
		String[] arrAttrNo = so.getAttrNoList().split(",");			//속성번호 리스트
		String[] arrAttrValNo = so.getAttrValNoList().split(",");	//속성 값 번호 리스트
		List<Long> itemNos = new ArrayList<>();	//단품번호 리스트
		List<ItemVO> listItem = new ArrayList<>();	//단품 속성 값 리스트

		// 루프를 돌며 속성번호+속성값+검색된 단품번호(itemNos)를 이용하여 조합된 1개의 단품 조회
		for(int i=0; i<arrAttrNo.length; i++){
			listItem.clear();
			ItemSO itemSO = new ItemSO();
			itemSO.setGoodsId(so.getGoodsId());
			itemSO.setAttrNo(Long.parseLong(arrAttrNo[i]));
			itemSO.setAttrValNo(Long.parseLong(arrAttrValNo[i]));
			itemSO.setItemNos(itemNos);

			listItem = itemDao.listChooseItem(itemSO);
			itemNos.clear();
			for(ItemVO o: listItem){
				itemNos.add(o.getItemNo());
			}
		}

		if(listItem == null || listItem.size() != 1){
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_OPTION);
		}

		getGoodsDeliveryChargePolicy(so.getDlvrcPlcNo(), listItem.get(0));

		return listItem.get(0);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<ItemVO> listGoodsItems(ItemSO itemSO) {
		return itemDao.listGoodsItems(itemSO);
	}

	/* 상품 사은품 조회
	 * @see biz.app.goods.service.GoodsService#listGoodsPromotionFreebie(java.lang.String)
	 */
	@Override
	public List<GoodsBaseVO> listGoodsPromotionFreebie(String goodsId) {
		return promotionDao.listGoodsPromotionFreebie(goodsId);
	}

	@Override
	public List<GoodsBaseVO> listSubGoods(String goodsId) {
		return goodsDao.listSubGoods(goodsId);
	}

	@Override
	public Long getDlgtDispClsfNo(GoodsBaseSO mso) {
		return this.goodsDao.getDlgtDispClsfNo(mso);
	}

	@Override
	public DisplayHotDealVO getHotDealInfo(GoodsBaseSO so) {
		return this.goodsDao.getHotDealInfo(so);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 데이터 매핑
	* </pre>
	*
	* @param goodsBaseStr
	* @param goodsPriceStr
	* @param attributeStr
	* @param itemStr
	* @param goodsNotyfyStr
	* @param goodsCstrtInfoStr
	* @param displayGoodsPOStr
	* @param filtAttrMapPOStr
	* @param goodsIconPOStr
	* @param goodsTagMapPOStr
	* @param goodsImgStr
	* @param goodsCautionStr
	* @param stGoodsMapStr
	* @param goodsDescPO
	* @param optGrpStr
	* @param goodsNaverEpInfoStr
	* @return
	*/
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public GoodsPO setDataToGoodsPO(String goodsBaseStr, String goodsPriceStr, String attributeStr, String itemStr,
			String goodsNotyfyStr, String goodsCstrtInfoStr, String displayGoodsPOStr, String filtAttrMapPOStr,
			String goodsIconPOStr, String goodsTagMapPOStr, String goodsImgStr, String goodsCautionStr,
			String stGoodsMapStr, GoodsDescPO goodsDescPO, String optGrpStr, String goodsNaverEpInfoStr) {
		
		GoodsPO goodsPO = new GoodsPO();
		JsonUtil jsonUt = new JsonUtil();
		
		// 상품 기본
		GoodsBasePO goodsBasePO = (GoodsBasePO) jsonUt.toBean(GoodsBasePO.class, goodsBaseStr);
		goodsPO.setGoodsBasePO(goodsBasePO);

		// 상품 가격
		if(StringUtil.isNotEmpty(goodsPriceStr) ) {
			GoodsPricePO goodsPricePO = (GoodsPricePO) jsonUt.toBean(GoodsPricePO.class, goodsPriceStr);
			goodsPO.setGoodsPricePO(goodsPricePO);
		}

		// 네이버 EP 정보
		if(StringUtil.isNotEmpty(goodsNaverEpInfoStr) ) {
			GoodsNaverEpInfoPO goodsNaverEpInfoPO = (GoodsNaverEpInfoPO) jsonUt.toBean(GoodsNaverEpInfoPO.class, goodsNaverEpInfoStr);
			goodsPO.setGoodsNaverEpInfoPO(goodsNaverEpInfoPO);
		}

		// 상품 구성 타입에 따라
		if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsBasePO.getGoodsCstrtTpCd())) {

			// 단품 옵션
			if (!StringUtil.isEmpty(attributeStr)) {
				List<AttributeSO> attributeSOList = jsonUt.toArray(AttributeSO.class, attributeStr);
				goodsPO.setAttributeSOList(attributeSOList);
			}

			// 단품
			if (!StringUtil.isEmpty(itemStr)) {
				List<ItemSO> itemSOList = jsonUt.toArray(ItemSO.class, itemStr);
				goodsPO.setItemSOList(itemSOList);
			}
			
		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ATTR, goodsBasePO.getGoodsCstrtTpCd())) {
			
			// 묶음옵션 상품
			if (!StringUtil.isEmpty(attributeStr)) {
				List<GoodsCstrtPakPO> goodsCstrtPakPOList = jsonUt.toArray(GoodsCstrtPakPO.class, attributeStr);
				goodsPO.setGoodsCstrtPakPOList(goodsCstrtPakPOList);
			}
			if (!StringUtil.isEmpty(optGrpStr)) {
				List<GoodsOptGrpPO> goodsOptGrpList =  jsonUt.toArray(GoodsOptGrpPO.class, optGrpStr);
				goodsPO.setGoodsOptGrpPOList(goodsOptGrpList);
			}
			
		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_SET, goodsBasePO.getGoodsCstrtTpCd())) {
			
			// 세트 상품
			if (!StringUtil.isEmpty(attributeStr)) {
				List<GoodsCstrtSetPO> goodsCstrtSetPOList =  jsonUt.toArray(GoodsCstrtSetPO.class, attributeStr);
				goodsPO.setGoodsCstrtSetPOList(goodsCstrtSetPOList);
			}
			
		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_PAK, goodsBasePO.getGoodsCstrtTpCd())) {

			// 묶음 상품
			if (!StringUtil.isEmpty(attributeStr)) {
				List<GoodsCstrtPakPO> goodsCstrtPakPOList = jsonUt.toArray(GoodsCstrtPakPO.class, attributeStr);
				goodsPO.setGoodsCstrtPakPOList(goodsCstrtPakPOList);
			}
		}

		// 공정위 품목군
		if (!StringUtil.isEmpty(goodsNotyfyStr)) {
			List<GoodsNotifyPO> goodsNotifyPOList = jsonUt.toArray(GoodsNotifyPO.class, goodsNotyfyStr);
			goodsPO.setGoodsNotifyPOList(goodsNotifyPOList);
		}

		// 연관상품
		if (!StringUtil.isEmpty(goodsCstrtInfoStr)) {
			List<GoodsCstrtInfoPO> goodsCstrtInfoPOList  = jsonUt.toArray(GoodsCstrtInfoPO.class, goodsCstrtInfoStr);
			goodsPO.setGoodsCstrtInfoPOList(goodsCstrtInfoPOList);
		}

		// 전시 상품
		if (!StringUtil.isEmpty(displayGoodsPOStr)) {
			List<DisplayGoodsPO> displayGoodsPOList = jsonUt.toArray(DisplayGoodsPO.class, displayGoodsPOStr);
			goodsPO.setDisplayGoodsPOList(displayGoodsPOList);
		}
		
		// 아이콘
		if (!StringUtil.isEmpty(goodsIconPOStr)) {
			List<GoodsIconPO> goodsIconPOList = jsonUt.toArray(GoodsIconPO.class, goodsIconPOStr);
			goodsPO.setGoodsIconPOList(goodsIconPOList);
		}
		
		// 필터
		if (!StringUtil.isEmpty(filtAttrMapPOStr)) {
			List<FiltAttrMapPO> filtAttrMapPOList = jsonUt.toArray(FiltAttrMapPO.class, filtAttrMapPOStr);
			goodsPO.setFiltAttrMapPOList(filtAttrMapPOList);
		}
		
		// 태그
		if (!StringUtil.isEmpty(goodsTagMapPOStr)) {
			List<GoodsTagMapPO> goodsTagMapPOList = jsonUt.toArray(GoodsTagMapPO.class, goodsTagMapPOStr);
			goodsPO.setGoodsTagMapPOList(goodsTagMapPOList);
		}

		// 상품 이미지
		if (!StringUtil.isEmpty(goodsImgStr)) {
			List<GoodsImgPO> goodsImgPOList = jsonUt.toArray(GoodsImgPO.class, goodsImgStr);
			goodsPO.setGoodsImgPOList(goodsImgPOList);
		}

		// 상품 설명
		List<GoodsDescPO> goodsDescPOList = new ArrayList<>();
		/*
		 * JSON 형식 파라미터 전달 방법으로 에러가 있어서 기본 form submit 스타일로 변경하였음.
		if (!StringUtil.isEmpty(goodsDescStr)) {
			goodsDescPOList = jsonUt.toArray(GoodsDescPO.class, goodsDescStr);
			goodsPO.setGoodsDescPOList(goodsDescPOList);
		}
		*/
		GoodsDescPO goodsDescPc = new GoodsDescPO();
		goodsDescPc.setContent(goodsDescPO.getContentPc());
		goodsDescPc.setSvcGbCd(CommonConstants.SVC_GB_10);

		GoodsDescPO goodsDescMobile = new GoodsDescPO();
		goodsDescMobile.setContent(goodsDescPO.getContentMobile());
		goodsDescMobile.setSvcGbCd(CommonConstants.SVC_GB_20);

		goodsDescPOList.add(goodsDescPc);
		goodsDescPOList.add(goodsDescMobile);
		goodsPO.setGoodsDescPOList(goodsDescPOList);

		// 상품 주의사항
		if(!StringUtil.isEmpty(goodsCautionStr)) {
			GoodsCautionPO goodsCautionPO = (GoodsCautionPO) jsonUt.toBean(GoodsCautionPO.class, goodsCautionStr );
			goodsPO.setGoodsCautionPO(goodsCautionPO );
		}

		// 상품과 사이트 정보 매핑
		if(!StringUtil.isEmpty(stGoodsMapStr)){
			List<StGoodsMapPO> stGoodsMapPOList = jsonUt.toArray(StGoodsMapPO.class, stGoodsMapStr);
			goodsPO.setStGoodsMapPOList(stGoodsMapPOList);
		}
		
		return goodsPO;
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 3. 17.
	* - 작성자 	: valfac
	* - 설명 		: 대표 상품 정보 조회
	* </pre>
	*
	* @param goodsId
	* @param goodsCstrtTpCd
	* @return
	*/
	@Override
	public GoodsBaseVO getDlgtSubGoodsInfo(String goodsId, String goodsCstrtTpCd) {
		GoodsBaseSO so = new GoodsBaseSO();
		so.setGoodsId(goodsId);
		so.setGoodsCstrtTpCd(goodsCstrtTpCd);
		return goodsDao.getDlgtSubGoodsInfo(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 기본 정보 등록
	* </pre>
	*
	* @param goodsBasePO
	* @return
	*/
	@Override
	public GoodsBasePO insertGoodsBase(GoodsBasePO goodsBasePO) {
		
		if(!ObjectUtils.isEmpty(goodsBasePO)){

			if(ObjectUtils.isEmpty(goodsBasePO.getSaleStrtDtm())) {
				goodsBasePO.setSaleStrtDtm(DateUtil.getTimestamp() );
			}
			if(ObjectUtils.isEmpty(goodsBasePO.getSaleEndDtm())) {
				goodsBasePO.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT) );
			}
			
			Session session = AdminSessionUtil.getSession();

			if(CommonConstants.PROJECT_GB_ADMIN.equals(this.webConfig.getProperty("project.gb")) && !AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd())){
				goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_10 );
			}
			
			if(CommonConstants.PROJECT_GB_INTERFACE.equals(this.webConfig.getProperty("project.gb"))){
				
				goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_20 );

				String saleStat40 = this.webConfig.getProperty("goodsStatsCd40");
				String[] ar = saleStat40.split(",");
				String[] saleStat40List = ar;
				for(String cop : saleStat40List){
					Long itfcomp =Long.parseLong(cop);
					if(goodsBasePO.getInterFaceCompNo().equals(itfcomp)){
						goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_40 );
					}
				}
			}

			if(StringUtils.equals(goodsBasePO.getExpMngYn(), CommonConstants.COMM_YN_N)) {
				goodsBasePO.setExpMonth(null);
			}

			goodsBasePO.setTwcSndYn(goodsBasePO.getIgdtInfoLnkYn());

			goodsBaseDao.insertGoodsBase(goodsBasePO );

			// 이력등록 추가
			GoodsBaseHistPO goodsHistPo = new GoodsBaseHistPO();
			try {
				BeanUtils.copyProperties(goodsHistPo, goodsBasePO );
				goodsDao.insertGoodsBaseHist(goodsHistPo );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
		}
		
		return goodsBasePO;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 사이트 매핑 등록
	* </pre>
	*
	* @param goodsBasePO
	* @param goodsPricePO
	* @param stGoodsListParam
	*/
	@Override
	public void insertStGoodsMap(GoodsBasePO goodsBasePO, GoodsPricePO goodsPricePO, List<StGoodsMapPO> stGoodsListParam ) {
		
		if(!ObjectUtils.isEmpty(goodsBasePO)){
			
			StGoodsMapSO so  = new StGoodsMapSO();
			so.setCompNo(goodsBasePO.getCompNo());
			Long saleAmt = goodsPricePO.getSaleAmt();
	
			List<StStdInfoVO> listCompCmsRate = this.listCompCmsRate(so);
			
	        for (StStdInfoVO vo : listCompCmsRate){
	        	
	        	StGoodsMapPO po = new StGoodsMapPO();
	
	        	po.setGoodsId(goodsBasePO.getGoodsId());
	        	po.setStId(vo.getStId());
	        	po.setCmsRate(vo.getCmsRate());
	        	po.setSaleAmt(saleAmt);
	        	po.setGoodsPrcNo(goodsPricePO.getGoodsPrcNo());
	
				//Long splAmt = Math.round((saleAmt - (saleAmt * vo.getCmsRate() / 100))/10)*10;
	
//				Long splAmt = saleAmt - (long) (Math.floor(saleAmt * po.getCmsRate() / 100 / 10) * 10);
//	        	po.setSplAmt(splAmt);
	        	// 공급가 입력으로 변경
	        	po.setSplAmt(goodsPricePO.getSplAmt());
	
	//			if (! validateSplAmtCmsRate(po.getSplAmt(), po.getCmsRate())) {
	//				log.error("GoodsServiceImpl.insertGoods : {}", po);
	//				throw new CustomException(ExceptionConstants.ERROR_GOODS_SPL_AMT_CMS_RATE_ILLEGAL);
	//			}
	
//	        	po.setGoodsStyleCd(getGoodsStyleCdParam(po, stGoodsListParam));
	
	        	this.insertStGoodsMap(po);
	        	this.updateGoodsPrice(po);
	        }
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 구성 정보 등록
	* </pre>
	*
	* @param goodsCstrtInfoPOList
	* @param goodsId
	*/
	public void insertGoodsCstrtInfo(List<GoodsCstrtInfoPO> goodsCstrtInfoPOList, String goodsId) {
		if(CollectionUtils.isNotEmpty(goodsCstrtInfoPOList)) {
			for(GoodsCstrtInfoPO po : goodsCstrtInfoPOList ) {
				po.setGoodsId(goodsId );
				
				
				//sonarqube 처리
				po.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				/*
				if (AdminConstants.GOODS_TP_10.equals(goodsBasePO.getGoodsTpCd()) ) {	// 일반상품
					po.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				} else if (AdminConstants.GOODS_TP_20.equals(goodsBasePO.getGoodsTpCd()) ) {	// Deal 상품
					po.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_10 );	// Deal 상품
				} else {
					po.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				}
				*/
				goodsCstrtDao.insertGoodsCstrtInfo(po );
			}
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 구성 정보 수정
	* </pre>
	*
	* @param goodsCstrtInfoPOList
	* @param goodsId
	*/
	public void updateGoodsCstrtInfo(List<GoodsCstrtInfoPO> goodsCstrtInfoPOList, String goodsId) {
		
		goodsCstrtDao.deleteGoodsCstrtInfo(goodsId );
		insertGoodsCstrtInfo(goodsCstrtInfoPOList, goodsId);
		
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 이미지 등록
	* </pre>
	*
	* @param goodsImgPOList
	* @param goodsId
	*/
	public void insertGoodsImg(List<GoodsImgPO> goodsImgPOList, String goodsId){
		
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		if(CollectionUtils.isNotEmpty(goodsImgPOList)) {
			for(GoodsImgPO po : goodsImgPOList ) {
				po.setGoodsId(goodsId );

				if(!StringUtil.isEmpty(po.getImgPath()) ) {
					
					String filePath = po.getImgPath();
					
					if((po.getImgPath().indexOf(po.getGoodsId()) == -1) && (po.getImgPath().indexOf(bizConfig.getProperty("common.file.upload.base")) == -1)) {
						String[] imgPath = StringUtils.split(po.getImgPath(), FileUtil.SEPARATOR);
						filePath = ftpImgUtil.uploadFilePath(imgPath[ArrayUtils.getLength(imgPath)-1], AdminConstants.GOODS_IMAGE_PATH + FileUtil.SEPARATOR + po.getGoodsId());
						ftpImgUtil.goodsImgCopy(po.getImgPath(), bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + filePath, true);
					}else {
						filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), AdminConstants.GOODS_IMAGE_PATH + FileUtil.SEPARATOR + po.getGoodsId());
						ftpImgUtil.upload(po.getImgPath(), filePath);
					}
					
					po.setImgPath(filePath );
					
					// 이미지 등록
					insertGoodsImg(po );
	
					// 이력 등록
					GoodsImgChgHistPO goodsImgChgHistPO = new GoodsImgChgHistPO ();
					try {
						BeanUtils.copyProperties(goodsImgChgHistPO, po );
					} catch (Exception e) {
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					}
					insertGoodsImgChgHist(goodsImgChgHistPO );
				}

			}
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 8.
	* - 작성자 	: valfac
	* - 설명 		: 이미지 수정
	* </pre>
	*
	* @param goodsImgPOList
	* @param goodsId
	*/
	public void updateGoodsImg(List<GoodsImgPO> goodsImgPOList, String goodsId){

		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		//이미지 삭제 처리
		if(CollectionUtils.isNotEmpty(goodsImgPOList)) {
			List<Integer> imgSeqs = goodsImgPOList.stream().map(GoodsImgPO::getImgSeq).collect(Collectors.toList());

			//이미지 DB 삭제
			//TODO 근데 이미지 실제 경로 삭제는 어디서...? 찾아야 함
			goodsImgDao.deleteGoodsImgBySeq(goodsId, imgSeqs);

			String realPath = "";
			String imgPath = "";
			ImageType imgType = ImageType.GOODS_IMAGE;

			for(GoodsImgPO goodsImgPO: goodsImgPOList) {
				//상품ID 세팅
				goodsImgPO.setGoodsId(goodsId);
				//이미지 경로
				imgPath = goodsImgPO.getImgPath();
				if(StringUtils.isNotEmpty(imgPath)) {
					String tempPath = bizConfig.getProperty("common.file.upload.base") + CommonConstants.TEMP_IMAGE_PATH;
					//새로 올린 이미지
					if (imgPath.startsWith(tempPath)) {
						//FIXME[상품, 이하정, 20210503] 확인중
						//realPath = goodsImgUpload(goodsId, goodsImgPO.getImgSeq(), imgType, imgPath, false);
						//goodsImgPO.setImgPath(realPath);

						realPath = ftpImgUtil.uploadFilePath(goodsImgPO.getImgPath(), AdminConstants.GOODS_IMAGE_PATH + FileUtil.SEPARATOR + goodsImgPO.getGoodsId());
						ftpImgUtil.upload(goodsImgPO.getImgPath(), realPath);
						goodsImgPO.setImgPath(realPath);
					}
				}

				int result = goodsImgDao.updateGoodsImg(goodsImgPO);
				//이미지 DB 정보 등록
				if(result < 1) {
					//goodsImgPO.setImgPath(imgPath);
					//insertGoodsImg(goodsId,Stream.of(goodsImgPO).collect(Collectors.toList()));
					goodsImgDao.insertGoodsImg(goodsImgPO);
				}
			}
			
			//상품 이미지 수정 시 해당 상품 디렉토리 퍼지 
//			PurgeParam param = new PurgeParam();
//			param.setTargetDirectoryName("/goods/" + goodsId);
//			param.setIsWholePurge("false");
//			nhnObjectStorageUtil.requestCdnPlusPurge(param);
		}
	}

	private boolean validateSplAmtCmsRate(Long splAmt, Double cmsRate) {

		return (Objects.nonNull(splAmt) && Objects.nonNull(cmsRate) && splAmt > 0 && cmsRate > 0);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 4. 25.
	* - 작성자		: valueFactory
	* - 설명			: 이미지 리사이징..
	* </pre>
	* @param imgPath
	* @return
	*/
	@Override
	public boolean goodsImgResize (String imgPath ) {
//		ImageInfoData imgInfo = new ImageInfoData();
//		imgInfo.setImageType (ImageType.GOODS_IMAGE );
//		imgInfo.setOrgImgPath (imgPath );
//		imgInfo.setTargetImgPath(this.webConfig.getProperty("image.physical.path.goods") + File.separator + );
//		try {
//			ImageResizer resizer = new ImageResizer(imgInfo);
//			resizer.process();
//		} catch (IOException e) {
//			throw new CustomException( ExceptionConstants.ERROR_GOODS_IMAGE_RESIZE );
//		} catch (Exception e) {
//			throw new CustomException( ExceptionConstants.ERROR_GOODS_IMAGE_RESIZE );
//		}
//

		ImageInfoData imgInfo = new ImageInfoData();
		imgInfo.setImageType (ImageType.GOODS_IMAGE );
		imgInfo.setOrgImgPath (imgPath );
		ImageHandler handler = new ImageHandler(bizConfig);
		boolean isSucess = handler.ftpJob(imgInfo );
		log.debug("##main## (goodsImgResize, 이미지 리사이징) isSucess=" + isSucess);
		return isSucess;
	}

	@Override
	public List<NotifyInfoVO> listNotifyInfo () {
		return goodsNotifyDao.listNotifyInfo();
	}


	@Override
	public List<NotifyItemVO> listNotifyItem (NotifyItemSO so ) {
		return goodsNotifyDao.listNotifyItem(so );
	}

	@Override
	public List<biz.app.goods.model.interfaces.NotifyItemVO> listNotifyItemInterface (biz.app.goods.model.interfaces.NotifyItemSO so ) {
		return goodsNotifyDao.listNotifyItemInterface(so );
	}


	@Override
	public List<DeliveryChargePolicyVO> listCompDlvrcPlc (Long compNo ) {
		return companyDao.listCompDlvrcPlc(compNo );
	}


	//@Override
//	public CompanyCclVO getCompCcl (Long compNo ) {
//		return companyDao.getCompCcl(compNo );
//	}


	@Override
	public List<GoodsBaseVO> pageGoodsBase (GoodsBaseSO goodsBaseSO ) {
		return goodsDao.pageGoodsBase(goodsBaseSO );
	}

	@Override
	public List getGoodsBaseList (GoodsBaseSO goodsBaseSO ) {
		List<HashMap> list = goodsDao.selectGoodsBaseList(goodsBaseSO );
		List<HashMap> result = new ArrayList<>();
		for(HashMap map : list) {
			GoodsCommentSO gcSO = new GoodsCommentSO();
			gcSO.setGoodsId(map.get("GOODS_ID").toString());
			gcSO.setGoodsCstrtTpCd(map.get("GOODS_CSTRT_TP_CD").toString());
			int commentCnt = goodsCommentDao.pageGoodsCommentCount(gcSO);
			map.put("COMMENT", commentCnt);
			result.add(map);
		}
		return result;
	}

	/* 상품 가격 집계 조회
	 * @see biz.app.goods.service.GoodsService#getGoodsPriceTotal(java.lang.String)
	 */
	@Override
	public GoodsPriceTotalVO getGoodsPriceTotal(String goodsId) {
		return this.goodsDao.getGoodsPriceTotal(goodsId);
	}


	@Override
	public GoodsBaseVO getGoodsSimpleInfo (String goodsId ) {
		return goodsDao.getGoodsSimpleInfo(goodsId );
	}


	@Override
	public GoodsBaseVO getGoodsDetail (String goodsId ) {
		return goodsDao.getGoodsDetail(goodsId );
	}

	@Override
	public List<DisplayGoodsVO> listGoodsDispCtg (String goodsId ) {
		return goodsDao.listGoodsDispCtg(goodsId );
	}


	@Override
	public GoodsDescVO getGoodsDescAll (String goodsId ) {
		return goodsDescDao.getGoodsDescAll(goodsId );
	}


	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsCstrtInfoVO> listGoodsCstrtInfo (GoodsCstrtInfoSO goodsCstrtInfoSO ) {
		List<StStdInfoVO> stStdList = goodsCstrtDao.listStStdInfoByDealGoods(goodsCstrtInfoSO);
		goodsCstrtInfoSO.setStStdList(stStdList);

		return goodsCstrtDao.listGoodsCstrtInfo(goodsCstrtInfoSO );
	}

	@Override
	public List<GoodsImgVO> listGoodsImg (String goodsId ) {
		GoodsImgSO goodsImgSO = new GoodsImgSO();
		goodsImgSO.setGoodsId(goodsId);
		return listGoodsImg(goodsImgSO);
	}
	
	@Override
	public List<GoodsImgVO> listGoodsImg (GoodsImgSO goodsImgSO) {
		List<GoodsImgVO> list = goodsImgDao.listGoodsImg(goodsImgSO);
		return list;
	}

	@Override
	public void updateGoodsPrice (GoodsPriceSO so ) {

		log.debug("price update so>>>>>>>>>"+so);

//		Session session = AdminSessionUtil.getSession();;

		// 상품구성 : 일반
		if(AdminConstants.GOODS_TP_10.equals(so.getGoodsTpCd() )) {
			// 종료 일자
			Timestamp foreverDate = DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT);

			// 현재 세일 / 미래가 (가격인하, 세일)
			String changeFutureYn = so.getChangeFutureYn();
			String changeCurrentSaleYn = so.getChangeCurrentSaleYn();

			// 지금 현재 시간을 Java Sysdate로 한다.
			// 혹시나 모를.. 시간차를 제거하기위해.. 현재시각
			Timestamp sysDatetime = DateUtil.getTimestamp();
			so.setSysDatetime(sysDatetime );

			// 현재 가격정보 조회
			GoodsPriceVO currentPrice = goodsPriceDao.checkGoodsPriceHistory(so );
			if(log.isDebugEnabled() ) {
				LogUtil.log("############ currentPrice : " + currentPrice );
			}
			//현재 가격의 상품가격일련번호
			Long curPrcNo = currentPrice.getGoodsPrcNo();

			Long beforeOrgPrice = currentPrice.getOrgSaleAmt(); //원판매가
			Long beforeSalePrice = currentPrice.getSaleAmt();
			String beforePriceTypeCode = currentPrice.getGoodsAmtTpCd();
			Long futureOrgPrice = beforeSalePrice;
			// 진행중인 판매 시작일
			Timestamp nowSaleStartDate = currentPrice.getSaleStrtDtm();
			log.debug("현재가격의 판매 시작일 >>>"+nowSaleStartDate);

			if(AdminConstants.COMM_YN_Y.equals(changeCurrentSaleYn) || AdminConstants.COMM_YN_Y.equals(changeFutureYn)) {
				// 세일할 경우 Recovery 하기 위한 변수
				//Long futureOrgCostAmt = currentPrice.getCostAmt();
//					Long futureOrgSplAmt = currentPrice.getSplAmt();
//					Double futureOrgCmsRate = currentPrice.getCmsRate();

				log.debug("############ 0. 미래정보 삭제처리");
				GoodsPricePO fpo = new GoodsPricePO();
				fpo.setGoodsId(so.getGoodsId());
				fpo.setSysDatetime(sysDatetime);
				fpo.setDelYn(CommonConstants.COMM_YN_Y);

				goodsPriceDao.deleteGoodsPriceHistory(fpo);

				GoodsPricePO recoveryPrice = new GoodsPricePO();
				recoveryPrice.setGoodsId(so.getGoodsId() );
				recoveryPrice.setGoodsAmtTpCd(AdminConstants.GOODS_AMT_TP_10 );
				recoveryPrice.setSysDatetime(sysDatetime );

				String futureType = so.getGoodsAmtTpCd();

				//---------------------------------------------------------------------------------------------------
				// 핫딜 진행중인 경우
				if(AdminConstants.GOODS_AMT_TP_20.equals(beforePriceTypeCode) ) {
						futureOrgPrice = beforeOrgPrice; // 현재 핫딜중이면, 미래의 원판가는 현재의 원판매가
						if(so.getSaleEndDtm() == null ) {
							// 20170728 추가 ( 핫딜 진행중인데 일반가로 가격 변경을 할 경우에
							if(so.getGoodsAmtTpCd().equals(CommonConstants.GOODS_AMT_TP_10)){
								so.setSaleEndDtm(foreverDate);
							}else{
								throw new CustomException( ExceptionConstants.ERROR_GOODS_SALE_END_DTM_NOT_EXIST );
							}
						}

						// 진행중인 세일 종료일
						//Timestamp nowSaleEndDate = so.getSaleEndDtm(); 2017.07.28 주석처리
						Timestamp nowSaleEndDate = DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 );
						log.debug("nowSaleEndDate ==>"+nowSaleEndDate);
						// 진행중인 세일 정보 변경 시 ---------------------------------------------------------------------
						if(AdminConstants.COMM_YN_Y.equals(changeCurrentSaleYn) ) {
							// 진행중인 세일 정보 변경 시
							// 	진행중인 세일 종료일이 sysDatetime 보다 나중이여야 한다.
								if(sysDatetime.after(nowSaleEndDate) ) {
									throw new CustomException( ExceptionConstants.ERROR_GOODS_SALE_END_DTM );
								}
								log.debug("############ 1. 세일만 :: 세일 정보 수정");
								// 진행중인 세일의 정보 삭제
								GoodsPricePO cpo = new GoodsPricePO();
								cpo.setGoodsPrcNo(curPrcNo);
								cpo.setDelYn(CommonConstants.COMM_YN_Y);
								cpo.setGoodsId(so.getGoodsId());
								goodsPriceDao.deleteGoodsPriceHistory(cpo);

								// hjko 추가 ( 핫딜 중일 경우 종료일 수정시 기존 진행중인 핫딜 가격 정보 다시 insert위해 생성)
								GoodsPricePO currentPricePO = new GoodsPricePO();
								currentPricePO.setDelYn(CommonConstants.COMM_YN_N);
								currentPricePO.setFvrVal(currentPrice.getFvrVal());
								currentPricePO.setFvrAplMethCd(currentPrice.getFvrAplMethCd());
								currentPricePO.setGoodsAmtTpCd(currentPrice.getGoodsAmtTpCd());
								currentPricePO.setGoodsId(so.getGoodsId() );
								currentPricePO.setOrgSaleAmt(currentPrice.getOrgSaleAmt() );
								currentPricePO.setSaleAmt(currentPrice.getSaleAmt() );
								currentPricePO.setSaleStrtDtm(currentPrice.getSaleStrtDtm());
								currentPricePO.setSaleEndDtm(DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 ));
								//currentPricePO.setSaleEndDtm(so.getSaleEndDtm() );
								currentPricePO.setSysDatetime(sysDatetime );

								goodsPriceDao.insertGoodsPrice(currentPricePO);

						}

						boolean compareGap = false;
						if(StringUtil.isBlank(futureType)){ // 미래가 없는 경우
							recoveryPrice.setSaleEndDtm(foreverDate );
						} else {
							// 진행중인 세일 종료일과 미래가 시작일의 기간 차이 정보 입력
							compareGap = nowSaleEndDate.equals(DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 ));
							log.info("compareGap :: false이면 gap 존재 :: " + compareGap );
							if(!compareGap ) {
								recoveryPrice.setSaleEndDtm(DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 ));
							}
						}

						// 미래가 없거나 미래가 시작일과의 gap 있으면, 진행중인 세일의 현재가 복원 처리
						if( StringUtil.isBlank(futureType) || !compareGap ) {

							// nowSaleStartDate
							GoodsPriceSO before = new GoodsPriceSO ();
							before.setGoodsId(so.getGoodsId() );
							before.setSysDatetime(DateUtil.getHistoryDate(nowSaleStartDate, -1) );
							GoodsPriceVO beforeHist = goodsPriceDao.getbeforeGoodsPriceHistory(before );
//								if(beforeHist != null ) {
//									futureOrgCostAmt = beforeHist.getCostAmt();
//								}

							recoveryPrice.setSaleStrtDtm(DateUtil.getHistoryDate(nowSaleEndDate, 1) );
							recoveryPrice.setSaleAmt(futureOrgPrice );
							recoveryPrice.setOrgSaleAmt(futureOrgPrice );

							log.debug("############ 2.  세일만 :: GAP or 기존 세일 현재가 복원 처리");
						}
						//goodsPriceDao.insertGoodsPrice(recoveryPrice ); 20170728 주석처리
				//---------------------------------------------------------------------------------------------------
				// 공동구매 insert 부분으로 구현 시 아래의 주석으로 된 부분이 필요
				// 공동구매 진행중인 경우 insert 부분으로 구현을 하였다가 update 로 변경 함
//				} else  if(AdminConstants.GOODS_AMT_TP_30.equals(beforePriceTypeCode) ) {
//						// 진행중인 세일 종료일
//						//Timestamp nowSaleEndDate = so.getSaleEndDtm(); 2017.07.28 주석처리
//						Timestamp nowSaleEndDate = DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 );
//						log.debug("nowSaleEndDate ==>"+nowSaleEndDate);
//						// 진행중인 세일 정보 변경 시 ---------------------------------------------------------------------
//						// 진행중인 세일의 정보 삭제
//						GoodsPricePO cpo = new GoodsPricePO();
//						cpo.setGoodsPrcNo(curPrcNo);
//						cpo.setDelYn(CommonConstants.COMM_YN_Y);
//						cpo.setGoodsId(so.getGoodsId());
//						goodsPriceDao.deleteGoodsPriceHistory(cpo);
//
//						// nowSaleStartDate
//						GoodsPriceSO before = new GoodsPriceSO ();
//						before.setGoodsId(so.getGoodsId() );
//						before.setSysDatetime(DateUtil.getHistoryDate(nowSaleStartDate, -1) );
//						GoodsPriceVO beforeHist = goodsPriceDao.getbeforeGoodsPriceHistory(before );
//						futureOrgPrice = beforeHist.getOrgSaleAmt();
//
//						recoveryPrice.setSaleStrtDtm(DateUtil.getHistoryDate(nowSaleEndDate, 1) );
//						recoveryPrice.setSaleAmt(futureOrgPrice );
//						recoveryPrice.setOrgSaleAmt(futureOrgPrice );
				} else {
					//---------------------------------------------------------------------------------
					// 진행중인 세일 없는 경우 (현재 단순변경, 핫딜 등록)
					if (StringUtil.isBlank(futureType) ) {
						recoveryPrice.setSaleEndDtm(foreverDate );
					} else {
						recoveryPrice.setSaleEndDtm(DateUtil.getHistoryDate(so.getSaleStrtDtm(), -1 ));
					}

					log.debug("############ 3. 단순/가격 end 수정");
					goodsPriceDao.updateGoodsPriceHisEndDateTime(recoveryPrice );
				}

				// 미래가 처리 (현재가와 상관없이)
				if (StringUtil.isNotBlank(futureType) ) {
					// 미래가 시작일이 sysDatetime 보다 나중이여야 한다.
					if(sysDatetime.after(so.getSaleStrtDtm() )) {
					/*// 공동구매 insert 부분으로 구현 시 아래의 주석으로 된 부분이 필요
					// 공동구매 진행중일 경우 시작을 수정이 안됨으로 체크 안함
					if(sysDatetime.after(so.getSaleStrtDtm() )
							&& !(AdminConstants.COMM_YN_Y.equals(changeCurrentSaleYn) && AdminConstants.GOODS_AMT_TP_30.equals(beforePriceTypeCode))) {*/
						throw new CustomException( ExceptionConstants.ERROR_GOODS_SALE_STRT_DTM );
					}
					// 미래 단순변경
					if(AdminConstants.GOODS_AMT_TP_10.equals(futureType) ) {  // 일반
						so.setOrgSaleAmt(so.getSaleAmt() );
					} else if (AdminConstants.GOODS_AMT_TP_20.equals(futureType)) {	// 핫딜, 공동구매
						so.setOrgSaleAmt(futureOrgPrice );
						Long futureSalePrice = null;

						// 정액
						if(AdminConstants.FVR_APL_METH_20.equals(so.getFvrAplMethCd()) ) {
							futureSalePrice = futureOrgPrice - so.getFvrVal();
						} else {
							// 정률
							futureSalePrice = futureOrgPrice - (futureOrgPrice * so.getFvrVal() / 100 );
						}

						so.setSaleAmt(futureSalePrice );

						// 미래 세일 종료시 미래 세일의 현재가 복원
						recoveryPrice.setSaleAmt(futureOrgPrice );
						recoveryPrice.setOrgSaleAmt(futureOrgPrice );
						recoveryPrice.setSaleStrtDtm(DateUtil.getHistoryDate(so.getSaleEndDtm(), 1 ) );
						recoveryPrice.setSaleEndDtm(foreverDate );


						log.debug("############ 4. 미래 세일 현재복원가");
						goodsPriceDao.insertGoodsPrice(recoveryPrice );
					}
					log.debug("############ 5. 미래가");

					BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
					GoodsPricePO po = new GoodsPricePO();
					try {
						BeanUtils.copyProperties(po, so );
					} catch (Exception e) {
						throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
					}

					if(po.getSaleEndDtm() == null) {
						po.setSaleEndDtm(foreverDate);
					}

					goodsPriceDao.insertGoodsPrice (po );
				}

				// 최종적으로 현재~미래 날짜 연속성 체크 & 마지막 날짜 9999
				boolean finalCheck = false;
				List<GoodsPriceVO> nowFuturePriceList = goodsPriceDao.listFutureGoodsPriceHistory(so );

				if(nowFuturePriceList != null && !nowFuturePriceList.isEmpty()) {
					int listSize = nowFuturePriceList.size();
					int idx = 0;
					for(GoodsPriceVO futurePrice : nowFuturePriceList ) {
						// 마지막 데이타 종료일 체크
						if((listSize == 1 || idx == listSize - 1 )
								&& !futurePrice.getSaleEndDtm().equals(foreverDate) ) {
							log.info("############ 종료일 :: " + futurePrice.getSaleEndDtm() );
							finalCheck = true;
						}
						// 현재부터 미래까지의 데이트 연속성 체크
						if(listSize > 1 && idx + 1 < listSize
							&& !futurePrice.getSaleEndDtm().equals(DateUtil.getHistoryDate(nowFuturePriceList.get(idx + 1).getSaleStrtDtm(), -1))) {
							log.info("############ 종료일 :: " + futurePrice.getSaleEndDtm() );
							log.info("############ 연속성 :: " + futurePrice.getSaleEndDtm() );
							log.info("############ 연속성 :: " + DateUtil.getHistoryDate(nowFuturePriceList.get(idx + 1).getSaleStrtDtm(), -1) );
							finalCheck = true;
						}
						if(finalCheck) {
							break;
						}
						idx ++;
					}
				}
				log.debug("nowFuturePriceList-->"+nowFuturePriceList);
				log.debug("finalCheck-->"+finalCheck);
				if( nowFuturePriceList == null || nowFuturePriceList.isEmpty() || finalCheck ) {
					throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
				}
			}
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 등록
	* </pre>
	*
	* @param goodsPO
	* @param attributeStr
	* @return
	*/
	@Override
	@Transactional(rollbackFor=Exception.class)
	public GoodsBaseVO insertGoods (GoodsPO goodsPO, String attributeStr, boolean cisFlag) {

		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		// 상품 기본 등록
		GoodsBasePO goodsBasePO = insertGoodsBase(goodsPO.getGoodsBasePO());
		String goodsId = goodsBasePO.getGoodsId();

		// 상품 가격정보 등록
		goodsPO.getGoodsPricePO().setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT));
		goodsPO.getGoodsPricePO().setSaleStrtDtm(DateUtil.getTimestamp());
		GoodsPricePO goodsPricePO = goodsPriceService.insertGoodsPrice(goodsPO.getGoodsPricePO(), goodsBasePO);

		// 네이버 EP 정보 등록
		goodsNaverEpInfoService.insertGoodsNaverEpInfo(goodsPO.getGoodsNaverEpInfoPO(), goodsId);

		// 상품 구성 정보 등록
		if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ATTR, goodsBasePO.getGoodsCstrtTpCd())) {

			// 옵션 상품
			goodsCstrtPakService.insertGoodsCstrtPak(goodsPO.getGoodsCstrtPakPOList(), goodsId);
			goodsOptGrpService.insertGoodsOptGrp(goodsPO.getGoodsOptGrpPOList(), goodsId);

		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_SET, goodsBasePO.getGoodsCstrtTpCd())) {

			// 세트 상품
			goodsCstrtSetService.insertGoodsCstrtSet(goodsPO.getGoodsCstrtSetPOList(), goodsId);

		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_PAK, goodsBasePO.getGoodsCstrtTpCd())) {

			// 묶음 상품
			goodsCstrtPakService.insertGoodsCstrtPak(goodsPO.getGoodsCstrtPakPOList(), goodsId);

		}
		
		// 단품 등록
		itemService.insertItemWithSkuCd(goodsId, goodsPO.getAttributeSOList(), goodsPO.getItemSOList(), goodsBasePO);

		// 상품 구성 히스토리 등록
		if(!StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsBasePO.getGoodsCstrtTpCd()) && !ObjectUtils.isEmpty(attributeStr)) {

			GoodsCstrtHistPO goodsCstrtHistPO = new GoodsCstrtHistPO();
			goodsCstrtHistPO.setCstrtJson(StringEscapeUtils.unescapeXml(attributeStr));
			goodsCstrtHistPO.setGoodsId(goodsId);
			goodsCstrtHistPO.setGoodsCstrtTpCd(goodsBasePO.getGoodsCstrtTpCd());

			goodsCstrtDao.insertGoodsCstrtHist(goodsCstrtHistPO);

		}

		// 상품 설명 정보 등록
		goodsDescService.insertGoodsDesc(goodsId, goodsPO.getGoodsDescPOList());

		// 상품 주의사항 등록
		goodsCautionService.insertGoodsCaution(goodsId, goodsPO.getGoodsCautionPO());

		// 상품 고시 정보 등록
		goodsNotifyService.insertGoodsNotify(goodsId, goodsPO.getGoodsNotifyPOList());

		// 전시 카테고리 정보 등록
		displayService.insertDisplayGoods(goodsId, goodsPO.getDisplayGoodsPOList());

		// 상품 아이콘  등록
		goodsIconService.insertGoodsIcon(goodsId, goodsPO.getGoodsIconPOList());

		// 상품 필터 속성 매핑 등록
		filtAttrMapService.insertFiltAttrMap(goodsId, goodsPO.getFiltAttrMapPOList());

		// 상품 태그 매핑 등록
		goodsTagMapService.insertGoodsTagMap(goodsId, goodsPO.getGoodsTagMapPOList());

		// 사이트별 상품 수수료 정보를 등록한다.
		insertStGoodsMap(goodsBasePO, goodsPricePO, goodsPO.getStGoodsMapPOList());

		// 연관 상품 등록
		insertGoodsCstrtInfo(goodsPO.getGoodsCstrtInfoPOList(), goodsId);

		// 상품 이미지 처리.
		insertGoodsImg(goodsPO.getGoodsImgPOList(), goodsId);

/*
		// 사이트상품매핑  hjko
		List<StGoodsMapPO> stGoodsMapPOList = goodsPO.getStGoodsMapPOList();
		for(StGoodsMapPO stGoodsMap : stGoodsMapPOList){
			stGoodsMap.setGoodsId(goodsBasePO.getGoodsId());
			stGoodsMap.setCmsRate( new Double( String.valueOf(  goodsPricePO.getCmsRate()  )) );
			Long splAmt =  (long)( saleAmt - ( saleAmt * stGoodsMap.getCmsRate() / 100  ) );
			stGoodsMap.setSplAmt(splAmt);
			this.insertStGoodsMap(stGoodsMap);
		}
*/

		GoodsBaseVO resultGoodsBaseVO = new GoodsBaseVO();
		
		
		if(cisFlag) {
			// CIS 상품 등록
			
			if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsBasePO.getGoodsCstrtTpCd())) {

				String resultMsg = "";
				
				try {
					SkuInfoSO skuInfoSO = new SkuInfoSO();
					skuInfoSO.setGoodsId(goodsId);
					skuInfoSO.setBatchYn(CommonConstants.COMM_YN_N);
					skuInfoSO.setGoodsCstrtTpCd(goodsPO.getGoodsBasePO().getGoodsCstrtTpCd());
					skuInfoSO.setSendType("insert");

					List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);

					HashMap result = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), list);
					HashMap resultMsgMap = (HashMap) result.get(goodsId);
	
					//CIS 응답코드
					String resCd = (String) resultMsgMap.keySet().toArray()[0];
					//CIS 응답메세지
	
					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						resultMsg = (String) resultMsgMap.get(resCd);
						throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
					}else {
						Integer cisNo = (Integer) resultMsgMap.get(resCd);
						goodsBaseDao.updateGoodsCisNo(cisNo, goodsId);
						//가격 CIS_YN 전송 여부 Y으로 변경
						goodsPricePO.setCisYn(CommonConstants.COMM_YN_Y);
						goodsPriceDao.updateGoodsPriceCisYn(goodsPricePO);
					}
	
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
				}
			}

			resultGoodsBaseVO.setGoodsId(goodsId);
		} else {
			resultGoodsBaseVO.setGoodsId(goodsId);
		}

		return resultGoodsBaseVO;
	}

	@Override
	public GoodsBaseVO insertGoods (GoodsPO goodsPO, String attributeStr ) {
		return insertGoods(goodsPO, attributeStr, true);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 기본 정보 수정
	* </pre>
	*
	* @param goodsBasePO
	*/
	public void updateGoodsBase(GoodsBasePO goodsBasePO) {
		if(!ObjectUtils.isEmpty(goodsBasePO)) {
			
			//보안 진단. 불필요한 코드 (비어있는 IF문)
			/*Session session = AdminSessionUtil.getSession();
			if(session !=null){
				if(!AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd())) {
					// 업체가 상품수정할 때 상태변경하던 것을 주석처리함.
					// goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_20 );
				}
			}
			// 인터페이스 등록일 경우
			else{
				// 업체가 상품수정할 때 상태변경하던 것을 주석처리함.
				// goodsBasePO.setGoodsStatCd(AdminConstants.GOODS_STAT_20 );
			}*/

			CompanySO companySO = new CompanySO();
			companySO.setCompNo(goodsBasePO.getCompNo());
//			companyBaseVO = companyDao.getCompany(companySO);

			// 단품 조회
			//list = itemDao.listGoodsItem(goodsBasePO.getGoodsId());

			goodsDao.updateGoodsBase(goodsBasePO );

			// 상품 기본 이력 등록
			GoodsBaseHistPO goodsHistPo = new GoodsBaseHistPO();
			try {
				BeanUtils.copyProperties(goodsHistPo, goodsBasePO );
				goodsDao.insertGoodsBaseHist(goodsHistPo );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 사이트 매핑 수정
	* </pre>
	*
	* @param stGoodsMapPOList
	* @param goodsId
	*/
	public void updateStGoodsMap(List<StGoodsMapPO> stGoodsMapPOList, String goodsId) {
		
		if(StringUtils.isNotEmpty(goodsId)) {
			// 사이트상품 매핑 정보 조회
			StGoodsMapSO smso = new StGoodsMapSO();
			smso.setGoodsId(goodsId);
			smso.setGetAll(CommonConstants.COMM_YN_Y);
	
			List<StGoodsMapVO> siteGdList = this.listStStdInfoGoods(smso);
	
			// 사이트상품 매핑 정보 수정
			for (int idx = 0; idx < siteGdList.size(); idx++) {
				
				StGoodsMapVO stGoodsVO = siteGdList.get(idx);
	
				// 파라미터의 사이트 정보가 DB에 등록된 사이트정보에  있으면 업데이트, 없으면 삭제한다.
				if (existsStGoods(stGoodsVO, stGoodsMapPOList)) {
					StGoodsMapPO stGoodsPO = new StGoodsMapPO();
					stGoodsPO.setGoodsId(stGoodsVO.getGoodsId());
					stGoodsPO.setStId(stGoodsVO.getStId());
					// goodsStyleCd만 업데이트된다. goodsStyleCd 값은 똑같으므로 파라미터 리스트의 첫번째 값을 사용함.
					// 수수료, 공급가는 전용 업데이트 URL 이 있음.^^
					stGoodsPO.setGoodsStyleCd(getGoodsStyleCdParam(stGoodsPO, stGoodsMapPOList));
	
					goodsDao.updateStGoodsMap(stGoodsPO);
				} else {
					smso.setGoodsId(stGoodsVO.getGoodsId());
					smso.setStId(stGoodsVO.getStId());
	
					this.deleteStGoodsMap(smso);
				}
			}
		}
	}
	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 수정
	* </pre>
	*
	* @param goodsPO
	* @return
	*/
	@Override
	@Transactional(rollbackFor=Exception.class)
	public GoodsBaseVO updateGoods (GoodsPO goodsPO ) {
		
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		updateGoodsBase(goodsPO.getGoodsBasePO());
		String goodsId = goodsPO.getGoodsBasePO().getGoodsId();
		String goodsCstrtTpCd = goodsPO.getGoodsBasePO().getGoodsCstrtTpCd();

		// 사이트상품매핑  파라미터
		updateStGoodsMap(goodsPO.getStGoodsMapPOList(), goodsId);

		// 수정 가능 확인
		GoodsBaseVO checkPossibleCnt = checkPossibleCnt(goodsId);

		if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsCstrtTpCd)) {
			//매입업체 수정 가능
			String compGbCd = goodsPO.getGoodsBasePO().getCompGbCd();
			//CSR-970. 2021-06-22
//			if(StringUtils.equals(compGbCd, AdminConstants.COMP_GB_10)) {
//				goodsSkuDao.updatePhsCompNo(goodsId, goodsPO.getGoodsBasePO().getPhsCompNo());
//			}
			goodsSkuDao.updatePhsCompNo(goodsId, goodsPO.getGoodsBasePO().getPhsCompNo());

			if( checkPossibleCnt.getCheckCstrtUpdCnt() < 1 ) {
				// 단품 상품
				itemService.updateItem(goodsPO, goodsId);
			}else {
				// 위탁 업체일 경우 재고 update
				if(StringUtils.equals(goodsPO.getGoodsBasePO().getCompGbCd(), CommonConstants.COMP_GB_20) ) {
					itemService.updateItemWebStk(goodsPO, goodsId);
				}
			}
		}else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_SET, goodsCstrtTpCd) && checkPossibleCnt.getCheckCstrtUpdCnt() < 1) {
			// 세트 상품
			goodsCstrtSetService.deleteGoodsCstrtSet(goodsId);
			goodsCstrtSetService.insertGoodsCstrtSet(goodsPO.getGoodsCstrtSetPOList(), goodsId);

		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ATTR, goodsCstrtTpCd)) {
			// 옵션 상품 TODO CIS API 오류 처리 후 변경 필요
			if(checkPossibleCnt.getCheckCstrtUpdCnt() < 1) {
				goodsCstrtPakService.deleteGoodsCstrtPak(goodsId);
			}
			goodsCstrtPakService.insertGoodsCstrtPak(goodsPO.getGoodsCstrtPakPOList(), goodsId);
			

			if(checkPossibleCnt.getCheckCstrtUpdCnt() < 1) {
				goodsOptGrpService.deleteGoodsOptGrp(goodsId);
				goodsOptGrpService.insertGoodsOptGrp(goodsPO.getGoodsOptGrpPOList(), goodsId);
			}

		} else if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_PAK, goodsCstrtTpCd)) {
			// 묶음 상품 TODO CIS API 오류 처리 후 변경 필요
			if(checkPossibleCnt.getCheckCstrtUpdCnt() < 1) {
				goodsCstrtPakService.deleteGoodsCstrtPak(goodsId);
			}
			goodsCstrtPakService.insertGoodsCstrtPak(goodsPO.getGoodsCstrtPakPOList(), goodsId);
		}
		
		goodsNaverEpInfoService.updateGoodsNaverEpInfo(goodsPO.getGoodsNaverEpInfoPO());

		// 상품 설명 수정
		goodsDescService.updateGoodsDesc(goodsId, goodsPO.getGoodsDescPOList());
		
		// 상품 주의사항 수정
		goodsCautionService.updateGoodsCaution(goodsId, goodsPO.getGoodsCautionPO());
		
		// 상품 고시 정보 수정
		goodsNotifyService.updateGoodsNotify(goodsId, goodsPO.getGoodsNotifyPOList());

		// 전시 카테고리 정보 수정
		displayService.updateDisplayGoods(goodsId, goodsPO.getDisplayGoodsPOList());
		
		// 상품 아이콘  등록
		// 상품 상세에서 수정할 경우, USR_DFN2_VAL ="N"
		//goodsIconService.updateGoodsIcon(goodsId, goodsPO.getGoodsIconPOList(), null, CommonConstants.USE_YN_N);
		goodsIconService.saveGoodsIcon(Arrays.stream(new String[]{goodsId}).collect(Collectors.toList()), goodsPO.getGoodsIconPOList(), null, CommonConstants.USE_YN_N);

		// 상품 필터 속성 매핑 등록
		filtAttrMapService.updateFiltAttrMap(goodsId, goodsPO.getFiltAttrMapPOList());
		
		// 상품 태그 매핑 등록
		goodsTagMapService.updateGoodsTagMap(goodsId, goodsPO.getGoodsTagMapPOList());

		// 연관 상품 등록
		updateGoodsCstrtInfo(goodsPO.getGoodsCstrtInfoPOList(), goodsId);
		
		// 상품 이미지 처리.
		updateGoodsImg(goodsPO.getGoodsImgPOList(), goodsId);
		
		GoodsBaseVO resultGoodsBaseVO = new GoodsBaseVO();

		// CIS 상품 수정
		if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsPO.getGoodsBasePO().getGoodsCstrtTpCd())) {
			String resultMsg = "";
			
			try {
				SkuInfoSO skuInfoSO = new SkuInfoSO();
				skuInfoSO.setGoodsId(goodsId);
				skuInfoSO.setBatchYn(CommonConstants.COMM_YN_N);
				skuInfoSO.setGoodsCstrtTpCd(goodsPO.getGoodsBasePO().getGoodsCstrtTpCd());
				if(ObjectUtils.isEmpty(checkPossibleCnt.getCisNo())) {
					skuInfoSO.setSendType("insert");
				}else {
					skuInfoSO.setSendType("update");
				}

				List<SkuInfoVO> list = cisGoodsService.getStuInfoListForSend(skuInfoSO);

				HashMap result = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), list);
				HashMap resultMsgMap = (HashMap) result.get(goodsId);

				//CIS 응답코드
				String resCd = (String) resultMsgMap.keySet().toArray()[0];
				//CIS 응답메세지
				if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
					resultMsg = (String) resultMsgMap.get(resCd);
					throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
				}else {
					// 복사 일 경우 cis insert 후 cis_no update
					if(ObjectUtils.isEmpty(checkPossibleCnt.getCisNo())) {
						Integer cisNo = (Integer) resultMsgMap.get(resCd);
						goodsBaseDao.updateGoodsCisNo(cisNo, goodsId);
					}
				}
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMsg});
			}
		}
		
		resultGoodsBaseVO.setGoodsId(goodsId);

		return resultGoodsBaseVO;
		
	}

	private String getGoodsStyleCdParam(StGoodsMapPO stGoodsPO, List<StGoodsMapPO> stGoodsMapPOList) {
		String goodsStyleCd = "";
		for (StGoodsMapPO stGoodsParam : stGoodsMapPOList) {
			if (stGoodsPO.getStId().compareTo(stGoodsParam.getStId()) == 0) {
				goodsStyleCd = stGoodsParam.getGoodsStyleCd();
				break;
			}
		}

		return goodsStyleCd;
	}

	private boolean existsStGoods(StGoodsMapVO stGoods, List<StGoodsMapPO> stGoodsMapPOList) {
		boolean exists = false;
		for (StGoodsMapPO stGoodsParam : stGoodsMapPOList) {
			if (stGoods.getStId().compareTo(stGoodsParam.getStId()) == 0) {
				exists = true;
				break;
			}
		}

		return exists;
	}

	@Override
	public int updateGoodsImg (GoodsImgPO po ) {
		return goodsImgDao.updateGoodsImg(po );
	}

	@Override
	public int deleteGoodsImg (GoodsImgPO po ) {
		return goodsImgDao.deleteGoodsImg(po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsServiceImpl.java
	 * - 작성일	: 2021. 1. 21.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 복사
	 * </pre>
	 *
	 * @param so
	 * @return descGoodsId
	 */
	@Override
	@Transactional
	public String copyGoods (GoodsBaseSO so) {

		GoodsPO goodsPO = new GoodsPO();
		GoodsBasePO goodsBasePO = null;

		// 복사대상 Goods Id
		String orgGoodsId = so.getGoodsId();

		// Bean 복사를 위한 처리
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		// 상품 기본
		GoodsBaseVO goodsBaseVO = goodsDao.getGoodsDetail(so.getGoodsId());

		// 상품과 사이트 정보 매핑
		List<StGoodsMapPO> stGoodsMapPOList = goodsDao.listStGoodsMap(orgGoodsId);
		goodsPO.setStGoodsMapPOList(stGoodsMapPOList);

		try {
			goodsBasePO = new GoodsBasePO();
			BeanUtils.copyProperties(goodsBasePO, goodsBaseVO);

			goodsBasePO.setGoodsId(null );
			goodsBasePO.setCisNo(null);
			goodsBasePO.setStId(so.getStId());

			//복사 대상 상품 ID FST_GOODS_ID 그대로 들고온다
			//복사시 첫 상품 아이디가 없을 경우, 현재 상품 ID를 받아온다.
			goodsBasePO.setFstGoodsId(StringUtils.isNotEmpty(goodsBaseVO.getFstGoodsId())? goodsBaseVO.getFstGoodsId() : so.getGoodsId());
			//상품 상태 대기로 변경
			goodsBasePO.setGoodsStatCd(CommonConstants.GOODS_STAT_10);
			//샵링커 연동 안함
			goodsBasePO.setShoplinkerSndYn(CommonConstants.COMM_YN_N);
			//TWC 연동 안함
			goodsBasePO.setTwcSndYn(CommonConstants.COMM_YN_N);
			goodsBaseVO.setStId(Long.toString(so.getStId()));
			//상품명 세팅
			goodsBasePO.setGoodsNm(so.getGoodsNm());
			//상품 비고
			goodsBasePO.setBigo(so.getBigo() );
			//상품 미노출
			goodsBasePO.setShowYn(CommonConstants.COMM_YN_N);
			//등록자 처리
			goodsBasePO.setSysRegrNo(null);
			goodsPO.setGoodsBasePO(goodsBasePO);

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 상품 가격
		GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(orgGoodsId);
		if(goodsPriceVO != null) {
			try {
				GoodsPricePO goodsPricePO = new GoodsPricePO();
				BeanUtils.copyProperties(goodsPricePO, goodsPriceVO);
				goodsPricePO.setStId(so.getStId());
				goodsPO.setGoodsPricePO(goodsPricePO);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 네이버 EP 정보
		GoodsNaverEpInfoVO goodsNaverEpInfoVO = goodsNaverEpInfoService.getGoodsNaverEpInfo(orgGoodsId);
		if(goodsNaverEpInfoVO != null) {
			try {
				GoodsNaverEpInfoPO goodsNaverEpInfoPO = new GoodsNaverEpInfoPO();
				BeanUtils.copyProperties(goodsNaverEpInfoPO, goodsNaverEpInfoVO);
				goodsPO.setGoodsNaverEpInfoPO(goodsNaverEpInfoPO);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 단품
		List<ItemVO> itemVOList = itemDao.listGoodsItem(orgGoodsId );
		if(itemVOList.size() > 0) {
			try {
				List<ItemSO> itemSOList = new ArrayList();
				goodsPO.getGoodsBasePO().setItemNo(null);
				for(ItemVO itemVO : itemVOList) {
					ItemSO itemSO = new ItemSO();

					BeanUtils.copyProperties(itemSO, itemVO);
					itemSO.setWebStkQty(0L);
					itemSO.setGoodsId(null);
					itemSO.setItemNo(null);
					itemSOList.add(itemSO);
				}
				goodsPO.setItemSOList(itemSOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 단품 옵션 조회
		List<AttributeVO> attributeVOList = itemService.listGoodsAttribute(orgGoodsId);
		if(attributeVOList.size() > 0) {
			try {
				List<AttributeSO> attributeSOList = new ArrayList();
				for(AttributeVO attributeVO : attributeVOList) {
					AttributeSO attributeSO = new AttributeSO();

					BeanUtils.copyProperties(attributeSO, attributeVO);

					JSONObject jsonVar = new JSONObject();
					jsonVar.put("attrNo",attributeVO.getAttrNo());
					jsonVar.put("attrNm",attributeVO.getAttrNm());
					jsonVar.put("attrValNo",attributeVO.getAttrValNo());
					jsonVar.put("attrVal",attributeVO.getAttrVal());
					jsonVar.put("useYn",attributeVO.getUseYn());

					JSONArray jsonArray = new JSONArray();
					jsonArray.add(jsonVar);
					//String attrValJson = "[{attrNo:"+ attributeVO.getAttrNo() + ", attrValNo : "+attributeVO.getAttrVal()+"'}]";
					String attrValJson = jsonArray.toString();

					attributeSO.setAttrValJson(attrValJson);
					attributeSOList.add(attributeSO);
				}
				goodsPO.setAttributeSOList(attributeSOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 설명 정보
		List<GoodsDescVO> goodsDescVOList = goodsDescDao.listGoodsDesc(orgGoodsId );
		if(goodsDescVOList.size() > 0) {
			try {
				List<GoodsDescPO> goodsDescPOList = new ArrayList();
				for(GoodsDescVO goodsDescVO : goodsDescVOList) {
					GoodsDescPO goodsDescPO = new GoodsDescPO();

					BeanUtils.copyProperties(goodsDescPO, goodsDescVO);
					goodsDescPOList.add(goodsDescPO);
				}
				goodsPO.setGoodsDescPOList(goodsDescPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 주의사항
		GoodsCautionVO goodsCautionVO = goodsCautionService.getGoodsCaution(orgGoodsId );
		if(goodsCautionVO != null) {
			try {
				GoodsCautionPO goodsCautionPO = new GoodsCautionPO();
				BeanUtils.copyProperties(goodsCautionPO, goodsCautionVO);
				goodsPO.setGoodsCautionPO(goodsCautionPO );
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 고시 정보 (공정위 품목군)
		List<GoodsNotifyVO> goodsNotifyVOList = goodsNotifyDao.listGoodsNotify(orgGoodsId );
		if(goodsNotifyVOList.size() > 0) {
			try {
				List<GoodsNotifyPO> goodsNotifyPOList = new ArrayList();
				for(GoodsNotifyVO goodsNotifyVO : goodsNotifyVOList) {
					GoodsNotifyPO goodsNotifyPO = new GoodsNotifyPO();

					BeanUtils.copyProperties(goodsNotifyPO, goodsNotifyVO);
					goodsNotifyPOList.add(goodsNotifyPO);
				}
				goodsPO.setGoodsNotifyPOList(goodsNotifyPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 전시 카테고리 정보
		List<DisplayGoodsVO> displayGoodsVOList = goodsDao.listGoodsDispCtg(orgGoodsId );
		if(displayGoodsVOList.size() > 0) {
			try {
				List<DisplayGoodsPO> displayGoodsPOList = new ArrayList();
				for(DisplayGoodsVO displayGoodsVO : displayGoodsVOList) {
					DisplayGoodsPO displayGoodsPO = new DisplayGoodsPO();

					BeanUtils.copyProperties(displayGoodsPO, displayGoodsVO);
					displayGoodsPOList.add(displayGoodsPO);
				}
				goodsPO.setDisplayGoodsPOList(displayGoodsPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 아이콘
		List<GoodsIconVO> goodsIconList = goodsIconService.listGoodsIcon(orgGoodsId);
		if(goodsIconList.size() > 0) {
			try {
				List<GoodsIconPO> goodsIconPOList = new ArrayList();
				for(GoodsIconVO goodsIconVO : goodsIconList) {
					GoodsIconPO goodsIconPO = new GoodsIconPO();

					BeanUtils.copyProperties(goodsIconPO, goodsIconVO);
					goodsIconPOList.add(goodsIconPO);
				}
				goodsPO.setGoodsIconPOList(goodsIconPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 필터 속성 매핑
		FiltAttrMapPO filtAttrMapPO = new FiltAttrMapPO();
		filtAttrMapPO.setGoodsId(orgGoodsId);
		filtAttrMapPO.setCopyYn(CommonConstants.COMM_YN_Y);
		List<FiltAttrMapVO> filtAttrMapVOList = filtAttrMapDao.listFiltAttrMap(filtAttrMapPO);
		if(filtAttrMapVOList.size() > 0) {
			try {
				List<FiltAttrMapPO> filtAttrMapPOList = new ArrayList();
				for(FiltAttrMapVO filtAttrMapVO : filtAttrMapVOList) {
					FiltAttrMapPO po = new FiltAttrMapPO();
					BeanUtils.copyProperties(po, filtAttrMapVO);
					filtAttrMapPOList.add(po);
				}
				goodsPO.setFiltAttrMapPOList(filtAttrMapPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 태그 매핑
		List<GoodsTagMapVO> goodsTagMapList = goodsTagMapService.listGoodsTagMap(orgGoodsId);
		if(goodsTagMapList.size() > 0) {
			try {
				List<GoodsTagMapPO> goodsTagMapPOList = new ArrayList();
				for(GoodsTagMapVO goodsTagMapVO : goodsTagMapList) {
					GoodsTagMapPO goodsTagMapPO = new GoodsTagMapPO();

					BeanUtils.copyProperties(goodsTagMapPO, goodsTagMapVO);
					goodsTagMapPOList.add(goodsTagMapPO);
				}
				goodsPO.setGoodsTagMapPOList(goodsTagMapPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 연관 상품
		GoodsCstrtInfoSO goodsCstrtInfoSO = new GoodsCstrtInfoSO();
		goodsCstrtInfoSO.setGoodsId(orgGoodsId);
		goodsCstrtInfoSO.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20);
		List<GoodsCstrtInfoVO> goodsCstrtInfoList = listGoodsCstrtInfo(goodsCstrtInfoSO);
		if(goodsCstrtInfoList.size() > 0) {
			try {
				List<GoodsCstrtInfoPO> goodsCstrtInfoPOList = new ArrayList();
				for(GoodsCstrtInfoVO goodsCstrtInfoVO : goodsCstrtInfoList) {
					GoodsCstrtInfoPO goodsCstrtInfoPO = new GoodsCstrtInfoPO();

					BeanUtils.copyProperties(goodsCstrtInfoPO, goodsCstrtInfoVO);
					goodsCstrtInfoPOList.add(goodsCstrtInfoPO);
				}
				goodsPO.setGoodsCstrtInfoPOList(goodsCstrtInfoPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 상품 이미지 처리
		List<GoodsImgVO> goodsImgVOList = listGoodsImg(orgGoodsId);
		if(goodsImgVOList.size() > 0) {
			try {
				List<GoodsImgPO> goodsImgPOList = new ArrayList();
				for(GoodsImgVO goodsImgVO : goodsImgVOList) {
					if(StringUtil.isNotEmpty(goodsImgVO.getGoodsId())) {
						GoodsImgPO goodsImgPO = new GoodsImgPO();

						BeanUtils.copyProperties(goodsImgPO, goodsImgVO);
						String orgFileStr = goodsImgPO.getImgPath();
						goodsImgPO.setImgPath(bizConfig.getProperty("common.nas.base") + File.separator +  bizConfig.getProperty("common.nas.base.image") + orgFileStr);
						goodsImgPOList.add(goodsImgPO);
					}
				}
				goodsPO.setGoodsImgPOList(goodsImgPOList);
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		//CIS 연동 안함
		GoodsBaseVO descGoodsBaseVO = insertGoods (goodsPO, null, false);
		String descGoodsId = descGoodsBaseVO.getGoodsId();

		if(CollectionUtils.isNotEmpty(goodsPO.getGoodsImgPOList())) {

			FtpImgUtil ftpImgUtil = new FtpImgUtil();

			for(GoodsImgPO po : goodsPO.getGoodsImgPOList() ) {
				po.setGoodsId(descGoodsId);

				String orgImgPath = null;
				String realImgPath = null;
				String orgRvsImgPath = null;
				String realRvsImgPath = null;
				String realPath = null;

				try {

					// 정 이미지
					if(!StringUtil.isEmpty(po.getImgPath()) ) {
						orgImgPath = po.getImgPath().replaceAll(descGoodsId,orgGoodsId);
						realImgPath = po.getImgPath();
						boolean flag = ftpImgUtil.goodsImgCopy(orgImgPath, realImgPath, !StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL));	// 원본 이미지 FTP 복사
					}

					// 역 이미지
					if(!StringUtil.isEmpty(po.getRvsImgPath()) ) {
						orgRvsImgPath = po.getRvsImgPath().replaceAll(descGoodsId,orgGoodsId);
						realRvsImgPath = po.getRvsImgPath();
						boolean flag = ftpImgUtil.goodsImgCopy(orgRvsImgPath, realRvsImgPath, !StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL));	// 원본 이미지 FTP 복사
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
			}
		}

		return descGoodsId ;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsServiceImpl.java
	 * - 작성일	: 2021. 3. 2.
	 * - 작성자 	: valfac
	 * - 설명 	: 후기 복사
	 * </pre>
	 *
	 * @param so
	 * @return descGoodsId
	 */
	@Override
	public int copyGoodsComment (GoodsBaseSO so) {
		//FIXME[상품, 이하정, 20210302] 상품 후기 복사 작업중
		//해당 상품의 모든 후기를 복사한다.
		//단품 - goods_id, 세트, 옵션 테이블 - 매핑 id 모두 등록
		//링크 테이블 등록

		GoodsBasePO goodsBasePO = new GoodsBasePO();

		goodsBasePO.setFstGoodsId(so.getFstGoodsId());
		goodsBasePO.setGoodsId(so.getGoodsId());

		return goodsCommentDao.copyGoodsComment(goodsBasePO);
	}

	@Override
	public String insertGoodsSet(GoodsPO goodsPO) {

		GoodsBasePO goodsBasePO = goodsPO.getGoodsBasePO();
		String goodsId = null;
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		if(goodsBasePO != null){
			goodsBasePO.setSaleStrtDtm(DateUtil.getTimestamp()); // 시작 일자
			goodsBasePO.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT)); // 종료일자

			// 마스터 상품 기본 등록
			goodsBaseDao.insertGoodsBase(goodsBasePO);
			goodsId = goodsBasePO.getGoodsId();

			// 이력등록 추가
			GoodsBaseHistPO goodsHistPo = new GoodsBaseHistPO();
			try {
				BeanUtils.copyProperties(goodsHistPo, goodsBasePO );
				goodsDao.insertGoodsBaseHist(goodsHistPo );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			if(log.isDebugEnabled() ) {
				log.debug("goodsId === {}", goodsId);
			}
		}else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 상품 가격정보 등록
		GoodsPricePO goodsPricePO = goodsPO.getGoodsPricePO();

		if(goodsPricePO != null ) {
			goodsPricePO.setGoodsId(goodsId );
			goodsPricePO.setSaleStrtDtm(DateUtil.getTimestamp() );
			goodsPricePO.setGoodsAmtTpCd(AdminConstants.GOODS_AMT_TP_10 );
			goodsPricePO.setOrgSaleAmt(goodsPricePO.getSaleAmt() );	 // 원가
			goodsPricePO.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT) ); // 9999-12-31 23:59:59
			goodsPriceDao.insertGoodsPrice(goodsPricePO);
		}

		// 사이트상품매핑  hjko
		/*
		List<StGoodsMapPO> stGoodsMapPOList = goodsPO.getStGoodsMapPOList();

		for(StGoodsMapPO stGoodsMap : stGoodsMapPOList){
			stGoodsMap.setGoodsId(goodsBasePO.getGoodsId());
			this.insertStGoodsMap(stGoodsMap);
		}
		*/
		
		if(goodsPricePO != null) {
			// 사이트상품 매핑 정보 등록(상품 수수료, 공급가 등)
			List<StGoodsMapPO> stGoodsListParam = goodsPO.getStGoodsMapPOList();
			
			StGoodsMapSO so = new StGoodsMapSO();
			so.setCompNo(goodsBasePO.getCompNo());
			Long saleAmt = goodsPricePO.getSaleAmt();
			
			List<StStdInfoVO> listCompCmsRate = this.listCompCmsRate(so);
			for (StStdInfoVO vo : listCompCmsRate){
				StGoodsMapPO po = new StGoodsMapPO();
				
				po.setGoodsId(goodsBasePO.getGoodsId());
				po.setStId(vo.getStId());
				po.setCmsRate( vo.getCmsRate() );
				if(goodsPricePO != null ) {
					po.setSaleAmt(goodsPricePO.getSaleAmt());
				} else {
					throw new CustomException(ExceptionConstants.ERROR_GOODS_PRICE_ILLEGAL_STATE);
				}
				
				Long splAmt = saleAmt - (long) (Math.floor(saleAmt * po.getCmsRate() / 100 / 10) * 10);
				po.setSplAmt(splAmt);
				
				if (! validateSplAmtCmsRate(po.getSplAmt(), po.getCmsRate())) {
					log.error("GoodsServiceImpl.insertGoodsSet : {}", po);
					throw new CustomException(ExceptionConstants.ERROR_GOODS_SPL_AMT_CMS_RATE_ILLEGAL);
				}
				
				//Long splAmt = Math.round((saleAmt - (saleAmt * vo.getCmsRate() / 100))/10)*10;
				//po.setSplAmt(splAmt);
				
				po.setGoodsStyleCd(getGoodsStyleCdParam(po, stGoodsListParam));
				
				this.insertStGoodsMap(po);
			}
			
		}

		// 연관 상품 등록
		List<GoodsCstrtInfoPO> goodsCstrtInfoPO = goodsPO.getGoodsCstrtInfoPOList();

		if(goodsCstrtInfoPO != null && !goodsCstrtInfoPO.isEmpty()) {
			for(GoodsCstrtInfoPO goodsCstrtInfoPOList : goodsCstrtInfoPO) {

				goodsCstrtInfoPOList.setGoodsId(goodsId);
				
				//sonarqube 처리
				goodsCstrtInfoPOList.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				/*
				if (AdminConstants.GOODS_TP_10.equals(goodsBasePO.getGoodsTpCd()) ) {			// 일반상품
					goodsCstrtInfoPOList.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				} else if (AdminConstants.GOODS_TP_20.equals(goodsBasePO.getGoodsTpCd()) ) {	// 상품 유형 : Deal 상품
					goodsCstrtInfoPOList.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_10 );	// 상품 유형 : Deal 상품
				} else {
					goodsCstrtInfoPOList.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				}
				*/
				goodsDao.insertGoodsCstrtInfo(goodsCstrtInfoPOList);
				if(log.isDebugEnabled() ) {
					log.debug(" goodsCstrtInfoPOList === {}", goodsCstrtInfoPOList );
				}
			}
		}

		// 상품 이미지 처리
		List<GoodsImgPO> goodsImgPOList = null;
		goodsImgPOList = goodsPO.getGoodsImgPOList();
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		if(goodsImgPOList != null && !goodsImgPOList.isEmpty()) {
			for(GoodsImgPO po : goodsImgPOList ) {
				po.setGoodsId(goodsId );

				String realImgPath = null;
				String realRvsImgPath = null;
				String realPath = null;

				try {

					// 정 이미지
					if(!StringUtil.isEmpty(po.getImgPath()) ) {
						realImgPath = ImagePathUtil.makeGoodsImagePath (po.getImgPath(), goodsId, po.getImgSeq(), false );
						FileUtil.fileCopy(po.getImgPath(), realImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
						FileUtil.delete(po.getImgPath()); // temp 이미지 삭제
						realPath = ftpImgUtil.goodsImgUpload(realImgPath );	// 원본 이미지 FTP 복사
//						goodsImgResize(realImgPath);	// 이미지 리사이징.
						po.setImgPath(realPath);
						FileUtil.delete(realImgPath);	// 복사된 이미지 삭제.. [temp]
					}

					// 역 이미지
//					if(!StringUtil.isEmpty(po.getRvsImgPath()) ) {
//						realRvsImgPath = ImagePathUtil.makeGoodsImagePath (po.getRvsImgPath(), goodsId, po.getImgSeq(), true );
//						FileUtil.fileCopy(po.getRvsImgPath(), realRvsImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
//						FileUtil.delete(po.getRvsImgPath()); // temp 이미지 삭제
//						realPath = ftpImgUtil.goodsImgUpload(realRvsImgPath );	// 원본 이미지 FTP 복사
////						goodsImgResize(realRvsImgPath);	// 이미지 리사이징.
//						po.setRvsImgPath(realPath);
//						FileUtil.delete(realRvsImgPath);	// 복사된 이미지 삭제.. [temp]
//					}

					if (!StringUtil.isEmpty(po.getImgPath()) || !StringUtil.isEmpty(po.getRvsImgPath())) {
						FileUtil.delete(new File(StringUtils.isEmpty(realImgPath) ? realRvsImgPath : realImgPath).getParent());
					}

				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}

				// 이미지 등록
				insertGoodsImg(po);

				// 이력 등록
				GoodsImgChgHistPO goodsImgChgHistPO = new GoodsImgChgHistPO ();
				try {
					BeanUtils.copyProperties(goodsImgChgHistPO, po);
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
				insertGoodsImgChgHist(goodsImgChgHistPO);

			}
		}
		return goodsId;
	}

	@Override
	public String updateGoodsCstrtInfo(GoodsPO goodsPO) {

		if(log.isDebugEnabled() ) {
			log.debug("goodsPO ===== {} ", goodsPO);
		}

		GoodsBasePO goodsBasePO = goodsPO.getGoodsBasePO(); // null
		String goodsId = null;
		BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );

		if(goodsBasePO != null){
			goodsId = goodsBasePO.getGoodsId();

			//마스터 상품 수정
			goodsDao.updateGoodsBase(goodsBasePO);

			if(log.isDebugEnabled() ) {
				log.debug("goodsId === {}", goodsId );
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트상품매핑  hjko
		/*
		List<StGoodsMapPO> stGoodsMapPOList = goodsPO.getStGoodsMapPOList();

		Long stIds[] = new Long[stGoodsMapPOList.size()];
		StGoodsMapSO stGoodsMapSO = new StGoodsMapSO();

		for (int i=0; i < stGoodsMapPOList.size(); i++){
			StGoodsMapPO s = new StGoodsMapPO();
			s = stGoodsMapPOList.get(i) ;
			stIds[i] = s.getStId();
		}
		// 2017.2.1, 이성용, 상품에 매핑한 사이트 정보를 모두 삭제 후 재등록한다.
		//stGoodsMapSO.setStIds(stIds);
		stGoodsMapSO.setGoodsId(goodsBasePO.getGoodsId());
		this.deleteStGoodsMap(stGoodsMapSO);

		for(StGoodsMapPO stGoodsMapPO : stGoodsMapPOList){
			stGoodsMapPO.setGoodsId(goodsBasePO.getGoodsId());
			this.insertStGoodsMap(stGoodsMapPO);
		}
		*/


		// 사이트상품매핑  파라미터
		List<StGoodsMapPO> stGoodsMapPOList = goodsPO.getStGoodsMapPOList();

		// 사이트상품 매핑 정보 조회
		StGoodsMapSO smso = new StGoodsMapSO();
		smso.setGoodsId(goodsBasePO.getGoodsId());
		smso.setGetAll(CommonConstants.COMM_YN_Y);

		List<StGoodsMapVO> siteGdList = this.listStStdInfoGoods(smso);

		// 사이트상품 매핑 정보 수정
		for (int idx = 0; idx < siteGdList.size(); idx++) {
			StGoodsMapVO stGoodsVO = siteGdList.get(idx);

			// 파라미터의 사이트 정보가 DB에 등록된 사이트정보에  있으면 업데이트, 없으면 삭제한다.
			if (existsStGoods(stGoodsVO, stGoodsMapPOList)) {
				StGoodsMapPO stGoodsPO = new StGoodsMapPO();
				stGoodsPO.setGoodsId(stGoodsVO.getGoodsId());
				stGoodsPO.setStId(stGoodsVO.getStId());
				// goodsStyleCd만 업데이트된다. goodsStyleCd 값은 똑같으므로 파라미터 리스트의 첫번째 값을 사용함.
				// 수수료, 공급가는 전용 업데이트 URL 이 있음.^^
				stGoodsPO.setGoodsStyleCd(getGoodsStyleCdParam(stGoodsPO, stGoodsMapPOList));

				goodsDao.updateStGoodsMap(stGoodsPO);
			} else {
				smso.setGoodsId(stGoodsVO.getGoodsId());
				smso.setStId(stGoodsVO.getStId());

				this.deleteStGoodsMap(smso);
			}
		}

		//구성 상품 수정
		List<GoodsCstrtInfoPO> goodsCstrtInfoPOList = goodsPO.getGoodsCstrtInfoPOList();

		if(goodsCstrtInfoPOList != null && !goodsCstrtInfoPOList.isEmpty()) {
			goodsCstrtDao.deleteGoodsCstrtInfo(goodsId); //구성 상품 삭제

			for(GoodsCstrtInfoPO goodsCstrtInfoPO : goodsCstrtInfoPOList ) {
				goodsCstrtInfoPO.setGoodsId(goodsId);
				
				//sonarqube 처리
				goodsCstrtInfoPO.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				/*
				if (AdminConstants.GOODS_TP_10.equals(goodsBasePO.getGoodsTpCd()) ) {			// 일반상품
					goodsCstrtInfoPO.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				} else if (AdminConstants.GOODS_TP_20.equals(goodsBasePO.getGoodsTpCd()) ) {	// 상품 유형 : Deal 상품
					goodsCstrtInfoPO.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_10 );	// 상품 유형 : Deal 상품
				} else {
					goodsCstrtInfoPO.setGoodsCstrtGbCd(AdminConstants.GOODS_CSTRT_GB_20 );	// 연관 상품
				}
				*/
				
				goodsDao.insertGoodsCstrtInfo(goodsCstrtInfoPO);

				if(log.isDebugEnabled() ) {
					log.debug(" goodsCstrtInfoPOList === {}", goodsCstrtInfoPO);
				}

			}// for문 End
		}else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 상품 이미지 처리.
		List<GoodsImgPO> goodsImgPOList = null;
		goodsImgPOList = goodsPO.getGoodsImgPOList();
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		if(goodsImgPOList != null && !goodsImgPOList.isEmpty()) {
			for(GoodsImgPO po : goodsImgPOList ) {
				po.setGoodsId(goodsId );

				String realImgPath = null;
				String realRvsImgPath = null;
				String realPath = null;

				try {

					// 정 이미지
					if(!StringUtil.isEmpty(po.getImgPath()) ) {
						realImgPath = ImagePathUtil.makeGoodsImagePath (po.getImgPath(), goodsId, po.getImgSeq(), false );
						FileUtil.fileCopy(po.getImgPath(), realImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
						FileUtil.delete(po.getImgPath()); // temp 이미지 삭제
						realPath = ftpImgUtil.goodsImgUpload(realImgPath );	// 원본 이미지 FTP 복사
//						goodsImgResize(realImgPath );	// 이미지 리사이징.
						po.setImgPath(realPath );
						FileUtil.delete(realImgPath );	// 복사된 이미지 삭제.. [temp]
					}

					// 역 이미지
//					if(!StringUtil.isEmpty(po.getRvsImgPath()) ) {
//						realRvsImgPath = ImagePathUtil.makeGoodsImagePath (po.getRvsImgPath(), goodsId, po.getImgSeq(), true );
//						FileUtil.fileCopy(po.getRvsImgPath(), realRvsImgPath );	// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
//						FileUtil.delete(po.getRvsImgPath()); // temp 이미지 삭제
//						realPath = ftpImgUtil.goodsImgUpload(realRvsImgPath );	// 원본 이미지 FTP 복사
////						goodsImgResize(realRvsImgPath );	// 이미지 리사이징.
//						po.setRvsImgPath(realPath );
//						FileUtil.delete(realRvsImgPath );	// 복사된 이미지 삭제.. [temp]
//					}

					if (!StringUtil.isEmpty(po.getImgPath()) || !StringUtil.isEmpty(po.getRvsImgPath())) {
						FileUtil.delete(new File(StringUtils.isEmpty(realImgPath) ? realRvsImgPath : realImgPath).getParent());
					}

				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}

				// 이미지 등록
				insertGoodsImg(po );

				// 이력 등록
				GoodsImgChgHistPO goodsImgChgHistPO = new GoodsImgChgHistPO ();
				try {
					BeanUtils.copyProperties(goodsImgChgHistPO, po );
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
				insertGoodsImgChgHist(goodsImgChgHistPO );

			}
		}
		return goodsId;
	}

	@Override
	public void deleteSetGoods(GoodsPO goodsPO) {

		if(log.isDebugEnabled() ) {
			log.debug("goodsPO ===== {} ", goodsPO);
		}

		List<GoodsCstrtInfoPO> goodsCstrtInfoPO = goodsPO.getGoodsCstrtInfoPOList();

//		GoodsPriceSO goodsPriceSO = new GoodsPriceSO();

		if(goodsCstrtInfoPO != null && !goodsCstrtInfoPO.isEmpty()) {

			for(GoodsCstrtInfoPO getGoodsCstrtInfo: goodsCstrtInfoPO){

				// 구성 상품 삭제
				goodsCstrtDao.deleteGoodsCstrtInfo(getGoodsCstrtInfo.getGoodsId());

				// 상품 가격 삭제/ hjko 주석처리
				/*goodsPriceSO.setGoodsId(getGoodsCstrtInfo.getGoodsId());
				goodsPriceDao.deleteGoodsPriceHistory(goodsPriceSO);*/
				GoodsPricePO fpo = new GoodsPricePO();
				fpo.setGoodsId(getGoodsCstrtInfo.getGoodsId());
				fpo.setDelYn(CommonConstants.COMM_YN_Y);
				goodsPriceDao.deleteGoodsPriceHistory(fpo);

				// 마스터 상품 삭제
				int result = goodsDao.deleteGoodsBase(getGoodsCstrtInfo.getGoodsId());

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

	/*
	 * 상품의 판매종료처리
	 * @see biz.app.goods.service.GoodsService#updateBatchGoodsSaleEndSoldout()
	 */
	@Override
	public void updateBatchGoodsSaleEndSoldout() {
		//판매기간이 종료된 상품 판매종료 처리
		goodsDao.updateGoodsBaseSaleEnd();

		/**************
		 * 재고가 0인경우 일시품절상태로 봐야지  판매종료 처리하면 추후 입고 시 판매중으로 다시 바꿔야 하는 번거로움이 있음
		 * 현재  Front는 재고상태에 따라 품절처리함
		 * 똬한, 현재 쿼리에 들어있는 웹재고 조건은 function형태로 바뀌어야 하나
		*******************/

//		goodsDao.updateItemSoldout();
//
//		goodsDao.updateGoodsBaseSoldout();
//
		//구성하는 상품의 판매상태에 따른 세트상품의 상태를 판매중 > 판매중지
		goodsDao.updateSetGoodsBaseSoldout();
	}

	/*
	 * 상품가격배치
	 * @see biz.app.goods.service.GoodsService#batchGoodsPriceTotal()
	 */
	@Override
	public Integer batchGoodsPriceTotal() {
		return goodsDao.batchGoodsPriceTotal();
	}


	/*
	 * 상품 인기순위 배치
	 * @see biz.app.goods.service.GoodsService#batchGoodsPopularity()
	 */
	@Override
	public void batchGoodsPopularity() {
		goodsDao.batchGoodsPopularity();

	}

	@Override
	public List<GoodsBaseHistVO> listGoodsBaseHist (GoodsBaseHistSO goodsBaseHistSO ) {
		return goodsDao.listGoodsBaseHist(goodsBaseHistSO );
	}


	@Override
	public List<GoodsPriceVO> listGoodsPriceHistory (String goodsId ) {
		return goodsPriceDao.listGoodsPriceHistory(goodsId );
	}


	@Override
	public GoodsImgVO getGoodsImage (GoodsImgSO so ) {
		return goodsImgDao.getGoodsImage(so );
	}


	@Override
	public int insertDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so ) {
		return goodsDao.insertDayGoodsPplrtTotal(so );
	}


	@Override
	public int updateDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so ) {
		return goodsDao.updateDayGoodsPplrtTotal(so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 7. 22.
	* - 작성자		: yhkim
	* - 설명		: 상품 위시리스트 여부 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	@Override
	public GoodsBaseVO getInterestYn(GoodsBaseSO so){
		return goodsDao.getInterestYn(so);
	}


	/* 조립설명서 목록
	 * @see biz.app.goods.service.GoodsService#pageAssembleList(biz.app.goods.model.GoodsBaseSO)
	 */
	@Override
	public List<GoodsBaseVO> pageAssembleList(GoodsBaseSO goodsBaseSO) {
		return goodsDao.pageAssembleList(goodsBaseSO);
	}

	/*
	 * 상품 조회 수 증가
	 * @see biz.app.goods.service.GoodsService#updateGoodsHits(java.lang.String)
	 */
	@Override
	public void updateGoodsHits(String goodsId) {
		int result = goodsDao.updateGoodsHits(goodsId);
		if(result < 1) {
			goodsDao.insertGoodsHits(goodsId);
		}
	}

	@Override
	public int getWebStkQty(ItemPO itemPO) {
		return itemDao.getWebStkQty(itemPO);
	}

	@Override
	public GoodsImgVO getGoodsMainImg(String goodsId){
		return goodsImgDao.getGoodsMainImg(goodsId);
	}

	@Override
	public List<GoodsBaseVO> pageSaleGoodsBase (GoodsBaseSO goodsBaseSO ) {
		return goodsDao.pageSaleGoodsBase(goodsBaseSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  다음 상품 가격 조회
	* </pre>
	* @param GoodsPriceSO
	* @return
	*/
	@Override
	public List<GoodsPriceVO> getNextPrice (GoodsPriceSO gpso){
		return goodsPriceDao.getNextPrice(gpso);
	}

	@Override
	public int updateSalePeriod(List<GoodsPricePO> poList){
		int updateCnt1 = 0;
		int updateCnt2 = 0;
		int updateCnt = 0;

		try {

			for(GoodsPricePO po : poList){
				updateCnt1 = this.updateSalePriceEndDtm(po);
				updateCnt2 = this.updateNextSalePriceStrtDtm(po);
				if( (updateCnt1>0) && (updateCnt2>0) && (updateCnt1==updateCnt2) ){
					updateCnt++;
				}
			}

		}catch(Exception e){
			throw new CustomException(ExceptionConstants.ERROR_UPDATE_SALE_END_DTM);
		}

		return updateCnt;
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  세일 상품 가격 적용종료일시 수정
	* </pre>
	* @param GoodsPricePO
	* @return
	*/
	@Override
	public int updateSalePriceEndDtm(GoodsPricePO po) {
		int updateCnt = 0;
		LogUtil.log(po);
		updateCnt = goodsPriceDao.updateSalePriceEndDtm(po);

		return updateCnt;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  세일 상품 가격 적용시작일시 수정
	* </pre>
	* @param GoodsPricePO
	* @return
	*/
	@Override
	public int updateNextSalePriceStrtDtm (GoodsPricePO po ) {
		int updateCnt = 0;

		LogUtil.log(po);
		updateCnt = goodsPriceDao.updateNextSalePriceStrtDtm(po);
		return updateCnt;
	}


	/*
	public List<StGoodsMapVO> listStStdInfoGoods(StGoodsMapSO so ){
		return goodsDao.listStStdInfoGoods(so );
	}
	*/
	@Override
	public List<StGoodsMapVO> listStStdInfoGoods(StGoodsMapSO so ){
		return goodsDao.listStStdInfoGoods(so );
	}
	@Override
	public Integer deleteStGoodsMap(StGoodsMapSO so){
		return goodsDao.deleteStGoodsMap(so);
	}

	public Integer insertStGoodsMap(StGoodsMapPO po){
		return goodsDao.insertStGoodsMap(po);
	}

	@Override
	public List<DisplayCategoryVO> listCompDispMapGoods(GoodsBaseSO so){
		return goodsDao.listCompDispMapGoods(so);
	}

	@Override
	public List<CompanyBrandVO> listCompanyBrand(Long compNo){
		return goodsDao.listCompanyBrand(compNo);
	}

	@Override
	public List<StGoodsMapVO> listStGoodsStyle(StGoodsMapSO so){
		return goodsDao.listStGoodsStyle(so);
	}

	@Override
	public Long getStStdAvmnRateById(GoodsBaseSO so){
		return goodsDao.getStStdAvmnRateById(so);
	}

	@Override
	public List<GoodsBaseVO> listCstrtGoods(GoodsBaseSO so){
		return goodsDao.listCstrtGoods(so);
	}
	@Override
	public List<CouponBaseVO> listDownCoupon (GoodsBaseSO so ){
		return goodsPriceDao.listDownCoupon(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hg.jeong
	* - 설명		: 상세검색용 파라메터 세팅
	* </pre>
	* @param GoodsPricePO
	* @return
	*/
	@Override
	public void setDetailSearchParam(GoodsBaseSO so){
		//상세검색조건 - 카테고리
		String category = so.getCategory();
		if(category != null && !"".equals(category)){
			String[] categorys = category.split(",");
			so.setCategorys(categorys);
		}
		//상세검색조건 - 브랜드
		String brand = so.getBrand();
		if(brand != null && !"".equals(brand)){
			String[] brands = brand.split(",");
			so.setBrands(brands);
		}
		//상세검색조건 - 스타일
		String style = so.getStyle();
		if(style != null && !"".equals(style)){
			String[] styles = style.split(",");
			so.setStyles(styles);
		}
		//상세검색조건 - 시작 금액
		String priceFrom = so.getPriceFrom();
		if(priceFrom != null && !"".equals(priceFrom)){
			so.setPriceFromInt(Integer.parseInt(priceFrom));
		}
		//상세검색조건 - 종료 금액
		String priceTo = so.getPriceTo();
		if(priceTo != null && !"".equals(priceTo)){
			so.setPriceToInt(Integer.parseInt(priceTo));
		}
	}

	@Override
	public List<ItemAttributeValueVO> getItemAttrValueList(Long itemNo) {
		return itemDao.listItemAttrValue(itemNo);
	}

	@Override
	public int insertGoodsImg(GoodsImgPO po) {
		return goodsImgDao.insertGoodsImg(po);
	}

	@Override
	public int insertGoodsImgChgHist(GoodsImgChgHistPO po) {
		return goodsImgDao.insertGoodsImgChgHist(po);
	}

	@Override
	public List<GoodsPriceVO> getGoodsPromotionPrice(GoodsBaseSO so) {

		return goodsPriceDao.getGoodsPromotionPrice(so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.goods.service
	* - 파일명      : GoodsServiceImpl.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :StGoodsMap 수정
	* </pre>
	 */
	@Override
	public int updateStGoodsMap(List<StGoodsMapPO> stGoodsMapPOList) {
		int rtn = 1 ;
		for (StGoodsMapPO stGoodsMapPO : stGoodsMapPOList){
			GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(stGoodsMapPO.getGoodsId());

			//log.debug("#stGoodsMapPO.toString()>> : " + stGoodsMapPO.toString() );
			//Long splAmt = Math.round((goodsPriceVO.getSaleAmt() - (goodsPriceVO.getSaleAmt() * stGoodsMapPO.getCmsRate() / 100)));

			Long saleAmt = goodsPriceVO.getSaleAmt();
			Long splAmt = saleAmt - (long) (Math.floor(saleAmt * stGoodsMapPO.getCmsRate() / 100 / 10) * 10);
			stGoodsMapPO.setSplAmt(splAmt);

			if (! validateSplAmtCmsRate(stGoodsMapPO.getSplAmt(), stGoodsMapPO.getCmsRate())) {
				log.error("GoodsServiceImpl.updateStGoodsMap : {}", stGoodsMapPO);
				throw new CustomException(ExceptionConstants.ERROR_GOODS_SPL_AMT_CMS_RATE_ILLEGAL);
			}

			if (goodsDao.updateStGoodsMap(stGoodsMapPO) <= 0) {
				rtn = -1;
			}
		}

		return rtn;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsListVO> pageGoodsFO(GoodsListSO so) {
		if (so.getDispClsfNo() != null) {
			List<Long> dispClsfNoList = new ArrayList<>();
			DisplayCategorySO cateSO = new DisplayCategorySO();
			cateSO.setDispClsfNo(so.getDispClsfNo());
			List<DisplayCategoryVO> cateList = displayDao.listDescendantCategory(cateSO);

			for (DisplayCategoryVO o : cateList) {
				if (o.getDispCtgLvl1() != null && !dispClsfNoList.contains(o.getDispCtgLvl1())) {
					dispClsfNoList.add(o.getDispCtgLvl1());
				}
				if (o.getDispCtgLvl2() != null && !dispClsfNoList.contains(o.getDispCtgLvl2())) {
					dispClsfNoList.add(o.getDispCtgLvl2());
				}
				if (o.getDispCtgLvl3() != null && !dispClsfNoList.contains(o.getDispCtgLvl3())) {
					dispClsfNoList.add(o.getDispCtgLvl3());
				}
			}
			so.setDispClsfNos(dispClsfNoList);
		}

		return goodsDao.pageGoodsFO(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: 상품 목록 조회 - 비정형 전시코너 번호 기준
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsListVO> pageGoodsByDispClsfCornNo(GoodsListSO so) {
		return goodsDao.pageGoodsByDispClsfCornNo(so);
	}




	@Override
	public List<StStdInfoVO> listCompCmsRate(StGoodsMapSO so ){
		return goodsDao.listCompCmsRate(so );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 셀러, 스토어, 디자이너 상단 BEST 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsListVO> listBestGoodsByComp(GoodsListSO so) {
		return goodsDao.listBestGoodsByComp(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 08. 04.
	 * - 작성자		: hjko
	 * - 설명		:  interface 상품 등록시 기존에 등록된 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
//	public GoodsBaseVO interfaceCheckGoodsExists(GoodsSO dupSO){
//		return goodsDao.interfaceCheckGoodsExists(dupSO);
//	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 08. 25.
	 * - 작성자		: hjko
	 * - 설명		:  interface 상품 목록 조회(wms용)
	 * </pre>
	 * @param so
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<WmsGoodsListVO> pageGoodsListInterface(WmsGoodsListSO so){
		return goodsDao.pageGoodsListInterface(so);
	}

	@Transactional(readOnly=true)
	public int getGoodsListInterfacetotalCount(WmsGoodsListSO so){
		return goodsDao.getGoodsListInterfacetotalCount(so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.goods.service
	* - 파일명      : GoodsServiceImpl.java
	* - 작성일      : 2019. 12. 17.
	* - 작성자      : valuefactory 나경준
	* - 설명      : GOODS_PRICE 공급가 및 수수료율 수정
	* </pre>
	 */
	@Override
	public Integer updateGoodsPrice(StGoodsMapPO po) {
		return goodsDao.updateGoodsPrice(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<GoodsBaseVO> pageGoodsBaseBO(GoodsBaseSO so) {
		return goodsDao.pageGoodsBaseBO(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사은품 상품 수정
	 * </pre>
	 * @param
	 * @return
	 */
	@Override
	@Transactional
	public String updateGiftGoods(GoodsPO po) {
		if (log.isDebugEnabled()) {
			log.debug("########## : " + "updateGiftGoods");
		}

		// 상품 기본 정보
		String goodsId = updateGoodsBasic(po.getGoodsBasePO(), po.getStGoodsMapPOList());

		// 상품 이미지
		List<GoodsImgPO> goodsImgPOList = po.getGoodsImgPOList();

		if (goodsImgPOList != null && !goodsImgPOList.isEmpty()) {
			// 1. 등록된 이미지 정보 조회
			List<GoodsImgVO> goodsImgListBefore = this.listGoodsImg(goodsId);
			if (goodsImgListBefore == null || goodsImgListBefore.isEmpty()) {
				insertGoodsImg(goodsId, goodsImgPOList);
			}
			else {
				GoodsImgPO imgPO = goodsImgPOList.get(0);
				imgPO.setGoodsId(goodsId);

				// 정 이미지
				if (!StringUtil.isEmpty(imgPO.getImgPath())) {
					String tempPath = bizConfig.getProperty("common.file.upload.base") + CommonConstants.TEMP_IMAGE_PATH;
					String imgPath = imgPO.getImgPath();

					ImageType imgType = ImageType.GOODS_IMAGE;
					// 새로 올린 이미지이면...
					if (imgPath.startsWith(tempPath)) {
						String realPath = goodsImgUpload(goodsId, imgPO.getImgSeq(), imgType, imgPath, false);
						imgPO.setImgPath(realPath);
					}

					goodsImgDao.updateGoodsImg(imgPO);
				}
			}
		}

		return goodsId;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 기본 정보 수정, 기본 이력 정보 등록
	 * </pre>
	 * @param goodsBasePO
	 * @param stGoodsMapPOList
	 * @return
	 */
	private String updateGoodsBasic(GoodsBasePO goodsBasePO, List<StGoodsMapPO> stGoodsMapPOList) {
		if (log.isDebugEnabled()) {
			log.debug("#################### : " + "상품 기본 수정");
		}

		if (goodsBasePO == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 1. 상품 기본 정보 수정
		goodsBaseDao.updateGoodsBase(goodsBasePO);
		String goodsId = goodsBasePO.getGoodsId();
		if (log.isDebugEnabled()) {
			log.debug("########## goodsId : {}", goodsId);
		}


		// 2. 상품 기본 이력 등록
		BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0);

		GoodsBaseHistPO goodsHistPo = new GoodsBaseHistPO();
		try {
			BeanUtils.copyProperties(goodsHistPo, goodsBasePO);
			goodsBaseDao.insertGoodsBaseHist(goodsHistPo);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}


		// 3. 사이트 상품 맵핑 정보 수정
		if (stGoodsMapPOList == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 3-1) 기존 맵핑 정보 삭제
		StGoodsMapPO stGoodsPO = new StGoodsMapPO();
		stGoodsPO.setGoodsId(goodsId);
		goodsBaseDao.deleteStGoodsMap(stGoodsPO);

		// 3-2) 사이트 상품 맵핑 정보 등록
		for (StGoodsMapPO stGoodsMap : stGoodsMapPOList) {
			stGoodsMap.setGoodsId(goodsId);
			goodsBaseDao.insertStGoodsMap(stGoodsMap);
		}

		return goodsId;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 이미지 등록
	 * </pre>
	 * @param goodsId
	 * @param goodsImgPOList
	 * @return
	 */
	private void insertGoodsImg(String goodsId, List<GoodsImgPO> goodsImgPOList) {
		if (goodsImgPOList == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if (log.isDebugEnabled()) {
			log.debug("#################### : " + "상품 이미지 등록");
		}

		for (GoodsImgPO po : goodsImgPOList) {
			po.setGoodsId(goodsId);

			String realPath = "";
			try {
				// 정 이미지
				if (!StringUtil.isEmpty(po.getImgPath())) {
					ImageType imgType = ImageType.GOODS_IMAGE;
//					TODO 수정 필요.
					if (po.getImgTpCd().equals(CommonConstants.IMG_TP_20) || po.getImgTpCd().equals(CommonConstants.IMG_TP_30)) {	// 360도 이미지
						imgType = ImageType.GOODS_SLIDE_IMAGE;
					}

					realPath = goodsImgUpload(goodsId, po.getImgSeq(), imgType, po.getImgPath(), false);
					po.setImgPath(realPath);
				}

				if (StringUtil.isEmpty(po.getDlgtYn())) {
					po.setDlgtYn("N");
				}

			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			goodsImgDao.insertGoodsImg(po);
		}

	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 이미지 업로드
	 * </pre>
	 * @param goodsId
	 * @param imgSeq
	 * @param imgType
	 * @param imgPath
	 * @param rvsYn
	 * @return
	 */
	@Override
	public String goodsImgUpload(String goodsId, Integer imgSeq, ImageType imgType, String imgPath, boolean rvsYn) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		String realImgPath = "";
		String realPath = "";

		try {
			realImgPath = ImagePathUtil.makeGoodsImagePath(imgPath, goodsId, imgSeq, rvsYn);
			FileUtil.fileCopy(imgPath, realImgPath);				// temp 디렉토리에서 상품 이미지 포멧에 맞추어 복사.
			FileUtil.delete(imgPath);								// temp 이미지 삭제
			realPath = ftpImgUtil.goodsImgUpload(realImgPath);		// 원본 이미지 FTP 복사

			// 이미지 리사이징
//			goodsImgResize(realImgPath, imgType);
			FileUtil.delete(realImgPath);							// 복사된 이미지 삭제.. [temp]
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return realPath;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsServiceImpl.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 이미지 리사이징
	 * </pre>
	 * @param imgPath
	 * @param imgType
	 * @return
	 */
	private boolean goodsImgResize(String imgPath, ImageType imgType) {
		ImageInfoData imgInfo = new ImageInfoData();
		imgInfo.setImageType(imgType);
		imgInfo.setOrgImgPath(imgPath);
		ImageHandler handler = new ImageHandler(bizConfig);
		boolean isSucess = handler.ftpJob(imgInfo);
		log.debug("##main## (goodsImgResize, 이미지 리사이징) isSucess=" + isSucess);

		return isSucess;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 2. 8.
	* - 작성자 	: valfac
	* - 설명 		: 상품 컨텐츠 리스트
	* </pre>
	*
	* @param apetContentsGoodsMapSO
	* @return
	*/
	@Override
	public List<ApetContentsGoodsMapVO> listApetContentsGoodsMap(ApetContentsGoodsMapSO apetContentsGoodsMapSO) {

		apetContentsGoodsMapSO.setDispYn(CommonConstants.COMM_YN_Y);	
		apetContentsGoodsMapSO.setVdGbCd(CommonConstants.VD_GB_20);	
		apetContentsGoodsMapSO.setContsTpCd(CommonConstants.CONTS_TP_10);	
		
		return apetContentsGoodsMapDao.listApetContentsGoodsMap(apetContentsGoodsMapSO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsServiceImpl.java
	* - 작성일	: 2021. 2. 9.
	* - 작성자 	: valfac
	* - 설명 		: 상품 수정 가능 카운트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public GoodsBaseVO checkPossibleCnt(String goodsId) {
		return goodsDao.checkPossibleCnt(goodsId);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public MemberGradeVO getMemberGradeInfo(Long mbrNo) {
		MemberBaseSO so = new MemberBaseSO();
		if(mbrNo != null && mbrNo > 0){
			so.setMbrNo(mbrNo);
			return memberDao.getMemberGradeInfo(so);
		}
		MemberGradeVO memberVO = new MemberGradeVO();
		memberVO.setSvmnRate("0.1"); // 비로그인 상태인경우 0.1으로 고정.
		return memberVO;
	}

	@Override
	public List<GoodsBaseVO> getGoodsRelatedWithTv(GoodsRelatedSO so) throws Exception {
		List<GoodsBaseVO> goodsRelatedList = goodsDao.getGoodsRelatedWithTv(so);
		
		/*if(goodsRelatedList.size()>0) {
			String naverCloudOptimizerDomain = bizConfig.getProperty("naver.cloud.optimizer.domain");
			CodeDetailVO cdVo = cacheService.getCodeCache(CommonConstants.IMG_OPT_QRY, CommonConstants.IMG_OPT_QRY_250);
			if (!org.apache.commons.lang3.StringUtils.startsWith(cdVo.getUsrDfn1Val(), "?"))
				cdVo.setUsrDfn1Val("?" + cdVo.getUsrDfn1Val());

			for(int i=0;i<goodsRelatedList.size();i++)
				goodsRelatedList.get(i).setImgPath( naverCloudOptimizerDomain + goodsRelatedList.get(i).getImgPath() + cdVo.getUsrDfn1Val() );
		}*/

		if(goodsRelatedList == null || goodsRelatedList.isEmpty() || goodsRelatedList.size() == 0) {
			/**
			 * 등록된 연관상품 매핑이 없을때
			 */
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getVdId().toString());
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","tv-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			List<String> relatedGoodsIdList = new ArrayList<String>();
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							relatedGoodsIdList.add((String)item.get("GOODS_ID"));
						}
					}
				}
			}

			if(relatedGoodsIdList.size()>0) {
				so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
				so.setLimit(10);
				goodsRelatedList = goodsDao.getGoodsRelatedInGoods(so);
			}
		}

		return goodsRelatedList;
	}

	/**
	 * 펫로그 추천 상품
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<GoodsBaseVO> getGoodsRelatedWithPetLog(GoodsRelatedSO so) throws Exception {
		List<GoodsBaseVO> goodsRelatedList = new ArrayList<GoodsBaseVO>();

		/**
		 * 후기 여부가 Y일 경우
		 */
		if(CommonConstants.COMM_YN_Y.contentEquals(so.getRvwYn())) {
			goodsRelatedList = goodsDao.getGoodsRelatedWithPetLog(so);
			
		}else if(CommonConstants.COMM_YN_Y.contentEquals(so.getGoodsRcomYn())) {
			/**
			 * 상품추천 여부가 Y일 경우 검색 엔진 호출
			 */
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getPetLogNo().toString());
			requestParam.put("MBR_NO", so.getMbrNo().toString());
			requestParam.put("PET_NO", so.getPetNo().toString());
			requestParam.put("FROM", "1");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("SIZE", "50");
			requestParam.put("TARGET_INDEX","log-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			List<String> relatedGoodsIdList = new ArrayList<String>();
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							String goodsId = (String)item.get("GOODS_ID");
							if(goodsId != null && StringUtil.isNotEmpty(goodsId)) {
								relatedGoodsIdList.add(goodsId);
							}
						}
					}
				}
			}

			if(relatedGoodsIdList.size()>0) {
				so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
				goodsRelatedList = goodsDao.getGoodsRelatedInGoods(so);
			}
		}

		/*if(goodsRelatedList.size()>0) {
			String naverCloudOptimizerDomain = bizConfig.getProperty("naver.cloud.optimizer.domain");
			CodeDetailVO cdVo = cacheService.getCodeCache(CommonConstants.IMG_OPT_QRY, CommonConstants.IMG_OPT_QRY_250);
			if (!org.apache.commons.lang3.StringUtils.startsWith(cdVo.getUsrDfn1Val(), "?"))
				cdVo.setUsrDfn1Val("?" + cdVo.getUsrDfn1Val());

			for(int i=0;i<goodsRelatedList.size();i++)
				goodsRelatedList.get(i).setImgPath( naverCloudOptimizerDomain + goodsRelatedList.get(i).getImgPath() + cdVo.getUsrDfn1Val() );
		}*/

		return goodsRelatedList;
	}
	
	@Deprecated
	public List<GoodsBaseVO> getGoodsRelatedWithPetLogX(GoodsRelatedSO so) throws Exception {
		List<GoodsBaseVO> goodsRelatedList = new ArrayList<GoodsBaseVO>();

		PetLogBaseSO petLogBaseSo = new PetLogBaseSO();
		petLogBaseSo.setPetLogNo(so.getPetLogNo());
		PetLogBaseVO petLogBase = petLogService.getPetLogDetail(petLogBaseSo);
/*
* [오후 3:02] 이지연/기타프로젝트
     1. 후기 등록한 경우 - pet_log_base.RVW_YN = 'Y' 인경우는 pet_log_rlt_map 의 rlt_ID 가 상품코드입니다.
​[오후 3:03] 이지연/기타프로젝트

2. 검색 추천을 받는 경우 - pet_log_base.GOODS_RCOM_YN = 'Y' 인 경우 -> 검색추천
​[오후 3:04] 이지연/기타프로젝트
    정리가 됐을까요?
*/
		if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getRvwYn())) {
			goodsRelatedList = goodsDao.getGoodsRelatedWithPetLog(so);
		}else if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getGoodsRcomYn())) {
			
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String, String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getPetLogNo().toString());
			requestParam.put("MBR_NO", so.getMbrNo().toString());
			requestParam.put("PET_NO", so.getPetNo().toString());
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","log-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			List<String> relatedGoodsIdList = new ArrayList<String>();
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							relatedGoodsIdList.add((String)item.get("GOODS_ID"));
						}
					}
				}
			}

			if(relatedGoodsIdList.size()>0) {
				so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
				List<GoodsBaseVO> tmpGoodsRelatedList = goodsDao.getGoodsRelatedInGoods(so);

				if(tmpGoodsRelatedList.size()>0) {
					for(String goodsId : relatedGoodsIdList) {
						for(GoodsBaseVO goodsBaseVO : tmpGoodsRelatedList) {
							if(goodsBaseVO.getGoodsId().contentEquals(goodsId)) {
								goodsRelatedList.add(goodsBaseVO);
							}
						}
					}
				}
				//goodsRelatedList = goodsDao.getGoodsRelatedInGoods(so);
			}
		}

		if(goodsRelatedList.size()>0) {
			String naverCloudOptimizerDomain = bizConfig.getProperty("naver.cloud.optimizer.domain");
			CodeDetailVO cdVo = cacheService.getCodeCache(CommonConstants.IMG_OPT_QRY, CommonConstants.IMG_OPT_QRY_250);
			if (!org.apache.commons.lang3.StringUtils.startsWith(cdVo.getUsrDfn1Val(), "?"))
				cdVo.setUsrDfn1Val("?" + cdVo.getUsrDfn1Val());

			for(int i=0;i<goodsRelatedList.size();i++)
				goodsRelatedList.get(i).setImgPath( naverCloudOptimizerDomain + goodsRelatedList.get(i).getImgPath() + cdVo.getUsrDfn1Val() );
		}
		return goodsRelatedList;
	}

	@Override
	public int getGoodsRelatedWithTvCount(GoodsRelatedSO so) throws Exception {
		int count = goodsDao.getGoodsRelatedWithTvCount(so);

		if(count == 0) {
			/**
			 * 등록된 연관상품 매핑이 없을때
			 */
			
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getVdId().toString());
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","tv-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			List<String> relatedGoodsIdList = new ArrayList<String>();
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							String goodsId = (String)item.get("GOODS_ID");
							if(goodsId != null && StringUtil.isNotEmpty(goodsId)) {
								relatedGoodsIdList.add(goodsId);
							}
						}
					}
				}
			}

			if(relatedGoodsIdList.size()>0) {
				so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
				count = goodsDao.getGoodsRelatedInGoodsCount(so);
			}
		}

		if(count>10) count = 10;
		return count;
	}

	@Override
	@Deprecated
	public int getGoodsRelatedWithPetLogCount(GoodsRelatedSO so) throws Exception {
		int count = 0;

		PetLogBaseSO petLogBaseSo = new PetLogBaseSO();
		petLogBaseSo.setPetLogNo(so.getPetLogNo());
		PetLogBaseVO petLogBase = petLogService.getPetLogDetail(petLogBaseSo);
/*
* [오후 3:02] 이지연/기타프로젝트
     1. 후기 등록한 경우 - pet_log_base.RVW_YN = 'Y' 인경우는 pet_log_rlt_map 의 rlt_ID 가 상품코드입니다.
​[오후 3:03] 이지연/기타프로젝트

2. 검색 추천을 받는 경우 - pet_log_base.GOODS_RCOM_YN = 'Y' 인 경우 -> 검색추천
​[오후 3:04] 이지연/기타프로젝트
    정리가 됐을까요?
*/
		if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getRvwYn())) {
			count = goodsDao.getGoodsRelatedWithPetLogCount(so);
		}else if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getGoodsRcomYn())) {
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", petLogBase.getPetLogNo().toString());
			requestParam.put("MBR_NO", "0");
			requestParam.put("PET_NO", "0");
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","log-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					count = (int) dataMap.get("TOTAL");

					List<String> relatedGoodsIdList = new ArrayList<String>();
					if(count > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							relatedGoodsIdList.add((String)item.get("GOODS_ID"));
						}
					}
					if(relatedGoodsIdList.size()>0) {
						so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
						count = goodsDao.getGoodsRelatedInGoodsCount(so);
					}
				}
			}
		}
		if(count>10) count = 10;
		return count;
	}

	@Override
	public GoodsImgVO getGoodsRelatedWithTvThumb(GoodsRelatedSO so) throws Exception {
		GoodsImgVO goodsImgVO = new GoodsImgVO();
		int count = goodsDao.getGoodsRelatedWithTvCount(so);

		if(count == 0) {
			/**
			 * 등록된 연관상품 매핑이 없을때
			 */
			
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getVdId().toString());
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","tv-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

			List<String> relatedGoodsIdList = new ArrayList<String>();
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						for(Map<String, Object> item : items ) {
							String goodsId = (String)item.get("GOODS_ID");
							if(goodsId != null && StringUtil.isNotEmpty(goodsId)) {
								relatedGoodsIdList.add(goodsId);
							}
						}
					}
				}
			}

			if(relatedGoodsIdList.size()>0) {
				so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
				goodsImgVO = goodsDao.getGoodsRelatedWithPetLogThumbInGoods(so);
			}
		}else{
			goodsImgVO = goodsDao.getGoodsRelatedWithTvThumb(so);
		}
		return goodsImgVO;
	}

	@Override
	@Deprecated
	public GoodsImgVO getGoodsRelatedWithPetLogThumb(GoodsRelatedSO so) throws Exception {
		GoodsImgVO goodsImgVO = new GoodsImgVO();

		PetLogBaseSO petLogBaseSo = new PetLogBaseSO();
		petLogBaseSo.setPetLogNo(so.getPetLogNo());
		PetLogBaseVO petLogBase = petLogService.getPetLogDetail(petLogBaseSo);
/*
* [오후 3:02] 이지연/기타프로젝트
     1. 후기 등록한 경우 - pet_log_base.RVW_YN = 'Y' 인경우는 pet_log_rlt_map 의 rlt_ID 가 상품코드입니다.
​[오후 3:03] 이지연/기타프로젝트

2. 검색 추천을 받는 경우 - pet_log_base.GOODS_RCOM_YN = 'Y' 인 경우 -> 검색추천
​[오후 3:04] 이지연/기타프로젝트
    정리가 됐을까요?
*/
		if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getRvwYn())) {
			goodsImgVO = goodsDao.getGoodsRelatedWithPetLogThumb(so);
		}else if(CommonConstants.COMM_YN_Y.contentEquals(petLogBase.getGoodsRcomYn())) {
			// PC/MOBILE 구분 코드
			String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
			
			Map<String,String> requestParam = new HashMap<String,String>();
			requestParam.put("CONTENT_ID", so.getPetLogNo().toString());
			requestParam.put("MBR_NO", so.getMbrNo().toString());
			requestParam.put("PET_NO", so.getPetNo().toString());
			requestParam.put("FROM", "1");
			requestParam.put("SIZE", "50");
			requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
			requestParam.put("TARGET_INDEX","log-related");
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);


			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						List<Map<String, Object>> items = (List)dataMap.get("ITEM");
						List<String> relatedGoodsIdList = new ArrayList<String>();
						for(Map<String, Object> item : items ) {
							relatedGoodsIdList.add((String)item.get("GOODS_ID"));
							break;
						}
						if(relatedGoodsIdList.size()>0) {
							so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
							goodsImgVO = goodsDao.getGoodsRelatedWithPetLogThumbInGoods(so);
						}
					}
				}
			}
		}
		return goodsImgVO;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsServiceImpl.java
	 * - 작성일	: 2021. 3. 4.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 팝업 카테고리 선택
	 * </pre>
	 *
	 * @param dispClsfNo
	 * @return HashMap
	 */
	@Override
	public HashMap getGoodsDisplayCategory(long dispClsfNo) {
		return goodsDao.selectGoodsDisplayCategory(dispClsfNo);
	}


	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsBaseVO> getGoodsRelatedWithSearch(GoodsRelatedSO so) throws Exception {
//		List<GoodsBaseVO> goodsRelatedList = new ArrayList<GoodsBaseVO>();
		String webMobileGbCd = 
				StringUtils.equals(so.getWebMobileGbCd(), CommonConstants.DEVICE_GB_10) == true 
				? CommonConstants.WEB_MOBILE_GB_10
				: CommonConstants.WEB_MOBILE_GB_20;
		
		Map<String,String> requestParam = new HashMap<String,String>();
		requestParam.put("CONTENT_ID", so.getGoodsId());
		requestParam.put("MBR_NO", ((so.getMbrNo() != null && so.getMbrNo() > 0) ? so.getMbrNo().toString(): ""));
		requestParam.put("PET_NO", ((so.getPetNo() != null && so.getPetNo() > 0) ? so.getPetNo().toString() : ""));
		requestParam.put("FROM", String.valueOf(FrontConstants.PAGE_ROWS_1));
		requestParam.put("SIZE", String.valueOf(FrontConstants.PAGE_ROWS_12));
		requestParam.put("TARGET_INDEX","shop-related");
		requestParam.put("WEB_MOBILE_GB_CD", webMobileGbCd);
		String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);

		List<String> relatedGoodsIdList = new ArrayList<String>();
		if(res != null) {
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
			Map<String, Object> statusMap = (Map)resMap.get("STATUS");
			if( statusMap.get("CODE").equals(200) ) {
				Map<String, Object> dataMap = (Map)resMap.get("DATA");
				if( (int)dataMap.get("TOTAL") > 0 ) {
					List<Map<String, Object>> items = (List)dataMap.get("ITEM");
					for(Map<String, Object> item : items ) {
						relatedGoodsIdList.add((String)item.get("GOODS_ID"));
					}
				}
			}
		}

		if(relatedGoodsIdList.size()>0) {
			so.setLimit(10);
			so.setGoodsIds(relatedGoodsIdList.toArray(new String[0]));
			return goodsDao.getGoodsRelatedInGoods(so);
		}

		return null;
		//test
//		List<GoodsBaseVO> goodsRelatedList = new ArrayList<GoodsBaseVO>();
//		for(int i = 0; i < 2; i++){
//			GoodsBaseVO vo = new GoodsBaseVO();
//			if(i==0){
//				vo.setGoodsId("GP250479723");
//				vo.setSoldOutYn("N");
//			}else if(i==1){
//				vo.setGoodsId("GP250479722");
//				vo.setSoldOutYn("Y");
//			}
//			vo.setGoodsNm("이츠독 오가닉 누빔 조끼 묶음");
//			vo.setMmft("펫츠비");
//			vo.setImgPath("/goods/GI250479737/GI250479737_1.jpg");
//			vo.setInterestYn("N");
//			vo.setSaleAmt(10000L);
//
//			goodsRelatedList.add(vo);
//		}
//		return goodsRelatedList;
	}


	@Override
	public double getGoodsRecommendRate(GoodsRelatedSO so) throws Exception {
		String strRate = "";
		if(so.getMbrNo() != CommonConstants.NO_MEMBER_NO && StringUtils.isNotEmpty(so.getGoodsId())) {
			Map<String,String> requestParam1 = new HashMap<String,String>();
			requestParam1.put("INDEX", "SHOP"); //펫샵
			requestParam1.put("MBR_NO", String.valueOf(so.getMbrNo()));
			requestParam1.put("CONTENT_ID", String.valueOf(so.getGoodsId())); //상품번호
			String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMENDRATE, requestParam1);
			if(res != null) {
				ObjectMapper objectMapper = new ObjectMapper();
				Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
				Map<String, Object> statusMap = (Map)resMap.get("STATUS");
				if( statusMap.get("CODE").equals(200) ) {
					Map<String, Object> dataMap = (Map)resMap.get("DATA");
					if( (int)dataMap.get("TOTAL") > 0 ) {
						Map<String, Object> items = (Map)dataMap.get("ITEM");
						strRate = String.valueOf(items.get("RATE"));
					}
				}
			}
		}
		return NumberUtils.isNumber(strRate) ? Double.parseDouble(strRate) : 0;
	}

	@Override
	public List<GoodsBaseVO> getSgrGoodsList(GoodsBaseSO so) {
		so.setCdnUrl(bizConfig.getProperty("naver.cloud.optimizer.domain"));
		List<GoodsBaseVO> goodsList = goodsDao.getSgrGoodsList(so);
		return goodsList;
	}

	
	@Override
	public void petLogCmtDelete(PetLogGoodsVO vo) {
		GoodsCommentPO gcpo = new GoodsCommentPO();
		gcpo.setSysRegrNo(vo.getMbrNo());
		gcpo.setSysUpdrNo(vo.getMbrNo());
		gcpo.setGoodsEstmNo(vo.getGoodsEstmNo());
		gcpo.setOrdNo(vo.getOrdNo());
		gcpo.setOrdDtlSeq(vo.getOrdDtlSeq());
		
		goodsCommentService.deleteGoodsComment(gcpo);
		
		if(StringUtil.equals(vo.getGoodsEstmTp(), CommonConstants.GOODS_ESTM_TP_PLG)) {
			PetLogBasePO plpo = new PetLogBasePO();
			plpo.setPetLogNo(vo.getPetLogNo());
			
			petLogService.deletePetLogBase(plpo, "GoodsComment");
			petLogDao.deletePetLogTagMap(plpo );
		}

	}

	@Override
	public List<GoodsBaseVO> getGoodsRelatedInGoods(GoodsRelatedSO so) {
		return goodsDao.getGoodsRelatedInGoods(so);
	}
}