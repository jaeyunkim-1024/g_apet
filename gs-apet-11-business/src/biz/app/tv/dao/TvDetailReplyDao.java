package biz.app.tv.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.tv.model.TvDetailReplyMentionMbrPO;
import biz.app.tv.model.TvDetailReplyMentionMbrVO;
import biz.app.tv.model.TvDetailReplyPO;
import biz.app.tv.model.TvDetailReplyRptpPO;
import biz.app.tv.model.TvDetailReplyRptpSO;
import biz.app.tv.model.TvDetailReplySO;
import biz.app.tv.model.TvDetailReplyVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.tv.dao
 * - 파일명		: TvDetailReplyDao.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: hjh
 * - 설 명		: 펫TV 상세 댓글 DAO
 * </pre>
 */
@Repository
public class TvDetailReplyDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "tvDetailReply.";
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectTvDetailReplyList(TvDetailReplySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "selectTvDetailReplyList", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTvDetailReplyRptp(TvDetailReplyRptpPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTvDetailReplyRptp", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTvDetailReply(TvDetailReplyPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTvDetailReply", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateTvDetailReply(TvDetailReplyPO po) {
		return update(BASE_DAO_PACKAGE + "updateTvDetailReply", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteTvDetailReply(TvDetailReplyPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTvDetailReply", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고된 댓글 신고수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getTvDetailReplyRptpCnt(TvDetailReplyRptpPO po) {
		return selectOne(BASE_DAO_PACKAGE + "getTvDetailReplyRptpCnt", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고된 댓글 신고 차단
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateTvDetailReplyRptpStat(TvDetailReplyRptpPO po) {
		return update(BASE_DAO_PACKAGE + "updateTvDetailReplyRptpStat", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 신고 중복 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int tvDetailReplyRptpDupChk(TvDetailReplyRptpSO so) {
		return selectOne(BASE_DAO_PACKAGE + "tvDetailReplyRptpDupChk", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고된 댓글의 작성자 회원 번호 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public Long getReplyRptpMbrNo(TvDetailReplyRptpPO po) {
		return selectOne(BASE_DAO_PACKAGE + "getReplyRptpMbrNo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 08. 25.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 영상상세 > 댓글 멘션 회원정보 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<TvDetailReplyMentionMbrVO> selectTvDetailReplyMentionMbrList(TvDetailReplyMentionMbrPO po) {
		return selectList(BASE_DAO_PACKAGE + "selectTvDetailReplyMentionMbrList", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 08. 25.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 영상상세 > 댓글 멘션 회원정보 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTvDetailReplyMentionMbr(TvDetailReplyMentionMbrPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTvDetailReplyMentionMbr", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyDao.java
	 * - 작성일		: 2021. 08. 25.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 영상상세 > 댓글 멘션 회원정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteTvDetailReplyMentionMbr(TvDetailReplyPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTvDetailReplyMentionMbr", po);
	}
}
