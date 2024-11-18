package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.PntInfoPO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.system.dao
 * - 파일명		: PntInfoDao.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 포인트 DAO
 * </pre>
 */
@Repository
public class PntInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "pntInfo.";
	

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.dao
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 페이지 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PntInfoVO> pagePntInfo(PntInfoSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pagePntInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.dao
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public PntInfoVO getPntInfo(PntInfoSO so){
		return selectOne(BASE_DAO_PACKAGE + "getPntInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.dao
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertPntInfo(PntInfoPO po){
		return insert(BASE_DAO_PACKAGE + "insertPntInfo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.dao
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePntInfo(PntInfoPO po){
		return update(BASE_DAO_PACKAGE + "updatePntInfo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.dao
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 등록/수정 시 Valid 
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getValidCount(PntInfoSO so){
		return selectOne(BASE_DAO_PACKAGE + "getValidCount", so);
	}
}
