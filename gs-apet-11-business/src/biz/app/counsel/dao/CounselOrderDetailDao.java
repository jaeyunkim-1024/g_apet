package biz.app.counsel.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.counsel.model.CounselOrderDetailPO;
import biz.app.counsel.model.CounselOrderDetailVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.dao
* - 파일명		: CounselOrderDetailDao.java
* - 작성일		: 2017. 6. 9.
* - 작성자		: Administrator
* - 설명			: 상담 주문 상세 DAO
* </pre>
*/
@Repository
public class CounselOrderDetailDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "counselOrderDetail.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselOrderDetailDao.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: Administrator
	* - 설명			: 상담 주문 정보 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertCounselOrderInfo(CounselOrderDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCounselOrderInfo", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselOrderDetailDao.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: Administrator
	* - 설명			: 상담 주문 목록 조회
	* </pre>
	* @param cusNo
	* @return
	*/
	public List<CounselOrderDetailVO> listCounselOrderInfo(Long cusNo){
		return selectList(BASE_DAO_PACKAGE + "listCounselOrderInfo", cusNo);
	}
}