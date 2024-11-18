package biz.app.system.dao;

import org.springframework.stereotype.Repository;

import biz.app.system.model.LocalPostSO;
import framework.common.dao.MainAbstractDao;

@Repository
public class LocalPostDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "localPost.";

	/**
	 * <pre>
	 * - 작성일		: 2017. 6. 1.
	 * - 작성자		: Administrator
	 * - 설명		: 도서/산간지역 여부 (Y or N)
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public String getLocalPostYn(LocalPostSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getLocalPostYn", so);
	}

}
