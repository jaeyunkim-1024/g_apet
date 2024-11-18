package biz.app.claim.dao;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao
* - 파일명		: ClaimBaseDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 클레임 기본 DAO
* </pre>
*/
@Repository
public class ClaimBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "claimBase.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimBaseDao.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 번호 생성
	* </pre>	
	* @param ordNo
	* @return
	*/
	public String getClaimNo(String ordNo){
		return selectOne(BASE_DAO_PACKAGE + "getClaimNo", ordNo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimBaseDao.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 기본 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertClaimBase( ClaimBasePO po ) {
		return insert( BASE_DAO_PACKAGE + "insertClaimBase", po );	
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimBaseDao.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: snw
	* - 설명			: 클레임 기본 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public ClaimBaseVO getClaimBase(ClaimBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getClaimBase", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimBaseDao.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: snw
	* - 설명			: 클레임 기본 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateClaimBase( ClaimBasePO po ) {
		return update( BASE_DAO_PACKAGE + "updateClaimBase", po );
	}
	
	/**
	 * 배송비 관련 화면 조회를 위한 클레임 기본 정보 조회
	 * 
	 * @param po
	 * @return
	 */
	public ClaimBasePO selectClaimInfoForDeliveryCahrgeSumAmt( ClaimBasePO po ) {
		return selectOne( BASE_DAO_PACKAGE + "selectClaimInfoForDeliveryCahrgeSumAmt", po );	
	}
	
		
}
