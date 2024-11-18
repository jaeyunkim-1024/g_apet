package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.DepositAcctInfoVO;
import biz.app.system.model.DepositAcctInfoSO;
import biz.app.system.model.DepositAcctInfoPO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.dao
 * - 파일명		: DepositAcctInfoDao.java
 * - 작성일		: 2017. 2. 9.
 * - 작성자		: snw
 * - 설명		: 무통장 계좌 정보 DAO
 * </pre>
 */
@Repository
public class DepositAcctInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "depositAcctInfo.";

	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 목록 (Paging)
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DepositAcctInfoVO> pageDepositAcctInfo(DepositAcctInfoSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageDepositAcctInfo", so);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 목록
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DepositAcctInfoVO> listDepositAcctInfo(DepositAcctInfoSO so) {
		return selectList(BASE_DAO_PACKAGE + "listDepositAcctInfo", so);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 상세화면
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public DepositAcctInfoVO getDepositAcctInfo(DepositAcctInfoSO so) {
		return (DepositAcctInfoVO) selectOne(BASE_DAO_PACKAGE + "getDepositAcctInfo", so);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 등록
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertDepositAcctInfo(DepositAcctInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDepositAcctInfo", po);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 수정
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateDepositAcctInfo(DepositAcctInfoPO po) {
		return update(BASE_DAO_PACKAGE + "updateDepositAcctInfo", po);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 삭제
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int deleteDepositAcctInfo(DepositAcctInfoPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteDepositAcctInfo", po);
	}
}
