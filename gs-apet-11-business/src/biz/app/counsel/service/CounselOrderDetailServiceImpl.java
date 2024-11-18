package biz.app.counsel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.counsel.dao.CounselOrderDetailDao;
import biz.app.counsel.model.CounselOrderDetailVO;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.service
* - 파일명		: CounselOrderDetailServiceImpl.java
* - 작성일		: 2017. 6. 9.
* - 작성자		: Administrator
* - 설명			:
* </pre>
*/
@Slf4j
@Transactional
@Service("counselOrderDetailService")
public class CounselOrderDetailServiceImpl implements CounselOrderDetailService {

	@Autowired
	private CounselOrderDetailDao counselOrderDetailDao;

	/*
	 * 상담 주문 목록 조회
	 * @see biz.app.counsel.service.CounselOrderDetailService#listCounselOrderDetail(java.lang.Long)
	 */
	@Override
	public List<CounselOrderDetailVO> listCounselOrderDetail(Long cusNo) {
		return this.counselOrderDetailDao.listCounselOrderInfo(cusNo);
	}



	
}