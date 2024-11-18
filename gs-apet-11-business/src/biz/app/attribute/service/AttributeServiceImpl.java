package biz.app.attribute.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.attribute.dao.AttributeDao;
import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.common.dao.BizDao;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("attributeService")
public class AttributeServiceImpl implements AttributeService {

	@Autowired
	private AttributeDao attributeDao;

	@Autowired
	private BizDao bizDao;

	@Override
	public Long insertNewAttribute(AttributePO po){

		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "insertNewAttribute" );
		}
		Long attrNo = null;

		// 속성번호를 미리 할당 받는다.
		//attrNo = bizDao.getSequence(AdminConstants.SEQUENCE_ATTRIBUTE_SEQ );


		if(log.isDebugEnabled() ) {
			log.debug("#################### : " + "속성 등록" );
		}

		Integer idx = attributeDao.insertNewAttribute(po);
		attrNo = po.getAttrNo();
		if(log.isDebugEnabled() ) {
			log.debug("########## attrNo : {}", attrNo );
		}

		if(idx==0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return attrNo;
	}


	@Override
	public List<AttributeVO> checkAttributeExist(AttributePO po){
		List<AttributeVO> result = new ArrayList<>();
		AttributeSO so = new AttributeSO();
		try {
			BeanUtils.copyProperties(so, po);
			result =attributeDao.checkAttributeExist(so );
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		return result;
	}

}
