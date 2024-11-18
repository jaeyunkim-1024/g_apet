package biz.app.petlog.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.display.model.DisplayCornerItemVO;
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
import biz.app.petlog.model.PetLogMentionMemberPO;
import biz.app.petlog.model.PetLogMentionMemberSO;
import biz.app.petlog.model.PetLogMentionMemberVO;
import biz.app.petlog.model.PetLogReplyPO;
import biz.app.petlog.model.PetLogReplyVO;
import biz.app.petlog.model.PetLogRptpPO;
import biz.app.petlog.model.PetLogSharePO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;

@Repository
public class PetLogDao extends MainAbstractDao {

	public static final String BASE_DAO_PACKAGE = "petLog.";
	
	public List<PetLogBaseVO> pagePetLogBase (PetLogListSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pagePetLogBase", so );
	}
	
	public PetLogBaseVO getPetLogDetail(PetLogBaseSO so ) {
		so.setOffset(1);
		return (PetLogBaseVO) selectOne(BASE_DAO_PACKAGE + "pagePetLogBase", so);
	}
	
	public Long getPetLogBaseSeq() {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogBaseSeq");
	}

	public int insertPetLogBase(PetLogBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogBase", po);
	}
	
	
	public int insertPetLogTagMap(PetLogBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogTagMap", po);
	}
	
	public int deletePetLogTagMap(PetLogBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogTagMap", po);
	}
	
	
	public int updatePetLogBase(PetLogBasePO po) {
		return update(BASE_DAO_PACKAGE + "updatePetLogBase", po);
	}
	
	public int deletePetLogBase(PetLogBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogBase", po);
	}
	

	public int insertPetLogBaseDelete(PetLogBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogBaseDelete", po);
	}
	
	
	public int insertPetLogRptp(PetLogRptpPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogRptp", po);
	}
		
	public int deletePetLogRptp(PetLogRptpPO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogRptp", po);
	}
	
	public int insertPetLogReply(PetLogReplyPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogReply", po);
	}
	
	public int updatePetLogReply(PetLogReplyPO po) {
		return update(BASE_DAO_PACKAGE + "updatePetLogReply", po);
	}
	
	public int deletePetLogReply(PetLogReplyPO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogReply", po);
	}
	
	public List<PetLogReplyVO> listPetLogReply (PetLogBaseSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listPetLogReply", so );
	}
	
	
	public int insertPetLogShare(PetLogSharePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogShare", po);
	}
	
	public int deletePetLogShare(PetLogSharePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogShare", po);
	}	
	
	public int insertPetLogInterest(PetLogInterestPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogInterest", po);
	}
	
	public int deletePetLogInterest(PetLogInterestPO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogInterest", po);
	}
	
	public int insertPetLogGoodsReviewMap(PetLogBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogGoodsReviewMap", po);
	}
	
	public int deletePetLogGoodsReviewMap(PetLogBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogGoodsReviewMap", po);
	}
	
	public int insertPetLogRltMap(PetLogBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogRltMap", po);
	}
	
	public int deletePetLogRltMap(PetLogBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogRltMap", po);
	}	
	
	public int insertPetLogMentionMember(PetLogMentionMemberPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogMentionMember", po);
	}
	
	public int deletePetLogMentionMember(PetLogMentionMemberPO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogMentionMember", po);
	}	
	
	public PetLogMemberVO getMbrBaseInfo(PetLogMemberSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMbrBaseInfo", so);
	}
		
