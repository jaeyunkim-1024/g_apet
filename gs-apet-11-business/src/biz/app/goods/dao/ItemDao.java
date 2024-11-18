package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValuePO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.goods.model.GoodsAttributePO;
import biz.app.goods.model.GoodsAttributeVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.ItemAttrHistPO;
import biz.app.goods.model.ItemAttributeValuePO;
import biz.app.goods.model.ItemAttributeValueVO;
import biz.app.goods.model.ItemHistPO;
import biz.app.goods.model.ItemHistSO;
import biz.app.goods.model.ItemHistVO;
import biz.app.goods.model.ItemPO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.dao
* - 파일명		: ItemDao.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 단품 DAO
* </pre>
*/
@Repository
public class ItemDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "item.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 단품 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public ItemVO getItem(ItemSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getItem", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 단품 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemVO> listItem (ItemSO so) {
		return selectList(BASE_DAO_PACKAGE + "listItem", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 단품의 웹재고 증차감
	*                     증감일 경우 +값
	*                     차감일 경우 -값
	* </pre>
	* @param po
	* @return
	*/
	public int updateItemWebStockQty(ItemPO po){
		return update(BASE_DAO_PACKAGE + "updateItemWebStockQty", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: ItemDao.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 단품의 웹재고 reset
	* </pre>
	*
	* @param po
	* @return
	*/
	public int updateItemWebStockQtyReset(ItemPO po){
		return update(BASE_DAO_PACKAGE + "updateItemWebStockQtyReset", po);
	}
























	public List<AttributeVO> listGoodsAttributeFO(AttributePO po) {
		return selectList("item.listGoodsAttributeFO", po);
	}

	public List<AttributeValueVO> listGoodsAttributeValueFO(AttributePO po) {
		return selectList("item.listGoodsAttributeValueFO", po);
	}

	// 옵션상품 옵션 조회
	public List<AttributeVO> listOptionGoodsAttributeFO(AttributePO po) {
		return selectList("item.listOptionGoodsAttributeFO", po);
	}

	// 옵션상품 옵션 값 조회
	public List<AttributeValueVO> listOptionGoodsAttributeValueFO(AttributePO po) {
		return selectList("item.listOptionGoodsAttributeValueFO", po);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 옵션 정보 등록
	* </pre>
	* @param attributePO
	* @return
	*/
	public int insertAttribute (AttributePO attributePO ) {
		return insert("item.insertAttribute", attributePO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 상품 옵션 정보 등록
	* </pre>
	* @param goodsAttributePO
	* @return
	*/
	public int insertGoodsAttribute (GoodsAttributePO goodsAttributePO ) {
		return insert("item.insertGoodsAttribute", goodsAttributePO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 옵션 값 등록
	* </pre>
	* @param attributeValuePO
	* @return
	*/
	public int insertAttributeValue (AttributeValuePO attributeValuePO ) {
		return insert("item.insertAttributeValue", attributeValuePO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 단품 옵션값 등록
	* </pre>
	* @param itemAttributeValuePO
	* @return
	*/
	public int insertItemAttributeValue (ItemAttributeValuePO itemAttributeValuePO ) {
		return insert("item.insertItemAttributeValue", itemAttributeValuePO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 단품 등록
	* </pre>
	* @param itemPO
	* @return
	*/
	public int insertItem (ItemPO itemPO ) {
		return insert("item.insertItem", itemPO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 10. 16
	* - 작성자		: hjko
	* - 설명			: 바로 전에 등록한 단품 seq 가져오기
	* </pre>
	* @param itemPO
	* @return
	*/
	public Long getItemSeq () {
		return (Long)selectOne("item.getItemSeq");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 6. 8.
	* - 작성자		: valueFactory
	* - 설명			: 단품 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertItemHist (ItemHistPO po ) {
		return insert("item.insertItemHist", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 단품 옵션 이력 등록
	* </pre>
	* @param itemAttrHistPO
	* @return
	*/
	public int insertItemAttrHist (ItemAttrHistPO itemAttrHistPO ) {
		return insert("item.insertItemAttrHist", itemAttrHistPO );
	}

	public int getWebStkQty (ItemPO itemPO ) {
		return (Integer) selectOne("item.getWebStkQty", itemPO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2021. 06. 11.
	* - 작성자		: ValueFactory
	* - 설명		: 재고관리하는 경우의 재고수량 조회
	* </pre>
	* @param GoodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> listWebStkQty (GoodsBaseSO so ) {
		return selectList("item.listWebStkQty", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 상품 번호로 단품 옵션 이력 삭제 처리.. 실제 삭제 처리 하지 않음.
	* 					Process 1
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteItemAttrHistWithGoodsId (String goodsId ) {
		return update("item.deleteItemAttrHistWithGoodsId", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 옵션값 삭제 처리.. 실제 삭제 처리 하지 않고.. USE_YN 처리.
	*					추후 로그 때문에 삭제 하지 않는다..
	*					Process 2
	* </pre>
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteAttrValWithGoodsId (String goodsId ) {
		return delete("item.deleteAttrValWithGoodsId", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 옵션 삭제 처리.. 실제 삭제 처리 하지 않고.. USE_YN 처리.
	*					추후 로그 때문에 삭제 하지 않는다..
	*					Process 3
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteAttrWithGoodsId (String goodsId ) {
		return delete("item.deleteAttrWithGoodsId", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 상품번호로 단품 옵션값 삭제 처리..
	* 					Process 4
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteItemAttrValWithGoodsId (String goodsId ) {
		return delete("item.deleteItemAttrValWithGoodsId", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: valueFactory
	* - 설명			: 상품번호로 옵션 삭제 처리
	* 					Process 5
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteGoodsAttrWithGoodsId (String goodsId ) {
		return delete("item.deleteGoodsAttrWithGoodsId", goodsId );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2020. 2. 6.
	* - 작성자		: pkt
	* - 설명			: 상품번호로 옵션 삭제 처리
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteItemWithGoodsId (String goodsId ) {
		return delete("item.deleteItemWithGoodsId", goodsId );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: valueFactory
	* - 설명			: 단품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemVO> pageItem (GoodsBaseSO so ) {
		return selectListPage("item.pageItem", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 옵션값 삭제
	* </pre>
	* @param attrNo
	* @return
	*/
	public int deleteAttrVal (AttributeSO atSO ) {
		return delete("item.deleteAttrVal", atSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 단품 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateItem (ItemPO po ) {
		return update("item.updateItem", po );
	}




	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 단품 옵션값 삭제
	* </pre>
	* @param itemNo
	* @return
	*/
	public int deleteItemAttrVal (Long itemNo ) {
		return delete("item.deleteItemAttrVal", itemNo );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 옵션 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<AttributeVO> listGoodsAttribute (String goodsId ) {
		return selectList("item.listGoodsAttribute", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 단품 리스트 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<ItemVO> listGoodsItem (String goodsId ) {
		return selectList("item.listGoodsItem", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 상품 옵션 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsAttributeVO> listGoodsAttr (String goodsId ) {
		return selectList("item.listGoodsAttr", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 단품 옵션값 조회
	* </pre>
	* @param itemNo
	* @return
	*/
	public List<ItemAttributeValueVO> listItemAttrValue (Long itemNo ) {
		return selectList("item.listItemAttrValue", itemNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 6. 15.
	* - 작성자		: valueFactory
	* - 설명			: 단품 이력 조회
	* </pre>
	* @param itemHistSO
	* @return
	*/
	public List<ItemHistVO> listItemHist (ItemHistSO itemHistSO ) {
		return selectList("item.listItemHist", itemHistSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 5. 17.
	* - 작성자		: shkim
	* - 설명		: 단품 옵션 값 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemVO> listChooseItem (ItemSO so) {
		return selectList("item.listChooseItem", so);
	}

	public List<ItemVO> listGoodsItems (ItemSO so) {
		return selectList("item.listGoodsItems", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 10. 1.
	* - 작성자		: hjko
	* - 설명		: 단품의 단품상태 수정
	*
	*
	* </pre>
	* @param po
	*/
	public int updateItemsStatCd(Integer item){
		return update("item.updateItemsStatCd", item);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2016. 10. 11.
	* - 작성자		: hjko
	* - 설명			: 단품 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertItemsHistory (ItemHistPO itemHistPO ) {
		return insert("item.insertItemsHistory", itemHistPO );
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 05. 19.
	* - 작성자		: hjko
	* - 설명			: attribute 목록 조회
	* </pre>
	* @param po
	 */
	public List<AttributeValueVO> listAttribute(AttributeSO so) {
		return selectList("item.listAttribute",so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeDao.java
	* - 작성일		: 2017. 5. 26.
	* - 작성자		: hjko
	* - 설명			: 속성값 테이블에 최대속성값조회
	* </pre>
	* @param po
	* @return
	*/
	public Integer getMaxAttributeValue(AttributeSO so) {

		return selectOne(BASE_DAO_PACKAGE + "getMaxAttributeValue", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: hongjun
	* - 설명			: 옵션 조회
	* </pre>
	* @param so
	* @return
	*/
	public AttributeVO getAttribute(AttributeSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getAttribute", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hongjun
	* - 설명			: 옵션 페이지 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<AttributeVO> pageAttribute(AttributeSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageAttribute", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hongjun
	* - 설명			: 옵션 삭제
	* </pre>
	* @param so
	* @return
	*/
	public int deleteAttribute(AttributePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteAttribute", po);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hjko
	* - 설명			: 인터페이스 속성목록 조회
	* </pre>
	* @param po
	* @return
	*/
	public List<ItemVO> itemListInterface(ItemSO so){
		return selectList(BASE_DAO_PACKAGE +"itemListInterface", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ItemDao.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: hjko
	* - 설명			: 인터페이스 웹재고 일괄변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateItemWebStockQtyInterface(ItemPO po) {
		return update(BASE_DAO_PACKAGE + "updateItemWebStockQtyInterface", po);
	}

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
	public Long getSeqAttrValNo(AttributeSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getSeqAttrValNo", so);
	}

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
	public List<AttributeValueVO> listAttributeInterface(AttributeSO so) {
		return selectList(BASE_DAO_PACKAGE +"listAttributeInterface", so);
	}
}
