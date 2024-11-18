package biz.interfaces.cis.service;

import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.common.service.BizService;
import biz.interfaces.cis.dao.CisIfLogDao;
import biz.interfaces.cis.model.CisIfLogPO;
import biz.interfaces.cis.model.CisIfLogSO;
import biz.interfaces.cis.model.CisIfLogVO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("cisService")
public class CisIfLogServiceImpl implements CisIfLogService{

	@Autowired private CisIfLogDao cisIfLogDao;
	@Autowired private Properties bizConfig;
	@Autowired private BizService bizService;
	
	
	/**
	 * CIS IF LOG 등록
	 */
	@Override
	public int insertCisIfLog(CisIfLogPO param) {
		param.setLogNo(bizService.getSequence(CommonConstants.SEQUENCE_CIS_IF_LOG_NO)); //로그번호생성
		return cisIfLogDao.insertCisIfLog(param);
	};
	
	/**
	 * CIS IF LOG 수정
	 */
	@Override
	public int updateCisIfLog(CisIfLogPO param) {
		return cisIfLogDao.updateCisIfLog(param);
	}
	
	/**
	 * CIS IF Log 삭제
	 */
	@Override
	public int deleteCisIfLog(CisIfLogPO param) {
		return cisIfLogDao.deleteCisIfLog(param);
	}
	
	/**
	 * CIS IF Log 조회
	 */
	@Override
	public List<CisIfLogVO> pageCisIfLogList(CisIfLogSO param){
		return cisIfLogDao.pageCisIfLogList(param);
	}
	
	
	/**
	 * CIS IF LOG 등록
	 */
	@Override
	public Long insertCisIfLog(String cisApiId, String reqString, String step) {
		CisIfLogPO po = new CisIfLogPO();
		po.setLogNo(bizService.getSequence(CommonConstants.SEQUENCE_CIS_IF_LOG_NO)); //로그번호생성
		po.setStep( (StringUtil.isNull(step)? "전송": step) );
		po.setHttpsStatusCd("");
		po.setCisResCd("");
		po.setCisResMsg("");
		po.setRequestUrl(bizConfig.getProperty("cis.api.server") + bizConfig.getProperty("cis.api.request.url." + cisApiId));
		po.setCallId(cisApiId);
		po.setReqJson((StringUtil.isNull(reqString))? "":reqString);
		po.setSysRegDtm(DateUtil.getTimestamp());
		po.setSysReqStartDtm(DateUtil.getNowDateTime());
		
		cisIfLogDao.insertCisIfLog(po);
		return po.getLogNo();
	}
	
	/**
	 * CIS IF LOG 수정
	 */
	@Override
	public Long updateCisIfLog(String cisApiId, String resString, String step, String resCd, String resMsg, String httpStatusCd, Long logNo) throws Exception {
		CisIfLogPO po = new CisIfLogPO();
		po.setLogNo(logNo);
		po.setStep((StringUtil.isNull(step)? "응답완료": step));
		po.setHttpsStatusCd((StringUtil.isNull(httpStatusCd))? "":httpStatusCd);
		po.setCallId(cisApiId);
		po.setSysResDtm(DateUtil.getNowDateTime());
		po.setResJson(resString);
		po.setCisResCd((StringUtil.isNull(resCd))? "":resCd);
		po.setCisResMsg((StringUtil.isNull(resMsg))? "":resMsg);
		po.setSysReqEndDtm(DateUtil.getNowDateTime());

		cisIfLogDao.updateCisIfLog(po);
		return logNo;
	}
	
	/**
	 * CIS IF LOG 등록
	 */
	@Override
	public Long insertCisIfLogOne(String cisApiId, String reqString, String resString, String step, String resCd, String resMsg, String httpStatusCd, String sysReqStartDtm) throws Exception {
		CisIfLogPO po = new CisIfLogPO();
		po.setLogNo(bizService.getSequence(CommonConstants.SEQUENCE_CIS_IF_LOG_NO)); //로그번호생성
		po.setStep((StringUtil.isNull(step)? "응답완료": step));
		po.setHttpsStatusCd((StringUtil.isNull(httpStatusCd))? "":httpStatusCd);
		po.setCisResCd((StringUtil.isNull(resCd))? "":resCd);
		po.setCisResMsg((StringUtil.isNull(resMsg))? "":resMsg);
		po.setRequestUrl(bizConfig.getProperty("cis.api.server") + bizConfig.getProperty("cis.api.request.url." + cisApiId));
		po.setCallId(cisApiId);
		po.setReqJson((StringUtil.isNull(reqString))? "":reqString);
		po.setResJson(resString);
		po.setSysRegDtm(DateUtil.getTimestamp());
		po.setSysReqStartDtm(sysReqStartDtm);
		po.setSysReqEndDtm(DateUtil.getNowDateTime());
		po.setSysResDtm(DateUtil.getNowDateTime());
		
		cisIfLogDao.insertCisIfLogOne(po);
		return po.getLogNo();
	}
	
}
