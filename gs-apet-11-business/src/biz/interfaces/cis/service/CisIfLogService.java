package biz.interfaces.cis.service;

import java.util.List;

import biz.interfaces.cis.model.CisIfLogPO;
import biz.interfaces.cis.model.CisIfLogSO;
import biz.interfaces.cis.model.CisIfLogVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.interfaces.cis.service
 * - 파일명		: CisService.java
 * - 작성일		: 2021. 1. 15.
 * - 작성자		: kek01
 * - 설명		: CIS IF LOG 서비스
 * </pre>
 */
public interface CisIfLogService {

	/**
	 * CIS IF LOG 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertCisIfLog(CisIfLogPO param);
	
	/**
	 * CIS IF LOG 수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateCisIfLog(CisIfLogPO param);
	
	/**
	 * CIS IF Log 삭제
	 * @param po
	 * @return
	 */
	public int deleteCisIfLog(CisIfLogPO param);
	
	/**
	 * CIS IF Log 조회
	 * @param so
	 * @return
	 */
	public List<CisIfLogVO> pageCisIfLogList(CisIfLogSO param);

	/**
	 * CIS IF LOG 등록
	 * @param cisApiId
	 * @param reqString
	 * @param step
	 * @return
	 */
	public Long insertCisIfLog(String cisApiId, String reqString, String step);
	
	/**
	 * CIS IF LOG 수정
	 * @param cisApiId
	 * @param resString
	 * @param step
	 * @param resCd
	 * @param resMsg
	 * @param statusCd
	 * @param logNo
	 * @return
	 * @throws Exception
	 */
	public Long updateCisIfLog(String cisApiId, String resString, String step, String resCd, String resMsg, String statusCd, Long logNo) throws Exception;
	
	/**
	 * CIS IF LOG 등록 한번으로 로그남길때 사용
	 * @param cisApiId
	 * @param reqString
	 * @param resString
	 * @param step
	 * @param resCd
	 * @param resMsg
	 * @param httpStatusCd
	 * @param sysReqStartDtm
	 * @return
	 * @throws Exception
	 */
	public Long insertCisIfLogOne(String cisApiId, String reqString, String resString, String step, String resCd, String resMsg, String httpStatusCd, String sysReqStartDtm) throws Exception;
}
