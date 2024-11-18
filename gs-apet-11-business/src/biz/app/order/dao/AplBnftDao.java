package biz.app.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.order.model.AplBnftPO;
import biz.app.order.model.AplBnftSO;
import biz.app.order.model.AplBnftVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: AplBnftDao.java
* - 작성일		: 2017. 1. 24.
* - 작성자		: snw
* - 설명			: 적용 혜택 DAO
* </pre>
*/
@Repository
public class AplBnftDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "aplBnft.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AplBnftDao.java
	* - 작성일		: 2017. 1. 24.
	* - 작성자		: snw
	* - 설명			: 적용 혜택 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertAplBnft(AplBnftPO po){
		return insert(BASE_DAO_PACKAGE + "insertAplBnft", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AplBnftDao.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 적용 혜택 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<AplBnftVO> listAplBnft(AplBnftSO so){
		return selectList(BASE_DAO_PACKAGE + "listAplBnft" , so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AplBnftDao.java
	* - 작성일		: 2017. 2. 28.
	* - 작성자		: snw
	* - 설명			:  쿠폰 적용 혜택 중 주문에 사용된 회원 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<Long> listAplBnftMbrCpNo(String ordNo){
		return selectList(BASE_DAO_PACKAGE + "listAplBnftMbrCpNo" , ordNo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AplBnftDao.java
	* - 작성일		: 2017. 3. 17.
	* - 작성자		: snw
	* - 설명			: 적용 혜택 취소
	* </pre>
	* @param po
	* @return
	*/
	public int updateAplBnftCancel(AplBnftPO po){
		return insert(BASE_DAO_PACKAGE + "updateAplBnftCancel", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AplBnftDao.java
	* - 작성일		: 2017. 3. 28.
	* - 작성자		: snw
	* - 설명			: 적용된 혜택 중 복원 해야 할 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<AplBnftVO> listAplBnftCancelCoupon(String ordNo){
		return selectList(BASE_DAO_PACKAGE + "listAplBnftCancelCoupon" , ordNo);
	}
	
}
