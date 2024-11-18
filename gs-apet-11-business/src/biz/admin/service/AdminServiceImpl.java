package biz.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.admin.dao.AdminDao;
import biz.admin.model.GoodsMainVO;
import biz.admin.model.OrderMainVO;
import biz.admin.model.SalesStateMainVO;
import framework.admin.util.AdminSessionUtil;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.admin.service
* - 파일명		: AdminServiceImpl.java
* - 작성일		: 2017. 6. 29.
* - 작성자		: Administrator
* - 설명			: 관리자 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class AdminServiceImpl implements AdminService {

	@Autowired	private AdminDao adminDao;

	@Override
	public List<SalesStateMainVO> listSalesStateMain() {
		return adminDao.listSalesStateMain();
	}

	@Override
	public List<OrderMainVO> listOrderMain() {
		return adminDao.listOrderMain();
	}

	@Override
	public List<OrderMainVO> listOrderMainNc() {
		return adminDao.listOrderMainNc(AdminSessionUtil.getSession().getCompNo());
	}

	@Override
	public List<OrderMainVO> listClaimMain() {
		return adminDao.listClaimMain();
	}

	@Override
	public List<OrderMainVO> listClaimMainNc() {
		return adminDao.listClaimMainNc(AdminSessionUtil.getSession().getCompNo());
	}
	
	@Override
	public List<GoodsMainVO> listGoodsMain() {
		return adminDao.listGoodsMain();
	}

	@Override
	public List<GoodsMainVO> listGoodsMainNc() {
		return adminDao.listGoodsMainNc(AdminSessionUtil.getSession().getCompNo());
	}

}

