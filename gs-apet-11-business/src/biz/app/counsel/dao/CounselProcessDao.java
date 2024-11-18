package biz.app.counsel.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselProcessSO;
import biz.app.counsel.model.CounselProcessVO;
import biz.app.counsel.model.CounselSO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.cs.dao
* - 파일명		: CounselProcessDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 상담 처리 DAO
* </pre>
*/
@Repository
public class CounselProcessDao extends MainAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "counselProcess.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessDao.java
	* - 작성일		: 2017. 5. 10.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 목록 조회
	* </pre>
	* @param CounselSO
	* @return
	*/
	public List<CounselProcessVO> listCounselProcess( CounselProcessSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listCounselProcess", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertCounselProcess(CounselProcessPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCounselProcess", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public CounselProcessVO getCounselProcess(CounselProcessSO so)  {
		return (CounselProcessVO) selectOne(BASE_DAO_PACKAGE + "getCounselProcess", so);
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 체크
	* </pre>
	* @param so
	* @return
	*/
	public int checkCounselProcess(CounselProcessSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkCounselProcess", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessDao.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 수정
	* </pre>
	* @param so
	* @return
	*/
	public int updateCounselProcess(CounselProcessPO po) {
		return update(BASE_DAO_PACKAGE + "updateCounselProcess", po);
	}

}
