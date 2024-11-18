package biz.admin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.admin.model.GoodsMainVO;
import biz.admin.model.OrderMainVO;
import biz.admin.model.SalesStateMainVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.admin.dao
* - 파일명		: AdminDao.java
* - 작성일		: 2017. 6. 29.
* - 작성자		: Administrator
* - 설명			: 관리자 DAO
* </pre>
*/
@Repository
public class AdminDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "admin.";

	public List<SalesStateMainVO> listSalesStateMain(){
		return selectList(BASE_DAO_PACKAGE + "listSalesStateMain");
	}

	public List<OrderMainVO> listOrderMain() {
		return selectList(BASE_DAO_PACKAGE + "listOrderMain");
	}

	public List<OrderMainVO> listOrderMainNc(Long compNo) {
		return selectList(BASE_DAO_PACKAGE + "listOrderMainNc", compNo);
	}

	public List<OrderMainVO> listClaimMain() {
		return selectList(BASE_DAO_PACKAGE + "listClaimMain");
	}

	public List<OrderMainVO> listClaimMainNc(Long compNo) {
		return selectList(BASE_DAO_PACKAGE + "listClaimMainNc", compNo);
	}

	public List<GoodsMainVO> listGoodsMain() {
		return selectList(BASE_DAO_PACKAGE + "listGoodsMain");
	}

	public List<GoodsMainVO> listGoodsMainNc(Long compNo) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsMainNc", compNo);
	}

}
