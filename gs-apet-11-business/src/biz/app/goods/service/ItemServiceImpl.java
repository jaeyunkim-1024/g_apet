package biz.app.goods.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValuePO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.dao.GoodsIoAlmDao;
import biz.app.goods.dao.ItemAttributeValueDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.GoodsAttributePO;
import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsIoAlmPO;
import biz.app.goods.model.GoodsPO;
import biz.app.goods.model.ItemAttrHistPO;
import biz.app.goods.model.ItemAttributeValuePO;
import biz.app.goods.model.ItemAttributeValueSO;
import biz.app.goods.model.ItemAttributeValueVO;
import biz.app.goods.model.ItemHistPO;
import biz.app.goods.model.ItemHistSO;
import biz.app.goods.model.ItemHistVO;
import biz.app.goods.model.ItemPO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmVO;
import biz.app.member.service.MemberIoAlarmService;
import biz.app.pay.model.PaymentException;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("itemService")
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDao itemDao;

	@Autowired
	private GoodsBaseDao goodsBaseDao;
	
	@Autowired
	private GoodsIoAlmDao goodsIoAlmDao;

	@Autowired private ItemAttributeValueDao itemAttributeValueDao;
	@Autowired private GoodsSkuService goodsSkuService;
	@Autowired private MessageSourceAccessor messageSourceAccessor;
	@Autowired private MemberIoAlarmService memberIoAlarmService;


	/*
	 * 단품의 웹재고 증 차감
	 * @see biz.app.goods.service.ItemService#updateItemWebStockQty(java.lang.String, java.lang.Long, java.lang.Integer)
	 */
	@Override
	public void updateItemWebStockQty(GoodsBaseVO goodsBase, Long itemNo, Integer applyQty) {
		/*************************************
		 * 재고 관리를 하는 경우에만 증/차감
		 *************************************/
		if(CommonConstants.COMM_YN_Y.equals(goodsBase.getStkMngYn())){

			ItemVO item = null;
			if(itemNo == 0L) {
				ItemSO iso = new ItemSO();
				iso.setGoodsId(goodsBase.getGoodsId());
				List<ItemVO> itemList = itemDao.listItem(iso);
				if(!itemList.isEmpty() && itemList.size()>0) {
					item = itemList.get(0);
				}
			}else{
				ItemSO iso = new ItemSO();
				iso.setItemNo(itemNo);
				item = this.itemDao.getItem(iso);
			}

			if(item == null) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			/*
			 * 차감시 재고가 부족한 경우
			 */
			if((applyQty.intValue() * -1) > item.getWebStkQty().intValue()){
				throw new CustomException(ExceptionConstants.ERROR_ORDER_WEB_STK_QTY);
			}

			/*
			 * 증/차감 처리
			 */
			ItemPO ipo = new ItemPO();
			ipo.setItemNo(itemNo);
			ipo.setWebStkQty(applyQty);

			int itemResult = itemDao.updateItemWebStockQty(ipo);
			/*
			if(itemResult != 1){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}*/
		}

	}

	/*
	 * 단품의 속성 및 속성값 목록 조회
	 * @see biz.app.goods.service.ItemService#listItemAttributeValue(java.lang.Long)
	 */
	@Override
	public List<ItemAttributeValueVO> listItemAttributeValue(Long itemNo) {
		ItemAttributeValueSO iavso = new ItemAttributeValueSO();
		iavso.setItemNo(itemNo);
		return this.itemAttributeValueDao.listItemAttributeValue(iavso);
	}

	/*
	 * 상품 중 특정 속성으로 구성된 단품 조회
	 * @see biz.app.goods.service.ItemService#getItem(java.lang.String, java.lang.Long[], java.lang.Long[])
	 */
	@Override
	public ItemVO getItem(String goodsId, Long[] attrNos, Long[] attrValNos) {
		ItemVO result = null;

		if(goodsId != null && !"".equals(goodsId) && attrNos != null && attrNos.length > 0 && attrValNos != null && attrValNos.length > 0){
			/******************************
			 * 상품에 대한 단품 목록 조회
			 ******************************/
			ItemSO iso = new ItemSO();
			iso.setGoodsId(goodsId);
			List<ItemVO> itemList = this.itemDao.listItem(iso);

			if(itemList != null && !itemList.isEmpty()){
				for(ItemVO item : itemList){

					if(result == null){
						/******************************
						 * 단품의 구성된 속성 목록 조회
						 ******************************/
						ItemAttributeValueSO iavso = new ItemAttributeValueSO();
						iavso.setItemNo(item.getItemNo());
						List<ItemAttributeValueVO> attributeValueList = this.itemAttributeValueDao.listItemAttributeValue(iavso);

						/***************************************************************
						 * 단품의 구성된 속성 수와 parameter의 속성수가 같은 경우에만
						 ***************************************************************/
						if(attributeValueList != null && !attributeValueList.isEmpty()
								&& attributeValueList.size() == attrNos.length){
							/************************************************
							 * 단품의 구성된 속성과 동일한 속성의 단품 조회
							 ************************************************/
							int eqCnt = 0;
							for(ItemAttributeValueVO attributeValue : attributeValueList){
								for(int i=0; i < attrNos.length; i++){
									if(attrNos[i].equals(attributeValue.getAttrNo()) && attrValNos[i].equals(attributeValue.getAttrValNo())){
										eqCnt++;
									}
								}
							}
	
							if(attributeValueList.size() == eqCnt){
								result = item;
							}


						}
					}
				}
			}else{
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		/************************************************
		 * 단품 상태가 '판매중'이 아닌경우 null 반환
		 ************************************************/
		if(result != null
			&& !CommonConstants.ITEM_STAT_10.equals(result.getItemStatCd())){
			result = null;
		}

		return result;
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//
	@Override
	public List<ItemVO> listItem(ItemSO so) {
		return itemDao.listItem(so);
	}



	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	@Override
	public List<ItemVO> pageItem (GoodsBaseSO so ) {
		return itemDao.pageItem(so );
	}


	@Override
	public List<AttributeVO> listGoodsAttribute (String goodsId ) {
		return itemDao.listGoodsAttribute(goodsId );
	}

	@Override
	public List<AttributeValueVO> listAttribute(AttributeSO so) {
		return itemDao.listAttribute(so);
	}


	@Override
	public List<ItemVO> listGoodsItem (String goodsId ) {
		return itemDao.listGoodsItem(goodsId );
	}


	@Override
	public List<ItemHistVO> listItemHist (ItemHistSO itemHistSO ) {
		return itemDao.listItemHist(itemHistSO );
	}



	@Override
	public Integer getMaxAttributeValue(AttributeSO so){
		Integer attrValNo = 0;
		attrValNo = itemDao.getMaxAttributeValue(so);
		return attrValNo;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명	: biz.app.goods.service
	* - 파일명		: ItemServiceImpl.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	*/
	@Override
	public List<ItemVO> addItem(String goodsId, List<ItemSO> itemSOList, Map<Long , List<AttributeValuePO>> sortedMapGroupAttrValList )  {

		List<ItemVO> items = new ArrayList<>();

		//log.debug("sortedMapGroupAttrValList >"+sortedMapGroupAttrValList);
		/*
		 * 759=[
		 * AttributeValuePO(attrNo=759, attrValNo=2841, attrVal=rose2, useYn=Y, attrNm=null),
		 * AttributeValuePO(attrNo=759, attrValNo=2842, attrVal=mint2, useYn=Y, attrNm=null),
		 * AttributeValuePO(attrNo=763, attrValNo=15, attrVal=M, useYn=Y, attrNm=null)]
		 * 763=[
		 * AttributeValuePO(attrNo=759, attrValNo=2841, attrVal=rose2, useYn=Y, attrNm=null),
		 * AttributeValuePO(attrNo=759, attrValNo=2842, attrVal=mint2, useYn=Y, attrNm=null),
		 * AttributeValuePO(attrNo=763, attrValNo=15, attrVal=M, useYn=Y, attrNm=null)]
		 */
		List<AttributeValuePO> attrVPOList = new ArrayList<>();

		// -----------------------------------------------------------------
		//	 attribute_value 테이블에 넣기
		// -----------------------------------------------------------------
		for (Map.Entry<Long, List<AttributeValuePO>> entry : sortedMapGroupAttrValList.entrySet()) {
			Long mapKey = entry.getKey();
			List<AttributeValuePO> sortedGrpAttV = entry.getValue();
			
			for(AttributeValuePO m : sortedGrpAttV){
				if(mapKey.equals(m.getAttrNo())){
					AttributeValuePO n = new AttributeValuePO();
					BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
					try {
						BeanUtils.copyProperties(n, m);
					} catch (Exception e) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					// 속성값 등록
					itemDao.insertAttributeValue(n);
					attrVPOList.add(n);
				}
			}
		}

		log.debug("attrVPOList >>"+attrVPOList);

		// itemSOList 에다가 각 옵션별 attr1ValNo , attr2ValNo, attr3ValNo, attr4ValNo, attr5ValNo 넣기.
		
		if(itemSOList != null && !itemSOList.isEmpty()) {
			for ( ItemSO temp : itemSOList){
				for( AttributeValuePO tempV : attrVPOList){
					if(temp.getAttr1No().equals( tempV.getAttrNo())){
						if(temp.getAttr1Val().equals(tempV.getAttrVal())){
							temp.setAttr1ValNo(tempV.getAttrValNo());
						}
					}else if(temp.getAttr2No().equals( tempV.getAttrNo() )){
						if(temp.getAttr2Val().equals(tempV.getAttrVal())){
							temp.setAttr2ValNo(tempV.getAttrValNo());
						}
					}else if(temp.getAttr3No().equals( tempV.getAttrNo() )){
						if(temp.getAttr3Val().equals(tempV.getAttrVal())){
							temp.setAttr3ValNo(tempV.getAttrValNo());
						}
					}else if(temp.getAttr4No().equals( tempV.getAttrNo()) ){
						if(temp.getAttr4Val().equals(tempV.getAttrVal())){
							temp.setAttr4ValNo(tempV.getAttrValNo());
						}
					}else if(temp.getAttr5No().equals(tempV.getAttrNo()) 
							&& temp.getAttr5Val().equals(tempV.getAttrVal())){
						temp.setAttr5ValNo(tempV.getAttrValNo());
					}
				}
			}
		}

		// -----------------------------------------------------------------
		//	 item 테이블에 넣기
		// -----------------------------------------------------------------
		Long itemNo = null;
		if(itemSOList != null && !itemSOList.isEmpty()) {

			for ( ItemSO  itso: itemSOList)
			{
				//log.debug("itso >>"+itso);
				ItemVO eachItem = new ItemVO();

				ItemPO itemPO = new ItemPO();
				BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
				try {
					BeanUtils.copyProperties(itemPO, itso );
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				itemPO.setGoodsId(goodsId );

				// 단품 등록
				itemDao.insertItem( itemPO );
				itemNo = itemPO.getItemNo();

				// ----------------------------------------------------------------
				// 결과값으로 던질 값 세팅
				// ----------------------------------------------------------------
				eachItem.setItemNo(itemNo);
				eachItem.setCompItemId(itemPO.getCompItemId());
				items.add(eachItem);
				// ----------------------------------------------------------------

				// 단품 이력등록
				ItemHistPO itemHistPo = new ItemHistPO();
				try {
					BeanUtils.copyProperties(itemHistPo, itemPO );
					itemDao.insertItemHist(itemHistPo );
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				//log.debug("attrVPOList >>>"+attrVPOList);
				// -----------------------------------------------------------------
				//	 item_attribute_value 테이블에 넣기
				// -----------------------------------------------------------------
				if(attrVPOList != null && !attrVPOList.isEmpty()) {
					for(AttributeValuePO ipo : attrVPOList ) {
						//log.debug("ipo >>" +ipo);
						ItemAttributeValuePO po = new ItemAttributeValuePO();
						if(itso.getAttr1No() != null && itso.getAttr1No().equals(ipo.getAttrNo()) && itso.getAttr1ValNo().equals(ipo.getAttrValNo())){
							try {
								BeanUtils.copyProperties(po, ipo);
							} catch (Exception e) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							po.setItemNo(itemNo );
							//log.debug(" ItemAttributeValuePO >>"+ po);
							itemDao.insertItemAttributeValue(po );

						}else if(itso.getAttr2No() != null && itso.getAttr2No().equals(ipo.getAttrNo()) && itso.getAttr2ValNo().equals(ipo.getAttrValNo())){
							try {
								BeanUtils.copyProperties(po, ipo);
							} catch (Exception e) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							po.setItemNo(itemNo );
							//log.debug(" ItemAttributeValuePO >>"+ po);
							itemDao.insertItemAttributeValue(po );
						}else if(itso.getAttr3No() != null && itso.getAttr3No().equals(ipo.getAttrNo()) && itso.getAttr3ValNo().equals(ipo.getAttrValNo())){
							try {
								BeanUtils.copyProperties(po, ipo);
							} catch (Exception e) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							po.setItemNo(itemNo );
							//log.debug(" ItemAttributeValuePO >>"+ po);
							itemDao.insertItemAttributeValue(po );
						}else if(itso.getAttr4No() != null && itso.getAttr4No().equals(ipo.getAttrNo()) && itso.getAttr4ValNo().equals(ipo.getAttrValNo())){
							try {
								BeanUtils.copyProperties(po, ipo);
							} catch (Exception e) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							po.setItemNo(itemNo );
							//log.debug(" ItemAttributeValuePO >>"+ po);
							itemDao.insertItemAttributeValue(po );
						}else if(itso.getAttr5No() !=null && itso.getAttr5No().equals(ipo.getAttrNo()) && itso.getAttr5ValNo().equals(ipo.getAttrValNo())){
							try {
								BeanUtils.copyProperties(po, ipo);
							} catch (Exception e) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
							po.setItemNo(itemNo );
							//log.debug(" ItemAttributeValuePO >>"+ po);
							itemDao.insertItemAttributeValue(po );
						}

					}

				}

				// -----------------------------------------------------------------
				//	 단품 옵션 이력 테이블에 넣기
				// -----------------------------------------------------------------
				ItemAttrHistPO itemAttrHistPO = new ItemAttrHistPO();
				try {
					BeanUtils.copyProperties(itemAttrHistPO, itso );
				}catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				itemAttrHistPO.setItemNo(itemNo );
//				itemAttrHistPO.setSysRegrNo(CommonConstants.INTERFACE_USR_NO);
//				itemAttrHistPO.setSysUpdrNo(CommonConstants.INTERFACE_USR_NO);

				itemDao.insertItemAttrHist(itemAttrHistPO );
			}
		}
		return items;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명	: biz.app.goods.service
	* - 파일명		: ItemServiceImpl.java
	* - 작성일		: 2017. 6. 16.
	* - 작성자		: hjko
	* - 설명		: 단품 수정
	* </pre>
	*/
	@Override
	public Integer updateItems(List<ItemPO> itemPOList){
		Integer updateCnt = 0;
		Integer updateResult = 0;
		if(itemPOList != null && !itemPOList.isEmpty()) {

			for ( ItemPO itemPO: itemPOList){

				// 단품 수정
				updateResult = itemDao.updateItem(itemPO);

				// 단품 이력등록
				ItemHistPO itemHistPO = new ItemHistPO();
				BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
				try {
					BeanUtils.copyProperties(itemHistPO, itemPO );
				} catch (Exception e) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				itemDao.insertItemHist(itemHistPO );
				updateCnt+= updateResult;
			}
		}
		return updateCnt;

	}

	@Override
	public AttributeVO getAttribute(AttributeSO so) {
		return itemDao.getAttribute(so);
	}

	@Override
	public List<AttributeVO> pageAttribute(AttributeSO so) {
		return itemDao.pageAttribute(so);
	}

	@Override
	public void insertAttribute(AttributePO po) {
		int result = itemDao.insertAttribute(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public Integer deleteAttribute(AttributePO po) {
		int result = itemDao.deleteAttribute(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}

	@Override
	public List<ItemVO> itemListInterface(ItemSO so){
		return itemDao.itemListInterface(so);
	}

	@Override
	public int updateItemWebStockQtyInterface(List<ItemPO> poList){

		int totalUpdateCnt = 0 ;
		for( ItemPO po : poList){
			int result = itemDao.updateItemWebStockQtyInterface(po);
			totalUpdateCnt += result;
		}
		return totalUpdateCnt;
	}

	@Override
	public Long getSeqAttrValNo(AttributeSO so){
		return itemDao.getSeqAttrValNo(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<AttributeValueVO> listAttributeInterface(AttributeSO so){
		return itemDao.listAttributeInterface(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<ItemAttributeValueVO> checkItemAttributeValue(AttributeSO so){
		return itemAttributeValueDao.checkItemAttributeValue(so);
	}

	@Deprecated
	public void insertItem(String goodsId, List<AttributeSO> attributeSOList, List<ItemSO> itemSOList) {

	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertItemWithSkuCd(String goodsId, List<AttributeSO> attributeSOList, List<ItemSO> itemSOList, GoodsBasePO goodsBasePO) {
		// 단품 정보 등록 itemService
		// Bean Copy
		JsonUtil jsonUt = new JsonUtil();

		try {
			Session session = AdminSessionUtil.getSession();

			// 옵션 종류 등록
			int dispPriorRank = 1;
			String attrValJson = "";

			// 2017.08.30 추가
			List<AttributeSO> newAttributeSOList = new ArrayList<>();

			if(CollectionUtils.isNotEmpty(attributeSOList)) {
				for(AttributeSO so : attributeSOList ) {
					//  2017.08.30 추가
					AttributeSO newAttributeSO = so;
					//---------------------------------------------------------

					AttributePO attributePO = new AttributePO();
					BeanUtils.copyProperties(attributePO, so );

					// 옵션 등록
					itemDao.insertAttribute(attributePO );

					String beforeAttrValJson = so.getAttrValJson();

					if(!StringUtil.isEmpty(beforeAttrValJson )) {
						List<AttributeValuePO> attributeValuePOList = jsonUt.toArray(AttributeValuePO.class, beforeAttrValJson );
						if(session==null){ /// 인터페이스일 경우
							attributeValuePOList = attributeValuePOList.stream().distinct().collect(Collectors.toList());
						}
						int k=0;
						JSONArray newJsonArray = new JSONArray();
						if(attributeValuePOList != null && !attributeValuePOList.isEmpty()) {
							for(AttributeValuePO po : attributeValuePOList ) {
								/******
								 * 2017.08.30 추가 시작
								*/
								Long maxv;
								// 기존에 등록된 속성값이 있는지 체크
								AttributeSO itso = new AttributeSO();
								itso.setAttrNo(po.getAttrNo());
								itso.setAttrVal(po.getAttrVal());
								itso.setGoodsId(goodsId);
								List<ItemAttributeValueVO> dupAttrValNo = checkItemAttributeValue(itso);

								if(!dupAttrValNo.isEmpty()){
									maxv = dupAttrValNo.get(0).getAttrValNo();
									//log.debug("maxv> " +maxv);
								}else{

									//log.debug("k >>"+k);
									if(session==null){ /// 인터페이스일 경우[ 인터페이스는 첫번째 값을 시퀀스호출해서 이미 세팅해 놓은 상태임]
										if(k == 0){
											maxv = po.getAttrValNo();
										}else{
											AttributeSO attributeSO = new AttributeSO();
											attributeSO.setAttrNo(po.getAttrNo());
											attributeSO.setUseYn(CommonConstants.COMM_YN_Y);

											maxv = getSeqAttrValNo(attributeSO);
										}
									}else{

										AttributeSO attributeSO = new AttributeSO();
										attributeSO.setAttrNo(po.getAttrNo());
										attributeSO.setUseYn(CommonConstants.COMM_YN_Y);

										maxv = getSeqAttrValNo(attributeSO);
									}
									k++;
								}
								po.setAttrValNo(maxv);

								JSONObject j = new JSONObject();
								j.put("attrNm",po.getAttrNm());
								j.put("attrNo", po.getAttrNo());
								j.put("attrVal", po.getAttrVal());
								j.put("attrValNo", maxv);
								j.put("useYn", po.getUseYn());
								newJsonArray.add(j);

								 //  2017.08.30 추가 끝.


								// 옵션값 등록
								itemDao.insertAttributeValue(po );
							}
						}
						attrValJson = newJsonArray.toString();
						newAttributeSO.setAttrValJson(attrValJson);
					}

					GoodsAttributePO goodsAttributePO = new GoodsAttributePO();
					BeanUtils.copyProperties(goodsAttributePO, newAttributeSO );
					goodsAttributePO.setGoodsId(goodsId );
					// 새로 추가
					goodsAttributePO.setDispPriorRank(dispPriorRank);

					// 상품 옵션 등록
					itemDao.insertGoodsAttribute(goodsAttributePO );
					
					dispPriorRank++;
					newAttributeSOList.add(newAttributeSO);
				}
			}

			Long itemNo = null;
			
			// 단품이 아닐 경우 주문을 위해 빈값으로 item테이블 insert
			if(!StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsBasePO.getGoodsCstrtTpCd())) {
				ItemPO defaultItemPO = new ItemPO();
				defaultItemPO.setGoodsId(goodsId);
				defaultItemPO.setGoodsCstrtTpCd(goodsBasePO.getGoodsCstrtTpCd());
				defaultItemPO.setItemNm(messageSourceAccessor.getMessage("column.goods.item.basic"));
				
				itemDao.insertItem(defaultItemPO);
			}

			if(CollectionUtils.isNotEmpty(itemSOList)) {
				for(ItemSO iso : itemSOList ) {
					log.debug("itemSOList의 for 안의 iso>>>>"+iso);
					JSONArray jArray = new JSONArray();
					String itemAttrValJson = "";
					ItemPO itemPO = new ItemPO();
					// 2017.08.30 추가
					for(AttributeSO na : newAttributeSOList){

						List<AttributeSO> compareList = jsonUt.toArray(AttributeSO.class, na.getAttrValJson() );
						for(AttributeSO compareObj : compareList){
							log.debug("compareObj >>"+compareObj);

							JSONObject j = new JSONObject();

							if( compareObj.getAttrNo().equals(iso.getAttr1No())){
								if(compareObj.getAttrVal().equals( iso.getAttr1Val()) ){
									iso.setAttr1ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
									log.debug("compareObj 안의 iso>>>>"+iso);
								}
							}else if( compareObj.getAttrNo().equals(iso.getAttr2No())){
								if(compareObj.getAttrVal().equals( iso.getAttr2Val()) ){
									iso.setAttr2ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
									log.debug("compareObj 안의 iso>>>>"+iso);
								}
							}else if( compareObj.getAttrNo().equals(iso.getAttr3No())){
								if(compareObj.getAttrVal().equals( iso.getAttr3Val())){
									iso.setAttr3ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
								}
							}else if( compareObj.getAttrNo().equals(iso.getAttr4No())){
								if(compareObj.getAttrVal().equals( iso.getAttr4Val()) ){
									iso.setAttr4ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
								}
							}else if( compareObj.getAttrNo().equals(iso.getAttr5No())
									&& compareObj.getAttrVal().equals( iso.getAttr5Val()) ){
								iso.setAttr5ValNo(Long.parseLong(compareObj.getAttrValNo()));
								j.put("attrValNo",compareObj.getAttrValNo());
								j.put("attrNo", compareObj.getAttrNo());
								j.put("attrVal", compareObj.getAttrVal());
								jArray.add(j);
							}
						}
						itemAttrValJson = jArray.toString();
						log.debug("itemAttrValJson >>>>"+itemAttrValJson);
					}

					iso.setAttrValJson(itemAttrValJson);
					log.debug("새로운 iso >>>>"+iso);

					BeanUtils.copyProperties(itemPO, iso );
					itemPO.setGoodsId(goodsId );
					itemPO.setGoodsCstrtTpCd(goodsBasePO.getGoodsCstrtTpCd());

					// 단품 등록
					if(ObjectUtils.isEmpty(goodsBasePO.getItemNo()) && ObjectUtils.isEmpty(itemNo)) {
						itemDao.insertItem(itemPO );
						itemNo = itemPO.getItemNo();
					}else {
						itemNo = ObjectUtils.isEmpty(goodsBasePO.getItemNo()) ? itemNo : goodsBasePO.getItemNo();
						itemPO.setItemNo(itemNo);
						itemDao.updateItem(itemPO );
					}
					
					itemPO.getGoodsId();
					
					//sku 등록
					if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsBasePO.getGoodsCstrtTpCd()) && !StringUtils.isEmpty(itemPO.getSkuCd())) {
						goodsSkuService.insertSkuBase(goodsBasePO, itemPO);
					}

					// 이력등록 추가
					ItemHistPO itemHistPo = new ItemHistPO();
					BeanUtils.copyProperties(itemHistPo, itemPO );
					itemDao.insertItemHist(itemHistPo );

					// 단품 옵션값 등록
					attrValJson = iso.getAttrValJson();
					log.debug(" 단품옵션값 attrValJson >"+attrValJson );
					if(!StringUtil.isEmpty(attrValJson )) {
						List<ItemAttributeValuePO> itemAttributeValuePOList = jsonUt.toArray(ItemAttributeValuePO.class, attrValJson );
						if(itemAttributeValuePOList != null && !itemAttributeValuePOList.isEmpty()) {
							for(ItemAttributeValuePO po : itemAttributeValuePOList ) {
								po.setItemNo(itemNo );
								itemDao.insertItemAttributeValue(po );
							}
						}
					}

					// 단품 옵션 이력 등록
					ItemAttrHistPO itemAttrHistPO = new ItemAttrHistPO();
					log.debug(" 단품 옵션 이력 등록 so >>"+iso);
					BeanUtils.copyProperties(itemAttrHistPO, iso );
					itemAttrHistPO.setItemNo(itemNo );
					itemAttrHistPO.setUseYn(CommonConstants.COMM_YN_Y);

					itemDao.insertItemAttrHist(itemAttrHistPO );

				}
			}

		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}
	
	@Override
	public void updateItem(GoodsPO goodsPO, String goodsId) {
		
		// 삭제후 등록
		itemDao.deleteGoodsAttrWithGoodsId(goodsId);
		itemDao.deleteItemAttrVal(goodsPO.getGoodsBasePO().getItemNo());
		
		insertItemWithSkuCd(goodsId, goodsPO.getAttributeSOList(), goodsPO.getItemSOList(), goodsPO.getGoodsBasePO());

	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이템 수정 TODO@@@
	* </pre>
	*
	* @param goodsPO
	* @param goodsId
	*/
//	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void updateItem_old(GoodsPO goodsPO, String goodsId) {
		
		JsonUtil jsonUt = new JsonUtil();
		
		if(goodsPO.getOrgAttrDelete().isEmpty()){
			String attrValJson = "";
			try {
				// 옵션 종류 등록 ex> 색상
				List<AttributeSO> attributeSOList = null;
				attributeSOList = goodsPO.getAttributeSOList();
				if(attributeSOList != null && !attributeSOList.isEmpty()) {
					for(AttributeSO so : attributeSOList ){
						AttributePO attributePO = new AttributePO();
						BeanUtils.copyProperties(attributePO, so );
						// 옵션 등록
						itemDao.insertAttribute(attributePO );  // ATTRIBUTE 테이블에 등록

						attrValJson = so.getAttrValJson();
						log.debug( "--- 단품 attrValJson : {}", attrValJson);
						if(!StringUtil.isEmpty(attrValJson )) {
							List<AttributeValuePO> attributeValuePOList = jsonUt.toArray(AttributeValuePO.class, attrValJson );
							if(attributeValuePOList != null && !attributeValuePOList.isEmpty()) {
								AttributeSO atSO = new AttributeSO();
								atSO.setAttrNo(so.getAttrNo());
								atSO.setGoodsId(goodsId);
								itemDao.deleteAttrVal(atSO );  //ATTRIBUTE_VALUE 테이블에서 삭제
								for(AttributeValuePO po : attributeValuePOList ) {
									// 옵션값 등록
									itemDao.insertAttributeValue(po );  //ATTRIBUTE_VALUE 테이블에 등록
								}
							}
						}

						GoodsAttributePO goodsAttributePO = new GoodsAttributePO();
						BeanUtils.copyProperties(goodsAttributePO, so );
						goodsAttributePO.setGoodsId(goodsId );

						//  GOODS_ATTRIBUTE 테이블에 옵션 등록
						itemDao.insertGoodsAttribute(goodsAttributePO );
					}
				}

				List<ItemSO> itemSOList = null;
				itemSOList = goodsPO.getItemSOList();  // 등록 및 수정할 단품 목록
				Long itemNo = null;

				if(itemSOList != null && !itemSOList.isEmpty() ){
					for(ItemSO so : itemSOList ){
						ItemPO itemPO = new ItemPO();
						BeanUtils.copyProperties(itemPO, so );
						itemPO.setGoodsId(goodsId );

						// 단품 수정
						//보안 진단. 불필요한 코드 (비어있는 IF문)
						/*if(itemPO.getItemNo() != null ) {
//							log.debug("단품 수정 >> "+itemPO);
//							itemDao.updateItem(itemPO );
						} else { // 단품 추가
							log.debug("단품 추가 ");
//							int regNo = itemDao.insertItem(itemPO );
//							if( regNo > 0){
//								itemNo =itemDao.getItemSeq();
//							}
						}*/
						itemDao.updateItem(itemPO );

						// 이력등록 추가
						ItemHistPO itemHistPo = new ItemHistPO();
						BeanUtils.copyProperties(itemHistPo, itemPO );
						itemDao.insertItemHist(itemHistPo );

						attrValJson = so.getAttrValJson();
						List<ItemAttributeValuePO> itemAttributeValuePOList = jsonUt.toArray(ItemAttributeValuePO.class, attrValJson );
						// 단품 옵션 삭제 후 등록
						log.debug("itemAttributeValuePOList >>"+itemAttributeValuePOList);
						if(itemAttributeValuePOList != null && !itemAttributeValuePOList.isEmpty()) {
							itemDao.deleteItemAttrVal(itemPO.getItemNo());
							for(ItemAttributeValuePO po : itemAttributeValuePOList ) {
								po.setItemNo(itemPO.getItemNo());
								itemDao.insertItemAttributeValue(po );
							}
						}

						if(itemNo != null){
							ItemAttrHistPO itemAttrHistPO = new ItemAttrHistPO();
							BeanUtils.copyProperties(itemAttrHistPO, so );
							itemAttrHistPO.setItemNo(itemNo );
							log.debug("itemAttrHistPO>"+itemAttrHistPO);
							itemDao.insertItemAttrHist(itemAttrHistPO );
						}
					} //end for
				}
			}catch (IllegalAccessException | InvocationTargetException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
		} else {
			// 단품 정보 등록
			try {
				Session session = AdminSessionUtil.getSession();

				// 옵션 종류 등록
				List<AttributeSO> attributeSOList = null;
				attributeSOList = goodsPO.getAttributeSOList();
				log.debug("attributeSOList>"+attributeSOList);
				int dispPriorRank = 1;
				String attrValJson = "";

				// 2017.08.30 추가
				List<AttributeSO> newAttributeSOList = new ArrayList<>();

				if(attributeSOList != null && !attributeSOList.isEmpty()) {
					
					// 상품번호와  ATTR_NO로 삭제 처리(ATTRIBUTE_VALUE)
					int orgAttrDeleteArr = goodsPO.getOrgAttrDelete().size();
					log.debug("==================================================");
					log.debug("삭제할 속성 갯수 : " + orgAttrDeleteArr);
					log.debug("==================================================");
					for (int i = 0; i < orgAttrDeleteArr; i++) {
						AttributeSO atSO = new AttributeSO();
						atSO.setAttrNo(goodsPO.getOrgAttrDelete().get(i).getAttrNo());
						log.debug("==================================================");
						log.debug("삭제할 속성 번호(" + i + ") : " + goodsPO.getOrgAttrDelete().get(i).getAttrNo());
						log.debug("==================================================");
						atSO.setGoodsId(goodsId);
						itemDao.deleteAttrVal(atSO); 
					}
					
					//상품 번호로 옵션 삭제 처리(GOODS_ATTRIBUTE)
					itemDao.deleteGoodsAttrWithGoodsId(goodsId);
					
					//상품 번호로 단품 옵션값 삭제 처리(ITEM)
					itemDao.deleteItemWithGoodsId(goodsId);
					
					//상품 번호로 단품 옵션값 삭제 처리(ITEM_ATTRIBUTE_VALUE)
					log.debug("==================================================");
					log.debug("상품 id : " + goodsId);
					log.debug("==================================================");
					itemDao.deleteItemAttrValWithGoodsId(goodsId);
					
					for(AttributeSO so : attributeSOList ) {
						//  2017.08.30 추가
						AttributeSO newAttributeSO = so;
						log.debug("before so>>>>>>>"+so);
						//---------------------------------------------------------

						AttributePO attributePO = new AttributePO();
						BeanUtils.copyProperties(attributePO, so );

						// 옵션 등록
						log.debug("#### attributePO : {}" ,attributePO);

						itemDao.insertAttribute(attributePO );

						String beforeAttrValJson = so.getAttrValJson();

						if(!StringUtil.isEmpty(beforeAttrValJson )) {
							log.debug("beforeAttrValJson>>>"+beforeAttrValJson);
							List<AttributeValuePO> attributeValuePOList = jsonUt.toArray(AttributeValuePO.class, beforeAttrValJson );
							if(session==null){ /// 인터페이스일 경우
								attributeValuePOList = attributeValuePOList.stream().distinct().collect(Collectors.toList());
							}
							log.debug(" ##### attributeValuePOList {} ", attributeValuePOList);
							int k=0;
							JSONArray newJsonArray = new JSONArray();
							if(attributeValuePOList != null && !attributeValuePOList.isEmpty()) {
								for(AttributeValuePO po : attributeValuePOList ) {
									/******
									 * 2017.08.30 추가 시작
									*/
									log.debug("AttributeValuePO po >>>"+po);
									Long maxv;
									// 기존에 등록된 속성값이 있는지 체크
									AttributeSO itso = new AttributeSO();
									itso.setAttrNo(po.getAttrNo());
									itso.setAttrVal(po.getAttrVal());
									itso.setGoodsId(goodsId);
									List<ItemAttributeValueVO> dupAttrValNo = checkItemAttributeValue(itso);

									if(!dupAttrValNo.isEmpty()){
										maxv = dupAttrValNo.get(0).getAttrValNo();
										//log.debug("maxv> " +maxv);
									}else{

										//log.debug("k >>"+k);
										if(session ==null){ /// 인터페이스일 경우[ 인터페이스는 첫번째 값을 시퀀스호출해서 이미 세팅해 놓은 상태임]
											if(k == 0){
												maxv = po.getAttrValNo();
											}else{
												AttributeSO attributeSO = new AttributeSO();
												attributeSO.setAttrNo(po.getAttrNo());
												attributeSO.setUseYn(CommonConstants.COMM_YN_Y);

												maxv = getSeqAttrValNo(attributeSO);
											}
										}else{

											AttributeSO attributeSO = new AttributeSO();
											attributeSO.setAttrNo(po.getAttrNo());
											attributeSO.setUseYn(CommonConstants.COMM_YN_Y);

											maxv = getSeqAttrValNo(attributeSO);
										}
										k++;
									}
									log.debug("maxv>"+maxv);
									po.setAttrValNo(maxv);

									JSONObject j = new JSONObject();
									j.put("attrNm",po.getAttrNm());
									j.put("attrNo", po.getAttrNo());
									j.put("attrVal", po.getAttrVal());
									j.put("attrValNo", maxv);
									j.put("useYn", po.getUseYn());
									newJsonArray.add(j);

									 //  2017.08.30 추가 끝.

									log.debug("단품 속성 값 등록 po >>"+po);

									// 옵션값 등록
									itemDao.insertAttributeValue(po );
								}
							}
							attrValJson = newJsonArray.toString();
							log.debug("attrValJson>"+attrValJson);
							newAttributeSO.setAttrValJson(attrValJson);
						}

						log.debug("after so>>>>>>>"+so);
						log.debug("newAttributeSO>>>>>>>"+newAttributeSO);
						GoodsAttributePO goodsAttributePO = new GoodsAttributePO();
						BeanUtils.copyProperties(goodsAttributePO, newAttributeSO );
						goodsAttributePO.setGoodsId(goodsId );
						// 새로 추가
						goodsAttributePO.setDispPriorRank(dispPriorRank);

						// 상품 옵션 등록
						itemDao.insertGoodsAttribute(goodsAttributePO );
						dispPriorRank++;
						newAttributeSOList.add(newAttributeSO);
					}
				}
				log.debug("newAttributeSOList>>>>>>>"+newAttributeSOList);

				List<ItemSO> itemSOList = null;
				itemSOList = goodsPO.getItemSOList();
				log.debug("itemSOList>"+ itemSOList);
				Long itemNo = null;

				if(itemSOList != null && !itemSOList.isEmpty()) {
					for(ItemSO iso : itemSOList ) {
						log.debug("itemSOList의 for 안의 iso>>>>"+iso);
						JSONArray jArray = new JSONArray();
						String itemAttrValJson = "";
						ItemPO itemPO = new ItemPO();
						// 2017.08.30 추가
						for(AttributeSO na : newAttributeSOList){

							List<AttributeSO> compareList = jsonUt.toArray(AttributeSO.class, na.getAttrValJson() );
							for(AttributeSO compareObj : compareList){
								log.debug("compareObj >>"+compareObj);

								JSONObject j = new JSONObject();

								if( compareObj.getAttrNo().equals(iso.getAttr1No())
										&& compareObj.getAttrVal().equals( iso.getAttr1Val())){
									iso.setAttr1ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
									log.debug("compareObj 안의 iso>>>>"+iso);
								}else if( compareObj.getAttrNo().equals(iso.getAttr2No())
										&& compareObj.getAttrVal().equals( iso.getAttr2Val())){
									iso.setAttr2ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
									log.debug("compareObj 안의 iso>>>>"+iso);
								}else if( compareObj.getAttrNo().equals(iso.getAttr3No())
										&& compareObj.getAttrVal().equals( iso.getAttr3Val())){
									iso.setAttr3ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
								}else if( compareObj.getAttrNo().equals(iso.getAttr4No())
										&& compareObj.getAttrVal().equals( iso.getAttr4Val())){
									iso.setAttr4ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
								}else if( compareObj.getAttrNo().equals(iso.getAttr5No())
										&& compareObj.getAttrVal().equals( iso.getAttr5Val())){
									iso.setAttr5ValNo(Long.parseLong(compareObj.getAttrValNo()));
									j.put("attrValNo",compareObj.getAttrValNo());
									j.put("attrNo", compareObj.getAttrNo());
									j.put("attrVal", compareObj.getAttrVal());
									jArray.add(j);
								}
							}
							itemAttrValJson = jArray.toString();
							log.debug("itemAttrValJson >>>>"+itemAttrValJson);
						}

						iso.setAttrValJson(itemAttrValJson);
						log.debug("새로운 iso >>>>"+iso);

						BeanUtils.copyProperties(itemPO, iso );
						itemPO.setGoodsId(goodsId );

						// 단품 등록
						itemDao.insertItem(itemPO );
						itemNo = itemPO.getItemNo();

						// 이력등록 추가
						ItemHistPO itemHistPo = new ItemHistPO();
						BeanUtils.copyProperties(itemHistPo, itemPO );
						itemDao.insertItemHist(itemHistPo );

						// 단품 옵션값 등록
						attrValJson = iso.getAttrValJson();
						log.debug(" 단품옵션값 attrValJson >"+attrValJson );
						if(!StringUtil.isEmpty(attrValJson )) {
							List<ItemAttributeValuePO> itemAttributeValuePOList = jsonUt.toArray(ItemAttributeValuePO.class, attrValJson );
							if(itemAttributeValuePOList != null && !itemAttributeValuePOList.isEmpty()) {
								for(ItemAttributeValuePO po : itemAttributeValuePOList ) {
									po.setItemNo(itemNo );
									itemDao.insertItemAttributeValue(po );
								}
							}
						}

						// 단품 옵션 이력 등록
						ItemAttrHistPO itemAttrHistPO = new ItemAttrHistPO();
						log.debug(" 단품 옵션 이력 등록 so >>"+iso);
						BeanUtils.copyProperties(itemAttrHistPO, iso );
						itemAttrHistPO.setItemNo(itemNo );

						itemDao.insertItemAttrHist(itemAttrHistPO );

					}
				}

			} catch (IllegalAccessException | InvocationTargetException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
		}
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemServiceImpl.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 아이템 재고 수정
	* </pre>
	*
	* @param goodsPO
	* @return
	*/
	@Override
	public int updateItemWebStk(GoodsPO goodsPO, String goodsId) {
		
		int result = 0;
		
		for(ItemSO itemSO : goodsPO.getItemSOList()) {
			
			ItemPO itemPO = new ItemPO();
			try {
				BeanUtils.copyProperties(itemPO, itemSO );
				
				itemPO.setItemNo(goodsPO.getGoodsBasePO().getItemNo());
				itemPO.setGoodsId(goodsId);
				itemPO.setWebStkQty(goodsPO.getGoodsBasePO().getDefatultItemStockCount());
				
				int itemResult = itemDao.updateItemWebStockQtyReset(itemPO);
				
				if (itemResult < 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				

				// 재입고 알림 insert 추가
				MemberIoAlarmPO po = new MemberIoAlarmPO();
	            po.setAlmYn(CommonConstants.COMM_YN_N);
	            po.setDelYn(CommonConstants.COMM_YN_N);
	            po.setSysDelYn(CommonConstants.COMM_YN_N);
	            po.setGoodsId(goodsId);
	            List<MemberIoAlarmVO> alarmList = memberIoAlarmService.getIoAlarm(po);
	            
	            if(CollectionUtils.isNotEmpty(alarmList)) {
	                GoodsIoAlmPO goodsIoAlmPO = new GoodsIoAlmPO();
	                goodsIoAlmPO.setGoodsId(goodsId);
	                goodsIoAlmPO.setSndCpltYn(CommonConstants.COMM_YN_N);
	                goodsIoAlmPO.setStkQty(itemPO.getWebStkQty());
	                goodsIoAlmDao.insertDupIoAlmTgGoods(goodsIoAlmPO);
	            }
				
				
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT); 
			}
			
			// 단품 이력등록
			ItemHistPO itemHistPo = new ItemHistPO();
			
			try {
				BeanUtils.copyProperties(itemHistPo, itemPO );
				itemDao.insertItemHist(itemHistPo );
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		
		}

		return result;
		
	}
	
}
