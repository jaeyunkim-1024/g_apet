package biz.twc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.twc.model.TwcSampleVO;
import framework.common.dao.MainAbstractDao;
import framework.common.dao.TwcAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.twc.dao
* - 파일명		: TwcSampleDao.java
* - 작성일		: 2021. 01. 08.
* - 작성자		: Administrator
* - 설명		: TWC 샘플 DAO
* </pre>
*/
@Repository
public class TwcSampleDao extends TwcAbstractDao {

	private static final String BASE_DAO_PACKAGE = "twcSample.";

	public List<TwcSampleVO> getHelpKeyword(){
		return selectList(BASE_DAO_PACKAGE + "getHelpKeyword");
	}
}
