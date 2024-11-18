package biz.app.contents.service;

import java.util.List;
import biz.app.contents.model.PetLogMgmtVO;
import biz.app.contents.model.PetLogMgmtPO;
import biz.app.contents.model.PetLogMgmtSO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: PetLogService.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 Service
 * </pre>
 */
public interface PetLogMgmtService {

	/**
	 * <pre>펫로그 목록 조회</pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: PetLogService.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 list
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return 
	 */
	public List<PetLogMgmtVO> pagePetLog(PetLogMgmtSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PetLogService.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: valueFactory
	* - 설명			: 펫로그 전시상태 일괄 수정
	* </pre>
	* @param PetLogMgmtPO
	* @return
	*/
	public int updatePetLogStat(List<PetLogMgmtPO> petLogPOList);
	
	/**
	 * <pre>펫로그 목록 조회</pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: PetLogService.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 신고내역 리스트 
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return 
	 */
	public List<PetLogMgmtVO> pagePetLogReport(PetLogMgmtSO so);

}