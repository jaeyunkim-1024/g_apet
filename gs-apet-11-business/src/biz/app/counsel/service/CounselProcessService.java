package biz.app.counsel.service;

import java.util.List;

import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselProcessSO;
import biz.app.counsel.model.CounselProcessVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.service
* - 파일명		: CounselProcessService.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 상담 처리 서비스 Interface
* </pre>
*/
public interface CounselProcessService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessService.java
	* - 작성일		: 2017. 5. 10.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CounselProcessVO> listCounselProcess(CounselProcessSO so);
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessService.java
	* - 작성일		: 2017. 5. 11.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 등록
	* </pre>
	* @param 	po
	* @param 	lastPrcsYn 최종 처리 완료 여부
	*/
	public void insertCounselProcess(CounselProcessPO po, boolean lastPrcsYn);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessService.java
	* - 작성일		: 2017. 5. 11.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 체크
	* </pre>
	* @param 	so
	*/
	public int checkCounselProcess(CounselProcessSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselProcessService.java
	* - 작성일		: 2017. 5. 11.
	* - 작성자		: Administrator
	* - 설명			: 상담 처리 수정
	* </pre>
	* @param 	po
	*/
	public int updateCounselProcess(CounselProcessPO po);

}