	public List<PetLogBaseVO> listLikePetLogByDispCorn(PetLogListSO so){
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}
		return selectListPage(BASE_DAO_PACKAGE + "listLikePetLogByDispCorn", so);
	}
	
	public List<PetLogBaseVO> listRecMbrPetLogByDispCorn(PetLogListSO so){
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}
		return selectListPage(BASE_DAO_PACKAGE + "listRecMbrPetLogByDispCorn", so);
	}
	
	public List<PetLogBaseVO> pageTagPetLog (PetLogListSO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageTagPetLog", so );
	}
	
	public List<PetLogBaseVO> listFollowPetLog (PetLogListSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listFollowPetLog", so );
	}
	
	
	public List<PetLogBaseVO> pageFollowPetLog (PetLogListSO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageFollowPetLog", so );
	}
	
	public List<String> listTagNoByDispCorn (PetLogListSO so ) {
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}
		return selectList(BASE_DAO_PACKAGE + "listTagByDispCorn", so );
	}
	
	public int getPetLogInterestCount(PetLogInterestPO po) {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogInterestCount", po);
	}
	
	public int getPetLogReplyCount(PetLogReplyPO po) {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogReplyCount", po);
	}
	
	public int insertFollowMapMember(FollowMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertFollowMapMember", po);
	}
	
	public int deleteFollowMapMember(FollowMapPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteFollowMapMember", po);
	}
	
	public int insertFollowMapTag(FollowMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertFollowMapTag", po);
	}
	
	public int deleteFollowMapTag(FollowMapPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteFollowMapTag", po);
	}
	
	public String isFollowMapMember(FollowMapPO po) {
		return selectOne(BASE_DAO_PACKAGE + "isFollowMapMember", po);
	}
	
	public String isFollowMapTag(FollowMapPO po) {
		return selectOne(BASE_DAO_PACKAGE + "isFollowMapTag", po);
	}
	
	public List<PetLogMemberVO> listMyFollower (PetLogListSO so ) {		
		return selectList(BASE_DAO_PACKAGE + "listMyFollower", so );
	}
	
	public List<FollowMapVO> listMyFollowing (PetLogListSO so ) {		
		return selectList(BASE_DAO_PACKAGE + "listMyFollowing", so );
	}		
	
	public int getMyFollowerCnt(PetLogListSO po) {
		return selectOne(BASE_DAO_PACKAGE + "getMyFollowerCnt", po);
	}
	
	public int getMyFollowingCnt(PetLogListSO po) {
		return selectOne(BASE_DAO_PACKAGE + "getMyFollowingCnt", po);
	}		
	
	public String isPetLogReport(PetLogRptpPO po) {
		return selectOne(BASE_DAO_PACKAGE + "isPetLogReport", po);
	}
	
	public int updateMemberBase(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBase", po);
	}
	
	public int updatePegLogBaseHits(PetLogBasePO po ) {
		return update(BASE_DAO_PACKAGE + "updatePegLogBaseHits", po);
	}
	
	public PetLogBaseVO getPopularTagNm(PetLogListSO so){ 
		return selectOne(BASE_DAO_PACKAGE + "getPopularTagNm", so);
	}	

	public List<MemberBaseVO> getNickNameList(String nickNm) {
		return selectList(BASE_DAO_PACKAGE + "getNickNameList",nickNm);
	}
	
	public List<DisplayCornerTotalVO> listDisplayClsfCorner(Long dispClsfNo) {
		return selectList(BASE_DAO_PACKAGE + "listDisplayClsfCorner", dispClsfNo);
	}	
	
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMember(PetLogListSO so) {
		return selectList(BASE_DAO_PACKAGE + "listDisplayCornerPetLogMember", so);
	}	
	
	public List<PetLogBaseVO> listRecMbrPetLog(PetLogListSO so){
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}
		return selectList(BASE_DAO_PACKAGE + "listRecMbrPetLog", so);
	}	
	
	public List<String> listadminRecTag (PetLogListSO so ) {
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			so.setPreviewDt(DateUtil.getNowDate());
		}
		return selectList(BASE_DAO_PACKAGE + "listadminRecTag", so );
	}	
	
	public String getFollowTagNm(PetLogBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getFollowTagNm", so);
	}
	
	public PetLogBaseSO getPetLogFlag(PetLogBaseSO so ) {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogFlag", so);
	}
	
	public int encCpltYnUpdate(PetLogBasePO po) {
		return update(BASE_DAO_PACKAGE + "encCpltYnUpdate", po);
	}

	public PetLogBaseVO getPetLogDeleteInfo(PetLogBasePO plgPO) {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogDeleteInfo", plgPO);
	}
	
	public int checkRegPet(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "checkRegPet" , mbrNo);
	}

	public int updatePetLogSrtPathHits(PetLogBasePO po) {
		return update(BASE_DAO_PACKAGE + "updatePetLogSrtPathHits", po);
	}
	public List<PetLogMentionMemberVO> getPetLogMentionMember(PetLogMentionMemberPO po) {
		return selectList(BASE_DAO_PACKAGE + "getPetLogMentionMember", po);
	}
	
	public List<PetLogBaseVO> pagePetLogMainList(PetLogListSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pagePetLogMainList" , so);
	}
	
	public List<PetLogBaseVO> pageNewPetLogMainList(PetLogListSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageNewPetLogMainList" , so);
	}
	
	public int pagePetLogMainListCount(PetLogListSO so) {
		return selectOne(BASE_DAO_PACKAGE + "pagePetLogMainListCount" , so);
	}
	
	public int pageNewPetLogMainListCount(PetLogListSO so) {
		return selectOne(BASE_DAO_PACKAGE + "pageNewPetLogMainListCount" , so);
	}
	
	public int insertPetLogReplyMention(PetLogMentionMemberPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPetLogReplyMention" , po);
	}
	
	public List<PetLogMentionMemberVO> petLogReplyMentionList(PetLogMentionMemberSO so){
		return selectList(BASE_DAO_PACKAGE + "petLogReplyMentionList" , so);	
	}
	
	public int deletePetLogReplyMention(PetLogMentionMemberSO so) {
		return delete(BASE_DAO_PACKAGE + "deletePetLogReplyMention" , so);
	}
}
