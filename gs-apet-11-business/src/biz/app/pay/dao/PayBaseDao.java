package biz.app.pay.dao;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PayIfLogVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.dao
* - 파일명		: PayBaseDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 DAO
* </pre>
*/
@Repository
public class PayBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "payBase.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 1. 13.
	* - 작성자		: snw
	* - 설명			: 결제 기본 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertPayBase( PayBasePO po ) {
		
		//Bank CODE 처리
		if(StringUtils.isNotEmpty(po.getBankCd()) && !"null".equals(po.getBankCd())) {
			if(StringUtils.isNumeric(po.getBankCd())) {
				if(Integer.valueOf(po.getBankCd()) < 100 && po.getBankCd().length() == 3) {
					po.setBankCd(po.getBankCd().substring(1));
				}
			}
		}
		
		return insert( BASE_DAO_PACKAGE + "insertPayBase", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: updatePayBaseApproval
	 * - 작성일		: 2021. 04. 27.
	 * - 작성자		: sorce
	 * - 설명			: 결제정보 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePayBaseApproval( PayBasePO po ) {
		
		//Bank CODE 처리
		if(StringUtils.isNotEmpty(po.getBankCd()) && !"null".equals(po.getBankCd())) {
			if(StringUtils.isNumeric(po.getBankCd())) {
				if(Integer.valueOf(po.getBankCd()) < 100 && po.getBankCd().length() == 3) {
					po.setBankCd(po.getBankCd().substring(1));
				}
			}
		}
		
		return insert( BASE_DAO_PACKAGE + "updatePayBaseApproval", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 결제 목록 조회
	* </pre>
	* @param orderSO
	* @return
	*/
	public List<PayBaseVO> listPayBase( PayBaseSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listPayBase", so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 결제 완료
	* </pre>
	* @param po
	* @return
	*/
	public int updatePayBaseComplete(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "updatePayBaseComplete", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: snw
	* - 설명			: 결제 환불 완료
	* </pre>
	* @param po
	* @return
	*/
	public int updatePayBaseRefundComplete(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "updatePayBaseRefundComplete", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: snw
	* - 설명			: 결제 정보 취소
	* </pre>
	* @param po
	* @return
	*/
	public int updatePayBaseCancel(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "updatePayBaseCancel", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 정보 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public PayBaseVO getPayBase( PayBaseSO so ) {
		return (PayBaseVO) selectOne( BASE_DAO_PACKAGE + "getPayBase", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.dao
	 * - 작성일		: 2021. 03. 12.
	 * - 작성자		: JinHong
	 * - 설명		: 결제 환불 에러 처리
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePayBaseRefundError(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "updatePayBaseRefundError", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.dao
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 입금 확인 완료 처리
	 * </pre>
	 * @param po
	 * @return
	 */
	public int confirmDepositInfo(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "confirmDepositInfo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.dao
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 결제 페이지 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PayBaseVO> pagePayBase(PayBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pagePayBase", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: PayBaseDao.java
	* - 작성일	: 2021. 5. 13.
	* - 작성자 	: valfac
	* - 설명 		: 결제 체크(전액 포인트 결제인지 확인)
	* </pre>
	*
	* @param so
	* @return
	*/
	public PayBaseVO checkOrgPayBase( PayBaseSO so ) {
		return (PayBaseVO) selectOne( BASE_DAO_PACKAGE + "checkOrgPayBase", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: insertPayIfLog
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: sorce
	 * - 설명			: PG log
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer insertPayIfLog( PayIfLogVO vo ) {
		return insert( BASE_DAO_PACKAGE + "insertPayIfLog", vo );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseDao.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: hjh
	* - 설명			: 가상계좌 미입금 메세지 전송 여부 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updatePayBaseNdpstMsgSendYn(PayBasePO po){
		return update(BASE_DAO_PACKAGE + "updatePayBaseNdpstMsgSendYn", po);
	}
	
}
