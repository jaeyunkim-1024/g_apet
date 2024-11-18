package biz.interfaces.humuson.dao;

import org.springframework.stereotype.Repository;

import biz.interfaces.humuson.model.DcgEmailMappingPO;
import biz.interfaces.humuson.model.DcgEmailPO;
import framework.common.dao.MailAbstractDao;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.humuson.dao
* - 파일명		: PostManDao.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: PostMan DAO
* </pre>
*/
@Repository
public class PostmanDao extends MailAbstractDao {

	private static final String BASE_DAO_PACKAGE = "postman.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PostmanDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: DCG 이메일 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertDcgEmail(DcgEmailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDcgEmail", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PostmanDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: DCG 이메일 Mapping 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertDcgEmailMapping(DcgEmailMappingPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDcgEmailMapping", po);
	}
}