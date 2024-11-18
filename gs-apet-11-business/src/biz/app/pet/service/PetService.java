package biz.app.pet.service;

import java.util.List;

import biz.app.member.model.MemberBasePO;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetDaPO;
import biz.app.pet.model.PetDaVO;
import biz.app.pet.model.PetInclRecodePO;
import biz.app.pet.model.PetInclRecodeSO;
import biz.app.pet.model.PetInclRecodeVO;

public interface PetService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: 조은지
	 * - 설명			: 펫 목록 리스트
	 * </pre>
	 * @param so
	 * @return List<PetBaseVO>
	 */
	public List<PetBaseVO> listPetBase(PetBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: 조은지
	 * - 설명			: 접종내역 리스트
	 * </pre>
	 * @param so
	 * @return List<PetInclRecodeVO>
	 */
	public List<PetInclRecodeVO> pagePetInclRecode(PetBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 1. 18.
	 * - 작성자		: 조은지
	 * - 설명			: 펫 정보
	 * </pre>
	 * @param so
	 * @return PetBaseVO
	 */
	public PetBaseVO getPetInfo(PetBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 1. 22.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 등록
	 * </pre>
	 * @param po
	 * @param daPo
	 * @return Long
	 */
	public Long insertPet(PetBasePO po, PetDaPO daPo, String deviceGb);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 수정
	 * </pre>
	 * @param po
	 * @param daPo
	 * @return int
	 */
	public int updatePet(PetBasePO po, PetDaPO daPo, String deviceGb);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 삭제 
	 * </pre>
	 * @param po
	 * @param daPo
	 * @return int
	 */
	public int deletePet(PetBasePO po, PetDaPO daPo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 질환 리스트
	 * </pre>
	 * @param so
	 * @return List<PetDaVO>
	 */
	public List<PetDaVO> selectPetDa(PetBaseSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business 
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: 조은지
	 * - 설명			: 회원의 기본 반려동물 update
	 * </pre>
	 * @param po
	 * @return
	 */
	public String updateMemberDlgtPetGbCd(MemberBasePO po); 
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business 
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 17
	 * - 작성자		: 김명섭
	 * - 설명			: 반려동물 예방접종 내역
	 * </pre>
	 * @param so
	 * @return
	 */
	
	public List<PetInclRecodeVO> petInclRecodeList(PetInclRecodeSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: kms
	 * - 설명			: 예방접종 등록 / 수정
	 * </pre>
		@param po
		@return
	 */
	public Long insertMyPetInclRecode(PetInclRecodePO po , String deviceGb);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 상세
	 * </pre>
		@param so
		@return
	 */
	public PetInclRecodeVO getMyPetInclRecode(PetInclRecodeSO so);
	
	 /**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: PetService.java
	 * - 작성일		: 2021. 2. 24.
	 * - 작성자		: kms
	 * - 설명			: 예방 접종 기록 삭제
	 * </pre>
	 	@param so
	 	@return
	 */
	public int deleteMyPetInclRecode(PetInclRecodePO po);

	public int appPetImageUpdate(PetBasePO po);
	
	public int appInclPetImageUpdate(PetInclRecodePO po);
	
	public String getPetNos(PetBaseSO so);
}
