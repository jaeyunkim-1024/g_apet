package biz.app.contents.service;

import java.util.List;

import biz.app.contents.model.ContentsReplyPO;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: ReplyService.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 콘텐츠 댓글 관리 서비스 Interface
 * </pre>
 */
public interface ReplyService {
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> listApetReplyGrid(ContentsReplySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public ContentsReplyVO getApetReply(ContentsReplySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> listPetLogReplyGrid(ContentsReplySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public ContentsReplyVO getPetLogReply(ContentsReplySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	public void updateApetReplyContsStat(ContentsReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	public void updatePetLogReplyContsStat(ContentsReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public void saveApetReply(ContentsReplyPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteApetReply(ContentsReplyPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> pageApetReplyRptp(ContentsReplySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyService.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> pagePetLogReplyRptp(ContentsReplySO so);

}
