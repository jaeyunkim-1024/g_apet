package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.attribute.model.AttributeSO;
import biz.app.goods.model.ItemAttributeValueSO;
import biz.app.goods.model.ItemAttributeValueVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.attribute.dao
* - 파일명		: ItemAttributeValueDao.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 단품 속성 값 DAO
* </pre>
*/
@Repository
public class ItemAttributeValueDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "itemAttributeValue.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeDao.java
	* - 작성일		: 2017. 2. 6.
	* - 작성자		: snw
	* - 설명			: 단품 속성&값 목록 조회
	*
	* </pre>
	* @param so
	* @return
	*/
	public List<ItemAttributeValueVO> listItemAttributeValue(ItemAttributeValueSO so){
		return selectList(BASE_DAO_PACKAGE + "listItemAttributeValue", so);
	}

	public List<ItemAttributeValueVO> checkItemAttributeValue(AttributeSO so){
		return selectList(BASE_DAO_PACKAGE + "checkItemAttributeValue", so);
	}






















}