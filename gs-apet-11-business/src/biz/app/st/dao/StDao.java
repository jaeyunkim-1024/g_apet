package biz.app.st.dao;

import java.util.List;

import org.springframework.stereotype.Repository;


import biz.app.st.model.StPolicyPO;
import biz.app.st.model.StPolicySO;
import biz.app.st.model.StPolicyVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.st.dao
* - 파일명		: StDao.java
* - 작성일		: 2017. 1. 2.
* - 작성자		: hongjun
* - 설명		: 사이트 DAO
* </pre>
*/
@Repository
public class StDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "st.";
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 사이트 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<StStdInfoVO> listStStdInfo(StStdInfoSO so){
		return selectList(BASE_DAO_PACKAGE + "listStStdInfo", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertStStdInfo (StStdInfoPO po ) {
		if(StringUtil.isNotBlank(po.getCsTelNo())){
			po.setCsTelNo(po.getCsTelNo().replaceAll("-", ""));
		}
		return insert("st.insertStStdInfo", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 조회 [BO]
	* </pre>
	* @param bndNo
	* @return
	*/
	public StStdInfoVO getStStdInfo (Long stId ) {
		return (StStdInfoVO)selectOne("st.getStStdInfo", stId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<StStdInfoVO> pageStStdInfo (StStdInfoSO so ) {
		return selectListPage("st.pageStStdInfo", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateStStdInfo (StStdInfoPO po ) {
		if(StringUtil.isNotBlank(po.getCsTelNo())){
			po.setCsTelNo(po.getCsTelNo().replaceAll("-", ""));
		}
		return update("st.updateStStdInfo", po );
	}

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param so
	 */
	public List<StStdInfoVO> getStList(StStdInfoSO so) {
	
		return selectList(BASE_DAO_PACKAGE + "getStList", so);
	}

	/**
	 *  
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.dao
	* - 파일명      : StDao.java
	* - 작성일      : 2017. 4. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 시스템 관리 > 사이트 관리 > 사이트 목록   > 사이트 상세 > 사이트 정책 목록
	* </pre>
	 */
	public List<StPolicyVO> listStPolicy(StPolicySO so) {
		return selectList(BASE_DAO_PACKAGE + "listStPolicy", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.dao
	* - 파일명      : StDao.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 조회 팝업 
	* </pre>
	 */
	public StPolicyVO getStPolicy(StPolicySO so) {
		return (StPolicyVO) selectOne(BASE_DAO_PACKAGE + "getStPolicy", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.dao
	* - 파일명      : StDao.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 등록
	* </pre>
	 */
	public int insertStPolicy(StPolicyPO po) {
		return insert(BASE_DAO_PACKAGE + "insertStPolicy", po);
	}
/**
 * 
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.st.dao
* - 파일명      : StDao.java
* - 작성일      : 2017. 4. 25.
* - 작성자      : valuefactory 권성중
* - 설명      : 사이트 정책 수정
* </pre>
 */
	public int updateStPolicy(StPolicyPO po) {
		return update(BASE_DAO_PACKAGE + "updateStPolicy", po);
	}
	 /**
	  * 
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.st.dao
	 * - 파일명      : StDao.java
	 * - 작성일      : 2017. 4. 25.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      :사이트 정책 삭제 
	 * </pre>
	  */
	public int stPolicyDelete(StPolicySO so) {
		return delete(BASE_DAO_PACKAGE + "stPolicyDelete", so);
	}
}
