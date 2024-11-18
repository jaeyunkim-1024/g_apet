package biz.app.pet.dao;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetDaPO;
import biz.app.pet.model.PetDaVO;
import biz.app.pet.model.PetInclRecodePO;
import biz.app.pet.model.PetInclRecodeSO;
import biz.app.pet.model.PetInclRecodeVO;
import framework.common.dao.MainAbstractDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import java.util.List;

@Slf4j
@Repository
public class PetDao extends MainAbstractDao {
    private static final String BASE_DAO_PACKAGE = "petBase.";

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 1. 18.
     * - 작성자		: 조은지
     * - 설명			: 펫 목록 
     * </pre>
     * @param so
     * @return List<PetBaseVO>
     */
    public List<PetBaseVO> listPetBase(PetBaseSO so){
        return selectList(BASE_DAO_PACKAGE + "listPetBase",so);
    }

    public List<PetBaseVO> listPetBaseGroupByMbrNo(PetBaseSO so){
        return selectList(BASE_DAO_PACKAGE + "listPetBaseGroupByMbrNo",so);
    }

    public int insertPetBase(PetBasePO po){
        return insert(BASE_DAO_PACKAGE + "insertPetBase",po);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 1. 18.
     * - 작성자		: 조은지
     * - 설명			: 펫 접종내역 페이지 리스트
     * </pre>
     * @param so
     * @return List<PetInclRecodeVO>
     */
    public List<PetInclRecodeVO> pagePetInclRecode(PetBaseSO so){
        return selectListPage(BASE_DAO_PACKAGE + "pagePetInclRecode", so);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 1. 18.
     * - 작성자		: 조은지
     * - 설명			: 펫 상세
     * </pre>
     * @param so
     * @return PetBaseVO
     */
    public PetBaseVO getPetInfo(PetBaseSO so) {
    	return (PetBaseVO) selectOne(BASE_DAO_PACKAGE + "getPetInfo", so);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 1. 22.
     * - 작성자		: 조은지
     * - 설명			: 펫 질환/알러지 등록
     * </pre>
     * @param po
     * @return int
     */
    public int insertPetDa(List<PetDaPO> poList) {
    	return insert(BASE_DAO_PACKAGE + "insertPetDa", poList);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business 
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 2.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 수정
     * </pre>
     * @param po
     * @return
     */
    public int updatePetBase(PetBasePO po) {
    	return update(BASE_DAO_PACKAGE + "updatePetBase", po);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business 
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 2.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 건강수첩 삭제
     * </pre>
     * @param po
     * @return
     */
    public int deletePetInclRecode(PetInclRecodePO po) {
    	return delete(BASE_DAO_PACKAGE + "deletePetInclRecode", po);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business 
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 2.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 질환/알러지 삭제
     * </pre>
     * @param po
     * @return
     */
    public int deletePetDa(PetDaPO po) {
    	return delete(BASE_DAO_PACKAGE + "deletePetDa", po);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 2.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 삭제
     * </pre>
     * @param po
     * @return int
     */
    public int deletePetBase(PetBasePO po) {
    	return delete(BASE_DAO_PACKAGE + "deletePetBase", po);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 8.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 질환 리스트
     * </pre>
     * @param so
     * @return
     */
    public List<PetDaVO> selectPetDa(PetBaseSO so) {
    	return selectList(BASE_DAO_PACKAGE + "selectPetDa", so);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 9.
     * - 작성자		: 조은지
     * - 설명			: 회원 기본 반려동물 등록
     * </pre>
     * @param po
     * @return
     */
    public int updateMemberDlgtPetGbCd(MemberBasePO po) {
    	return update(BASE_DAO_PACKAGE + "updateMemberDlgtPetGbCd", po);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 9.
     * - 작성자		: 조은지
     * - 설명			: 반려동물 카운트
     * </pre>
     * @param so
     * @return
     */
    public int selectPetCnt(PetBaseSO so) {
    	return selectOne(BASE_DAO_PACKAGE + "selectPetCnt", so);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 9.
     * - 작성자		: 조은지
     * - 설명			: 회원 펫로그 URL 조회
     * </pre>
     * @param so
     * @return
     */
    public String selectMemberPetLogUrl(PetBaseSO so) {
    	return selectOne(BASE_DAO_PACKAGE + "selectMemberPetLogUrl", so);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 파일명		: PetDao.java
     * - 작성일		: 2021. 2. 9.
     * - 작성자		: 조은지
     * - 설명			: 회원 펫로그 URL UPDATE
     * </pre>
     * @param po
     * @return
     */
    public int updateMemberPetLogUrl(MemberBasePO po) {
    	return update(BASE_DAO_PACKAGE + "updateMemberPetLogUrl", po);
    }

    
	/**	 * <pre>
	 * - 프로젝트명	: 11.business 
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 17
	 * - 작성자		: 김명섭
	 * - 설명			: 반려동물 예방접종 내역
	 * </pre>
	 * @param so
	 * @return
	 */
    public List<PetInclRecodeVO> petInclRecodeList(PetInclRecodeSO so){
    	return selectListPage(BASE_DAO_PACKAGE + "pagePetInclRecodeFront", so);
    }
    
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetDao.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 등록
	 * </pre>
		@param po
		@return
	 */
    public int insertMyPetInclRecode(PetInclRecodePO po) {
    	return insert(BASE_DAO_PACKAGE + "insertMyPetInclRecode" , po);
    }
    
	 /**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetDao.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 상세
	 * </pre>
	 	@param so
	 	@return
	 */
    public PetInclRecodeVO getMyPetInclRecode(PetInclRecodeSO so) {
    	return selectOne(BASE_DAO_PACKAGE + "getMyPetInclRecode" , so);
    }
    
	 /**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetDao.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 수정
	 * </pre>
	 	@param po
	 	@return
	 */
    public int updateMyPetInclRecode(PetInclRecodePO po) {
    	return update(BASE_DAO_PACKAGE + "updateMyPetInclRecode" , po);
    }
    
	 /**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetDao.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 삭제
	 * </pre>
	 	@param so
	 	@return
	 */
    public int deleteMyPetInclRecode(PetInclRecodePO po) {
    	return delete(BASE_DAO_PACKAGE + "deleteMyPetInclRecode" , po);
    }
    
    public int appPetImageUpdate(PetBasePO po) {
    	return update(BASE_DAO_PACKAGE + "appPetImageUpdate", po);
    }
    
    public int appInclPetImageUpdate(PetInclRecodePO po) {
    	return update(BASE_DAO_PACKAGE + "appInclPetImageUpdate" , po);
    }
    
    public String selectPetNosForSession(PetBaseSO so) {
    	return selectOne(BASE_DAO_PACKAGE + "selectPetNosForSession", so);
    }
    
    public Long selectMaxPetNo() {
    	return selectOne(BASE_DAO_PACKAGE + "selectMaxPetNo");
    }
    
    public List<String> listPetGb(PetBaseSO so) {
    	return selectList(BASE_DAO_PACKAGE + "listPetGb", so);
    }
}
