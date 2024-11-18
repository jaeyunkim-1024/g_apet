package biz.app.system.service;

import java.util.List;

import biz.app.system.model.DepositAcctInfoPO;
import biz.app.system.model.DepositAcctInfoVO;
import biz.app.system.model.DepositAcctInfoSO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.service
 * - 파일명		: DepositAcctInfoService.java
 * - 작성일		: 2017. 2. 9.
 * - 작성자		: snw
 * - 설명		: 무통장 계좌 정보 서비스 Interface
 * </pre>
 */
public interface DepositAcctInfoService {

	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 페이징 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DepositAcctInfoVO> pageDepositAcctInfo(DepositAcctInfoSO so);

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DepositAcctInfoVO> listDepositAcctInfo(DepositAcctInfoSO so);

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 상세 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public DepositAcctInfoVO getDepositAcctInfo(DepositAcctInfoSO so);

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 등록
	 * </pre>
	 * 
	 * @param po
	 */
	public void insertDepositAcctInfo(DepositAcctInfoPO po);

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 수정
	 * </pre>
	 * 
	 * @param po
	 */
	public void updateDepositAcctInfo(DepositAcctInfoPO po);

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 삭제
	 * </pre>
	 * 
	 * @param po
	 */
	public void deleteDepositAcctInfo(DepositAcctInfoPO po);

}