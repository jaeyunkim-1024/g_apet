package biz.app.tv.service;

import java.util.List;

import biz.app.tv.model.TvDetailReplyPO;
import biz.app.tv.model.TvDetailReplyRptpPO;
import biz.app.tv.model.TvDetailReplyRptpSO;
import biz.app.tv.model.TvDetailReplySO;
import biz.app.tv.model.TvDetailReplyVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.tv.service
 * - 파일명		: TvDetailReplyService.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: hjh
 * - 설 명		: 펫TV 상세 댓글 서비스 Interface
 * </pre>
 */
public interface TvDetailReplyService {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectTvDetailReplyList(TvDetailReplySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTvDetailReplyRptp(TvDetailReplyRptpPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveTvDetailReply(TvDetailReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTvDetailReply(TvDetailReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateTvDetailReply(TvDetailReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteTvDetailReply(TvDetailReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록or수정 태그,멘션 존재 시 태그 등록 and APP PUSH 발송
	 * </pre>
	 * @param po
	 * @return
	 */
	public void replyTagMentionPrcs(TvDetailReplyPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 신고 중복 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int tvDetailReplyRptpDupChk(TvDetailReplyRptpSO so);
}
