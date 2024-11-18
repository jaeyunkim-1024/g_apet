package biz.app.petlog.service;

import java.util.List;

import org.springframework.ui.ModelMap;

import biz.app.display.model.DisplayCornerItemVO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseVO;
import biz.app.petlog.model.FollowMapPO;
import biz.app.petlog.model.FollowMapVO;
import biz.app.petlog.model.PetLogBasePO;
import biz.app.petlog.model.PetLogBaseSO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogInterestPO;
import biz.app.petlog.model.PetLogListSO;
import biz.app.petlog.model.PetLogMemberSO;
import biz.app.petlog.model.PetLogMemberVO;
import biz.app.petlog.model.PetLogReplyPO;
import biz.app.petlog.model.PetLogReplyVO;
import biz.app.petlog.model.PetLogRptpPO;
import biz.app.petlog.model.PetLogSharePO;



public interface PetLogService {

	
	public PetLogBaseVO getPetLogDetail(PetLogBaseSO so);	
	
	public List<PetLogBaseVO> pagePetLogBase (PetLogListSO so );

	public Long insertPetLogBase(PetLogBasePO po);	
	
	public Long updatePetLogBase(PetLogBasePO po);
//	
	public void deletePetLogBase(PetLogBasePO po, String callGb);

	public Long insertPetLogReply(PetLogReplyPO po);
	
	public Long updatePetLogReply(PetLogReplyPO po);
	
	public void deletePetLogReply(PetLogReplyPO po);
	
	public Long insertPetLogRptp(PetLogRptpPO po);
	
	public int insertPetLogInterest(PetLogInterestPO po);
	
	public int deletePetLogInterest(PetLogInterestPO po);
	
	public Long insertPetLogShare(PetLogSharePO po);
	
	public PetLogMemberVO getMbrBaseInfo(PetLogMemberSO so);

	public List<DisplayCornerTotalVO> getPetLogHomeByDispCorn(Long dispClsfNo, PetLogListSO lso);
	
	public List<PetLogReplyVO> listPetLogReply (PetLogBaseSO so );
	
	public List<PetLogBaseVO> listFollowPetLog (PetLogListSO so );
	
	public List<String> listTagNoByDispCorn (PetLogListSO so );
	
	public String getBannerTextByDispCorn (DisplayCornerSO so );
	
	public List<PetLogBaseVO> pageFollowPetLog (PetLogListSO so );
	
	public List<PetLogBaseVO> pageTagPetLog (PetLogListSO so);

	public int getPetLogInterestCount(PetLogInterestPO po);
	
	public int insertFollowMapMember(FollowMapPO po);
		
	public int deleteFollowMapMember(FollowMapPO po);		
	
	public int insertFollowMapTag(FollowMapPO po);
	
	public int deleteFollowMapTag(FollowMapPO po);		
		
	public String isFollowMapMember(FollowMapPO po);
	
	public String isFollowMapTag(FollowMapPO po);
	
	public List<PetLogBaseVO> listPetLogLike (PetLogListSO so );
	
	public List<PetLogMemberVO> listMyFollower (PetLogListSO so );
	
	public List<FollowMapVO> listMyFollowing(PetLogListSO so );
	
	public int getMyFollowerCnt(PetLogListSO po);
	
	public int getMyFollowingCnt(PetLogListSO po);
	
	public void updateMemberBase(MemberBasePO po);
	
	public List<MemberBaseVO> getNickNameList(String nickNm);
	
	public List<PetLogBaseVO> getListRecMbrPetLogByDispCorn(PetLogListSO lso);
	
	public List<PetLogBaseVO> pagePetLogRecommend (PetLogListSO lso);
	
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalFO(Long dispClsfNo);
	
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMember(PetLogListSO so);
	
	public List<PetLogBaseVO> listRecMbrPetLog(PetLogListSO so , boolean apiSearchYn);

	public PetLogBaseVO getPetLogDeleteInfo(PetLogBasePO plgPO);
	
	public int encCpltYnUpdate(PetLogBasePO po);
	
	public int checkRegPet(Long mbrNo);
	
	public List<PetLogBaseVO> pagePetLogMainList(PetLogListSO so);

	public PetLogBaseVO getPetLogShareInfo(PetLogBaseSO so);
}