package biz.app.adjustment.service;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.adjustment.dao.AdjustmentDao;
import biz.app.adjustment.model.AdjustmentSO;
import biz.app.adjustment.model.AdjustmentVO;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.adjustment.service
* - 파일명		: AdjustmentServiceImpl.java
* - 작성일		: 2016. 8. 31.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
@Slf4j
@Transactional
@Service("adjustmentService")
public class AdjustmentServiceImpl implements AdjustmentService {

	@Autowired
	private AdjustmentDao adjustmentDao;


	@Override
	public List<AdjustmentVO> listCompAdjustmentDtl (AdjustmentSO adjustmentSO ) {
		return adjustmentDao.listCompAdjustmentDtl(adjustmentSO );
	}


	@Override
	public List<AdjustmentVO> listCompAdjustment (AdjustmentSO adjustmentSO ) {
		return adjustmentDao.listCompAdjustment(adjustmentSO );
	}


	@Override
	public List<AdjustmentVO> listPageAdjustment(AdjustmentSO adjustmentSO) {
		return adjustmentDao.listPageAdjustment(adjustmentSO );
	}


	@Override
	public List<AdjustmentVO> listPageAdjustmentDtl(AdjustmentSO adjustmentSO ) {
		return adjustmentDao.listPageAdjustmentDtl(adjustmentSO );
	}



}
