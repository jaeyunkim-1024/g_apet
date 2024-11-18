package biz.app.claim.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClaimSummaryVO;
import biz.app.order.model.OrderBaseVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.claim.dao
 * - 파일명		: ClaimDao.java
 * - 작성일		: 2016. 4. 4.
 * - 작성자		: dyyoun
 * - 설명		: 클레임 DAO
 * </pre>
 */
@Repository
public class ClaimDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "claim.";

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.claim.dao
	* - 파일명      : ClaimDao.java
	* - 작성일      : 2017. 3. 20.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 주문 관리 > 클레임 관리 > 반품목록
	* </pre>
	 */
	public List<ClaimListVO> pageClaim( ClaimSO claimSO) {
		if(!StringUtil.isBlank(claimSO.getOrdrTel())){
			claimSO.setOrdrTel(claimSO.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(claimSO.getOrdrMobile())){
			claimSO.setOrdrMobile(claimSO.getOrdrMobile().replaceAll("-", ""));
		}
				
		return selectListPage( "claim.pageClaim", claimSO );
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.claim.dao
	* - 파일명      : ClaimDao.java
	* - 작성일      : 2017. 3. 20.
	* - 작성자      : tigerfive
	* - 설명      : 반품목록 (API용)
	* </pre>
	 */
	public List<biz.app.claim.model.interfaces.ClaimListVO> pageClaimInterface( biz.app.claim.model.interfaces.ClaimSO claimSO) {
		if(!StringUtil.isBlank(claimSO.getOrdrTel())){
			claimSO.setOrdrTel(claimSO.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(claimSO.getOrdrMobile())){
			claimSO.setOrdrMobile(claimSO.getOrdrMobile().replaceAll("-", ""));
		}
		
		return selectListPage( "claim.pageClaimInterface", claimSO );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderDao.java
	* - 작성일		: 2016. 6. 8.
	* - 작성자		: phy
	* - 설명			: 취소/교환/반품 현황
	* </pre>
	* @param orderSO
	* @return
	*/
	public ClaimSummaryVO listClaimCdCountList(ClaimSO claimSO) {
		return (ClaimSummaryVO) selectOne(BASE_DAO_PACKAGE + "listClaimCdCountList", claimSO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDao.java
	* - 작성일		: 2017. 3. 1.
	* - 작성자		: 
	* - 설명			: 클레임 목록 조회
	* 					 Front MyOrder에서 사용되는 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimBaseVO> pageClaimCancelRefundList(ClaimSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageClaimCancelRefundList", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: pageClaimCancelRefundList2ndE
	 * - 작성일		: 2021. 04. 17.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderBaseVO> pageClaimCancelRefundList2ndE(ClaimSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageClaimCancelRefundList2ndE", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDao.java
	 * - 작성일		: 2017. 3. 9.
	 * - 작성자		: hongjun
	 * - 설명			: 클레임(환불) 
	* </pre>
	* @param claimSO
	* @return
	*/
	public ClaimBaseVO getClaimRefund(ClaimSO claimSO){
		return selectOne(BASE_DAO_PACKAGE + "getClaimRefund", claimSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDao.java
	 * - 작성일		: 2017. 7. 5.
	 * - 작성자		: hongjun
	 * - 설명			: 클레임(환불 가격) 
	* </pre>
	* @param claimSO
	* @return
	*/
	public ClaimRefundPayVO getClaimRefundPay(ClaimSO claimSO){
		return selectOne(BASE_DAO_PACKAGE + "getClaimRefundPay", claimSO );
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.claim.dao
	* - 파일명      : ClaimDao.java
	* - 작성일      : 2021. 3. 31.
	* - 작성자      : pse
	* - 설명      :홈 > 주문 관리 > 클레임 관리 > 취소/반품/교환 엑셀 다운로드 용 데이터
	* </pre>
	 */
	public List<ClaimListVO> getClaimExcelList( ClaimSO claimSO) {
		if(!StringUtil.isBlank(claimSO.getOrdrTel())){
			claimSO.setOrdrTel(claimSO.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(claimSO.getOrdrMobile())){
			claimSO.setOrdrMobile(claimSO.getOrdrMobile().replaceAll("-", ""));
		}
				
		return selectListPage( "claim.getClaimExcelList", claimSO );
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명	: biz.app.claim.dao
	* - 파일명		: ClaimDao.java
	* - 작성일		: 2021. 8. 09.
	* - 작성자		: lts
	* - 설명		: 클레임 통합 조회
	* </pre>
	 */
	public List<ClaimListVO> pageClaimIntegrateList(ClaimSO claimSO) {
		if(!StringUtil.isBlank(claimSO.getOrdrTel())){
			claimSO.setOrdrTel(claimSO.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(claimSO.getOrdrMobile())){
			claimSO.setOrdrMobile(claimSO.getOrdrMobile().replaceAll("-", ""));
		}
				
		return selectListPage("claim.pageClaimIntegrateList", claimSO);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명	: biz.app.claim.dao
	* - 파일명		: ClaimDao.java
	* - 작성일		: 2021. 8. 10.
	* - 작성자		: LTS
	* - 설명		: 홈 > 주문 관리 > 클레임 통합 조회 > 클레임 통합 조회 목록 엑셀다운
	* </pre>
	 */
	public List<ClaimListVO> getClaimIntegrateExcelList( ClaimSO claimSO) {
		if(!StringUtil.isBlank(claimSO.getOrdrTel())){
			claimSO.setOrdrTel(claimSO.getOrdrTel().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(claimSO.getOrdrMobile())){
			claimSO.setOrdrMobile(claimSO.getOrdrMobile().replaceAll("-", ""));
		}
				
		return selectListPage( "claim.getClaimIntegrateExcelList", claimSO );
	}
}
