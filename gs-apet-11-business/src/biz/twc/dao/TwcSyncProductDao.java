package biz.twc.dao;

import framework.common.dao.TwcAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.twc.dao
 * - 파일명		: TwcSyncProductDao.java
 * - 작성일		: 2021. 03. 31.
 * - 작성자		: Administrator
 * - 설명		: TWC Product
 * </pre>
 */
@Repository
public class TwcSyncProductDao extends TwcAbstractDao {

	private static final String BASE_DAO_PACKAGE = "twcSyncProduct.";

	public List listTwcProduct(){
		return selectList(BASE_DAO_PACKAGE + "listTwcProduct");
	}

	public List listTwcProductNutrition(){
		return selectList(BASE_DAO_PACKAGE + "listTwcProductNutrition");
	}
}
