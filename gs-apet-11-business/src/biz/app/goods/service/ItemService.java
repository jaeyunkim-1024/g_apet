package biz.app.goods.service;

import java.util.List;
import java.util.Map;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValuePO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.goods.model.*;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.service
* - 파일명		: ItemService.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: valueFactory
* - 설명			: 단품 관리
* </pre>
*/
public interface ItemService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 단품의 웹재고 증차감
	* 					  상품단위의 웹 재고 관리에 따른 증 차감 처리
	* 					  주문/클레임 시 사용
	* </pre>
	* @param goodsId
	* @param itemNo
	* @param applyQty	+ / -
	*/
	public void updateItemWebStockQty(GoodsBaseVO goodsBase, Long itemNo, Integer applyQty);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeService.java
	* - 작성일		: 2017. 2. 6.
	* - 작성자		: snw
	* - 설명			: 단품의 속성 및 속성값 목록 조회
	* </pre>
	* @param itemNo
	* @return
	*/
	public List<ItemAttributeValueVO> listItemAttributeValue(Long itemNo);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: snw
	* - 설명			: 상품 중 특정 속성으로 구성된 단품 조회
	* </pre>
	* @param goodsId
	* @param attrNos
	* @param attrValNos
	* @return
	*/
	public ItemVO getItem(String goodsId, Long[] attrNos, Long[] attrValNos);



















	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: shkim
	* - 설명			: 상품상세 - 단품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemVO> listItem (ItemSO so);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: valueFactory
	* - 설명			: 단품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemVO> pageItem (GoodsBaseSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 5. 19.
	* - 작성자		: valueFactory
	* - 설명			: 디폴트 옵션 조회
	* </pre>
	* @param goodsId
	* @return
	 */
	public  List<AttributeValueVO> listAttribute(AttributeSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 옵션 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<AttributeVO> listGoodsAttribute (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 단품 리스트 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<ItemVO> listGoodsItem (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2016. 6. 15.
	* - 작성자		: valueFactory
	* - 설명			: 상품 단품 이력 조회
	* </pre>
	* @param itemHistSO
	* @return
	*/
	public List<ItemHistVO> listItemHist (ItemHistSO itemHistSO );


	public Integer getMaxAttributeValue(AttributeSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 09.
	* - 작성자		: hjko
	* - 설명			: Interface 단품 추가
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<ItemVO> addItem(String goodsId, List<ItemSO> itemSOList, Map <Long , List<AttributeValuePO>> grpAttrVPOList );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: hjko
	* - 설명			: Interface 단품 수정
	* </pre>
	* @param
	* @return
	*/
	public Integer updateItems(List<ItemPO> itemPOList);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: hongjun
	* - 설명			: 옵션 조회
	* </pre>
	* @param
	* @return
	*/
	public AttributeVO getAttribute(AttributeSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hongjun
	* - 설명			: 옵션 페이지 리스트
	* </pre>
	* @param
	* @return
	*/
	public List<AttributeVO> pageAttribute(AttributeSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hongjun
	* - 설명		: 옵션 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public void insertAttribute(AttributePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hongjun
	* - 설명		: 옵션 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer deleteAttribute(AttributePO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hjko
	* - 설명			: Interface 단품 조회 API
	* </pre>
	* @param
	* @return
	*/
	List<ItemVO> itemListInterface(ItemSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hjko
	* - 설명			: Interface 웹재고 일괄 변경 API
	* </pre>
	* @param
	* @return
	*/
	public int updateItemWebStockQtyInterface( List<ItemPO> poList);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 8. 30.
	* - 작성자		: hjko
	* - 설명			:  ATTR_VAL_NO SEQUENCE 채번
	* </pre>
	* @param
	* @return
	*/
	public Long getSeqAttrValNo(AttributeSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 8. 30.
	* - 작성자		: hjko
	* - 설명			:  API 속성 정보 조회(INTERFACE)
	* </pre>
	* @param
	* @return
	*/
	public List<AttributeValueVO> listAttributeInterface(AttributeSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemService.java
	* - 작성일		: 2017. 8. 30.
	* - 작성자		: snw
	* - 설명			: 상품의 속성 및 속성값이 이미 존재하는지 체크
	* </pre>
	* @param AttributeSO
	* @return
	*/
	public List<ItemAttributeValueVO> checkItemAttributeValue(AttributeSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이템 등록
	* </pre>
	*
	* @param goodsId
	* @param attributeSOList
	* @param itemSOList
	* @return
	*/
	void insertItem(String goodsId, List<AttributeSO> attributeSOList, List<ItemSO> itemSOList);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: ItemService.java
	 * - 작성일	: 2021. 1. 6.
	 * - 작성자 	: valfac
	 * - 설명 		: 상품 아이템 등록
	 * </pre>
	 *
	 * @param goodsId
	 * @param attributeSOList
	 * @param itemSOList
	 * @return
	 */
	void insertItemWithSkuCd(String goodsId, List<AttributeSO> attributeSOList, List<ItemSO> itemSOList, GoodsBasePO goodsBasePO);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이템 수정
	* </pre>
	*
	* @param goodsPO
	* @param goodsId
	*/
	public void updateItem(GoodsPO goodsPO, String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemService.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		:
	* </pre>
	*
	* @param goodsPO
	* @return
	*/
	public int updateItemWebStk(GoodsPO goodsPO, String goodsId);
}
