package biz.interfaces.naver.dao;

import biz.interfaces.naver.model.NaverEpVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.interfaces.naver.dao
 * - 파일명     : NaverEpDao.java
 * - 작성일     : 2021. 03. 02.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */
@Repository
public class NaverEpDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "naverEp.";

	/**
	 * 네이버 EP 정보
	 * @return
	 */
	public List<NaverEpVO> selectNaverEpInfo() {
		return selectList(BASE_DAO_PACKAGE + "selectNaverEpInfo");
	}
}
