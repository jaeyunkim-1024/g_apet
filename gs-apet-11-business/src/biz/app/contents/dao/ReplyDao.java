package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ContentsReplyPO;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.dao
 * - 파일명		: ReplyDao.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 콘텐츠 댓글 관리 DAO
 * </pre>
 */
@Repository
public class ReplyDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "reply.";

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> listApetReplyGrid(ContentsReplySO so) {
		return selectListPage(BASE_DAO_PACKAGE+"listApetReplyGrid", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public ContentsReplyVO getApetReply(ContentsReplySO so) {
		return selectOne(BASE_DAO_PACKAGE+"getApetReply", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> listPetLogReplyGrid(ContentsReplySO so) {
		return selectListPage(BASE_DAO_PACKAGE+"listPetLogReplyGrid", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public ContentsReplyVO getPetLogReply(ContentsReplySO so) {
		return selectOne(BASE_DAO_PACKAGE+"getPetLogReply", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateApetReplyContsStat(ContentsReplyPO po) {
		return update(BASE_DAO_PACKAGE+"updateApetReplyContsStat", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePetLogReplyContsStat(ContentsReplyPO po) {
		return update(BASE_DAO_PACKAGE+"updatePetLogReplyContsStat", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertApetReply(ContentsReplyPO po) {
		return insert(BASE_DAO_PACKAGE+"insertApetReply", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateApetReply(ContentsReplyPO po) {
		return update(BASE_DAO_PACKAGE+"updateApetReply", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteApetReply(ContentsReplyPO po) {
		return update(BASE_DAO_PACKAGE+"deleteApetReply", po);
	}
	
	public List<ContentsReplyVO> listMemberReply(ContentsReplySO so){return selectListPage(BASE_DAO_PACKAGE + "listMemberReply",so);}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> pageApetReplyRptp(ContentsReplySO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageApetReplyRptp", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> pagePetLogReplyRptp(ContentsReplySO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pagePetLogReplyRptp", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 수 초기화
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getApetReplyRptpCnt(ContentsReplyPO po) {
		return selectOne(BASE_DAO_PACKAGE+"getApetReplyRptpCnt", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getPetLogReplyRptpCnt(ContentsReplyPO po) {
		return selectOne(BASE_DAO_PACKAGE+"getPetLogReplyRptpCnt", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 수 초기화
	 * </pre>
	 * @param po
	 * @return
	 */
	public int apetReplyRptpCntRefresh(ContentsReplyPO po) {
		return delete(BASE_DAO_PACKAGE+"apetReplyRptpCntRefresh", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 수 초기화
	 * </pre>
	 * @param po
	 * @return
	 */
	public int petLogReplyRptpCntRefresh(ContentsReplyPO po) {
		return delete(BASE_DAO_PACKAGE+"petLogReplyRptpCntRefresh", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글의 회원 번호 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<Long> listApetReplyMbrNo(ContentsReplyPO po) {
		return selectList(BASE_DAO_PACKAGE+"listApetReplyMbrNo", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyDao.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글의 회원 번호 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<Long> listPetLogReplyMbrNo(ContentsReplyPO po) {
		return selectList(BASE_DAO_PACKAGE+"listPetLogReplyMbrNo", po);
	}

}
