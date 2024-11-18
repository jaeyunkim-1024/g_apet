package biz.bamboo.dao;

import org.springframework.stereotype.Repository;

import framework.common.dao.MainAbstractDao;

@Repository
public class BambooDao extends MainAbstractDao {
	
	public static final String BASE_DAO_PACKAGE = "bamboo.";

	public String getSelectBamboo() {
		return selectOne(BASE_DAO_PACKAGE + "bamboo");
		
	}
}
