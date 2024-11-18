package biz.app.system.service;

import java.util.List;

import biz.app.system.model.BbsBasePO;
import biz.app.system.model.BbsBaseVO;
import biz.app.system.model.BbsGbPO;
import biz.app.system.model.BbsGbSO;
import biz.app.system.model.BbsGbVO;
import biz.app.system.model.BbsLetterDispPO;
import biz.app.system.model.BbsLetterDispSO;
import biz.app.system.model.BbsLetterDispVO;
import biz.app.system.model.BbsLetterGoodsSO;
import biz.app.system.model.BbsLetterGoodsVO;
import biz.app.system.model.BbsLetterHistVO;
import biz.app.system.model.BbsLetterPO;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.model.BbsPocVO;
import biz.app.system.model.BbsReplyPO;
import biz.app.system.model.BbsReplySO;
import biz.app.system.model.BbsReplyVO;
import biz.app.system.model.BbsSO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface BoardService {

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 글 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BbsBaseVO> pageBoardBase(BbsSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 글 상세
	 * </pre>
	 * @param po
	 */
	public BbsBaseVO getBoardBase(BbsSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분 목록 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BbsGbVO> listBoardGb(BbsGbSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 글 등록 / 구분자 리스트 등록
 	 * </pre>
	 * @param po
	 * @param gbPO
	 */
	public void insertBoardBase(BbsBasePO po, List<BbsGbPO> listPO);


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 글 수정 / 구분자 리스트 등록
	 * </pre>
	 * @param po
	 * @param gbPo
	 */
	public void updateBoardBase(BbsBasePO basePo, List<BbsGbPO> listPO);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 글 삭제
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 */
	public void deleteBoardBase(BbsBasePO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분자 삭제
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 */
	public void deleteBoardGb(BbsGbPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 아이디 중복 체크
	 * </pre>
	 * @param po
	 */
	public int getBbsIdCheck(String bbsId);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시판 글 등록
	 * </pre>
	 * @param so
	 * @return
	*/
	public void insertBbsLetter(BbsLetterPO po);

	public void updateBbsLetter(BbsLetterPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2017. 02. 10.
	* - 작성자		: xerowiz@naver.com
	* - 설명		: Bbs Next/Prev 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> listFlickBbsLetter(BbsLetterSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 게시 글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> pageBbsLetter(BbsLetterSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 입점제휴문의 팝업 
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsPopupDetail(BbsLetterSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 게시글 구분자 상세 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsGbVO> listBbsGb(BbsGbSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 게시 글 상세
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsLetter(BbsLetterSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 게시 글 답글 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsReplyVO> listBoardReply(BbsReplySO bbsReplySO);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: phy
	* - 설명		: FAQ 자주하는 질문 TOP 10
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> listBbsLetterTop(BbsLetterSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: Administrator
	* - 설명		: 스토리 게시판 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsBaseVO> listBbsBase(BbsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: Administrator
	* - 설명		: 스토리 게시판 상세
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsDetail(BbsLetterSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: Administrator
	* - 설명		: 스토리 댓글 목록
	* </pre>
	* @param brso
	* @return
	*/
	public List<BbsReplyVO> pageBbsReply(BbsReplySO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: Administrator
	* - 설명		: 스토리 조회수 증가
	* </pre>
	* @param so
	*/
	void updateBbsLetterHits(BbsLetterPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: Administrator
	* - 설명		: 스토리 목록 이전글 다음글 목록
	* </pre>
	* @param brso
	* @return
	*/
	public BbsLetterVO listBbsPrev(BbsLetterSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO listBbsNext(BbsLetterSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: Administrator
	* - 설명		: 스토리 댓글 업데이트
	* </pre>
	* @param so
	*/
	void updateBbsReply(BbsReplyPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: Administrator
	* - 설명		: 스토리 댓글 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void insertBbsReply(BbsReplyPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 5. 17
	* - 작성자		: eojo
	* - 설명		: 게시 글 답글 삭제
	* </pre>
	* @param so
	* @return
	*/
	public int deleteBbsReply(BbsReplyPO bbsReplyPO);

	public void deleteBoardLetter(BbsLetterPO po);
	
 
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: Administrator
	* - 설명		: 댓글 카운트
	* </pre>
	* @param so
	* @return
	*/
	public Integer getReplyCnt(BbsReplySO brso);
	/**
	 * 게시판 관련 상품 삭제 및 등록  
	 * @param po
	 */
	public void deleteInsertBbsLetterGoods(BbsLetterPO po);
	
	/**
	 * 게시판 상품목록 그리드  
	 * @param so
	 * @return
	 */
	public List<BbsLetterGoodsVO> listBbsLetterGoods(BbsLetterGoodsSO so);
	
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 게시 글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterDispVO> bbsLetterDispList(BbsLetterDispSO so);

	/**
	 * <pre> 
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시판 글 등록
	 * </pre>
	 * @param so
	 * @return
	*/ 
	public void insertBbsLetterDisp(  BbsLetterDispPO po,String bbsId);
	/**
	 * <pre> 
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: BoardService.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시판 글 등록
	 * </pre>
	 * @param so
	 * @return
	*/ 
	public void deleteBbsLetterDisp(  BbsLetterDispPO po,String bbsId);
	
	/**
	 * <pre> 
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BoardService.java
	 * - 작성일	: 2017. 03. 14
	 * - 작성자	: hg.jeong
	 * - 설명		: 메인 > 동영상, 매거진
	 * </pre>
	 * @param bbsId
	 * @return
	*/ 	
	public List<BbsLetterVO> getBoardMainList(String bbsId);

	/**
	 * <pre> 
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명	: BoardService.java
	 * - 작성일	: 2020. 12. 30
	 * - 작성자	: 이지희
	 * - 설명		: 게시글 등록 이력 조회
	 * </pre>
	 * @param so
	 * @return
	 */ 	
	public BbsLetterHistVO getBbsLetterHist(BbsLetterSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2021. 01. 05.
	 * - 작성자		: 이지희
	 * - 설명		: 공지사항 POC 등록
	 * </pre>
	 * @param list
	 * @return
	 */
	public void insertLetterPoc(List<BbsPocVO> list) ;

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2021. 01. 05.
	 * - 작성자		: 이지희
	 * - 설명		: 공지사항 POC 삭제
	 * </pre>
	 * @param list
	 * @return
	 */
	public void deleteLetterPoc(List<BbsPocVO> list) ;
}