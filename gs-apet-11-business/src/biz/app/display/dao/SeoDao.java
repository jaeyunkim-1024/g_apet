package biz.app.display.dao;

import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

@Repository
public class SeoDao extends MainAbstractDao {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: SEO 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SeoInfoVO getSeoInfo(SeoInfoSO so) {
		return (SeoInfoVO) selectOne("seo.getSeoInfo", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertSeoInfo(SeoInfoPO po) {
		return insert("seo.insertSeoInfo", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateSeoInfo(SeoInfoPO po) {
		return update("seo.updateSeoInfo", po);
	}
}

