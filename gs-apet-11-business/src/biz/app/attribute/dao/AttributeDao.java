package biz.app.attribute.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app
* - 파일명		: AttributeDao.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hjko
* - 설명			:
* </pre>
*/
@Repository
public class AttributeDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "attribute.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeDao.java
	* - 작성일		: 2017. 5. 24.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param po
	* @return
	*/
	public Integer insertNewAttribute (AttributePO po ) {
		return insert(BASE_DAO_PACKAGE+"insertNewAttribute", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeDao.java
	* - 작성일		: 2017. 5. 24.
	* - 작성자		: hjko
	* - 설명			: 이전에 등록된 속성이 있나 체크
	* </pre>
	* @param po
	* @return
	*/
	public List<AttributeVO> checkAttributeExist(AttributeSO so) {

		return selectList(BASE_DAO_PACKAGE + "checkAttributeExist", so);
	}


}
