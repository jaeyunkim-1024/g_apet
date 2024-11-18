package biz.app.claim.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailStatusHistPO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimSO;
import biz.app.order.model.OrderBaseVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.dao
* - 파일명		: ClaimDetailDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 클레임 상세 DAO
* </pre>
*/
@Repository
public class ClaimDetailDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "claimDetail.";

	@Autowired private ClaimDetailStatusHistDao claimDetailStatusHistDao;

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 1. 13.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertClaimDetail( ClaimDetailPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertClaimDetail", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimDetail( ClaimDetailSO so) {
		return selectList( BASE_DAO_PACKAGE + "listClaimDetail", so );
	}
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listClaimDetail2ndE
	 * - 작성일		: 2021. 04. 19.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 상태 리스트
	 * </pre>
	 * @param claimSO
	 * @return
	 */
	public OrderBaseVO listClaimDetail2ndE(ClaimSO claimSO) {
		return selectOne( BASE_DAO_PACKAGE + "listClaimDetail2ndE", claimSO );
	}
		
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 신청완료 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimExchangeDetail( ClaimDetailSO so) {
		return selectList( BASE_DAO_PACKAGE + "listClaimExchangeDetail", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 상태 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateClaimDetailStatus( ClaimDetailPO po ) {
		int rtn = update( BASE_DAO_PACKAGE + "updateClaimDetailStatus", po );
		if (rtn > 0 && po.getClmDtlStatCd() != null && !"".equals(po.getClmDtlStatCd())){
			ClaimDetailStatusHistPO cdshpo = new ClaimDetailStatusHistPO();
			cdshpo.setClmNo(po.getClmNo());
			cdshpo.setClmDtlSeq(po.getClmDtlSeq());
			//interface 에서 클레임상태 이력테이블에 추가시 필요해서 추가. 2017/06/20 hjko
			//cdshpo.setSysRegrNo(po.getSysRegrNo());
			this.claimDetailStatusHistDao.insertClaimDetailStatusHist(cdshpo);
		}
		return rtn;
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 3. 27.
	* - 작성자		: snw
	* - 설명			: 배송비 번호 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateClaimDetailDlvrcNo(ClaimDetailPO po ){
		return update( BASE_DAO_PACKAGE + "updateClaimDetailDlvrcNo", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2017. 3. 27.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public ClaimDetailVO getClaimDetail( ClaimDetailSO so ) {
		return selectOne(BASE_DAO_PACKAGE + "getClaimDetail", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2021. 2. 19.
	* - 작성자		: kek01
	* - 설명			: 클레임 상세 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateClaimDetail(ClaimDetailPO po ){
		return update( BASE_DAO_PACKAGE + "updateClaimDetail", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2021. 2. 25.
	* - 작성자		: 
	* - 설명			: 클레임 상세 사진 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertImgClaimDetail( ClaimDetailPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertImgClaimDetail", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2021. 5. 06.
	* - 작성자		: 
	* - 설명			: 클레임 번호로 클레임 상세 사진 저장
	* </pre>
	* @param po
	* @return
	*/
	public int saveImgClaimDetailFromClmNo( ClaimDetailPO po ) {
		return insert( BASE_DAO_PACKAGE + "saveImgClaimDetailFromClmNo", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailDao.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: ljj
	* - 설명			: 클레임 상세사유 이미지 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimDetailImage( ClaimDetailSO so) {
		return selectList( BASE_DAO_PACKAGE + "listClaimDetailImage", so );
	}

}
