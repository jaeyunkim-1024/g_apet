package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.BbsBasePO;
import biz.app.system.model.BbsBaseVO;
import biz.app.system.model.BbsGbPO;
import biz.app.system.model.BbsGbSO;
import biz.app.system.model.BbsGbVO;
import biz.app.system.model.BbsLetterDispPO;
import biz.app.system.model.BbsLetterDispSO;
import biz.app.system.model.BbsLetterDispVO;
import biz.app.system.model.BbsLetterGoodsPO;
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
import framework.common.dao.MainAbstractDao;

@Repository
public class BoardDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BbsBaseVO> pageBoardBase(BbsSO so) {
		return selectListPage("board.pageBoardBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 상세
	 * </pre>
	 * @param
	 * @return
	 */
	public BbsBaseVO getBoardBase(BbsSO so) {
		return selectOne("board.getBoardBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertBoardBase(BbsBasePO po) {
		return insert("board.insertBoardBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분자 리스트 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertBoardGb(BbsGbPO po) {
		return insert("board.insertBoardGb", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BbsGbVO> listBoardGb(BbsGbSO so) {
		return selectList("board.listBoardGb", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateBoardBase(BbsBasePO basePo) {
		return update("board.updateBoardBase", basePo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 삭제 (구분자카운트조회)
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 * @return
	 */
	public int deleteBoardBase(BbsBasePO po) {
		return delete("board.deleteBoardBase", po);
	}
	public int selectBoardCheck(BbsBasePO po) {
		return (Integer) selectOne("board.selectBoardCheck",po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 구분자 삭제(게시글카운트조회)
	 * </pre>
	 * @param model
	 * @param displayCornerItemListStr
	 * @return
	 * @return
	 */
	public int deleteBoardGb(BbsGbPO po) {
		return delete("board.deleteBoardGb", po);
	}

	public int selectBoardGbCheck(BbsGbPO po) {
		return (Integer) selectOne("board.selectBoardGbCheck", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 아이디 중복 체크
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getBbsIdCheck(String bbsId) {
		return (int) selectOne("board.getBbsIdCheck", bbsId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41..web
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2016. 04. 14
	 * - 작성자		: eojo
	 * - 설명		: 게시판 관리 > 게시판 글 등록
	 * </pre>
	 * @param so
	 * @return
	*/
	public int insertBbsLetter(BbsLetterPO po) {
		return insert("board.insertBbsLetter", po);
	}

	public int updateBbsLetter(BbsLetterPO po) {
		return update("board.updateBbsLetter", po);
	}
	/**
	 * 게시판 상품 삭제와 등록 
	 * @param po
	 * @return
	 */
	public int deleteBbsLetterGoods(BbsLetterGoodsPO po) {
		return insert("board.deleteBbsLetterGoods", po);
	}
	public int insertBbsLetterGoods(BbsLetterGoodsPO po) {
		return insert("board.insertBbsLetterGoods", po);
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2017. 02. 10.
	* - 작성자		: xerowiz@naver.com
	* - 설명		: Bbs Next/Prev 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> listFlickBbsLetter(BbsLetterSO so) {
		return selectListPage("board.flickBbsLetter", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 게시 글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> pageBbsLetter(BbsLetterSO so) {
		return selectListPage("board.pageBbsLetter", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 입점제휴문의 팝업
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsPopupDetail(BbsLetterSO so) {
		return selectOne("board.getBbsPopupDetail", so);
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명		: 게시 글 상세
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsLetter(BbsLetterSO so) {
		return selectOne("board.getBbsLetter", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 게시글 구분 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsGbVO> listBbsGb(BbsGbSO so) {
		return selectList("board.listBbsGb", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: eojo
	* - 설명		: 게시글 답글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsReplyVO> listBoardReply(BbsReplySO bbsReplySO) {
		return selectList("board.listBoardReply", bbsReplySO);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: phy
	* - 설명		: FAQ 자주하는 질문 TOP 10
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> listBbsLetterTop(BbsLetterSO so) {
		return selectList("board.listBbsLetterTop", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: istrator
	* - 설명		: 스토리 게시판 목록 불러오기
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsBaseVO> listBbsBase(BbsSO so) {
		return selectList("board.listBbsBase", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: istrator
	* - 설명		: 스토리 게시판 상세
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO getBbsDetail(BbsLetterSO so) {
		return selectOne("board.getBbsLetter", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: istrator
	* - 설명		: 스토리 게시판 댓글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsReplyVO> pageBbsReply(BbsReplySO so) {
		return selectListPage("board.pageStoryReply", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 28.
	* - 작성자		: istrator
	* - 설명		: 스토리 게시판 조회 수 업데이트
	* </pre>
	* @param po
	* @return
	*/
	public int updateBbsLetterHits(BbsLetterPO po) {
		return update("board.updateBbsLetterHits", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: istrator
	* - 설명		: 스토리 이전글 다음글 목록
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO listBbsPrev(BbsLetterSO so) {
		return selectOne("board.listBbsPrev", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public BbsLetterVO listBbsNext(BbsLetterSO so) {
		return selectOne("board.listBbsNext", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: istrator
	* - 설명		: 스토리 댓글 등록
	* </pre>
	* @param po
	* @return
	*/
	public int updateBbsReply(BbsReplyPO po) {
		return update("board.updateBbsReply", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: istrator
	* - 설명		: 스토리 댓글 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertBbsReply(BbsReplyPO po) {
		return insert("board.insertBbsReply", po);
	}

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
	public int deleteBbsReply(BbsReplyPO bbsReplyPO) {
		return update("board.deleteBbsReply", bbsReplyPO);
	}

	public int deleteBoardLetter(BbsLetterPO po) {
		return update("board.deleteBoardLetter", po);
	}
	
	public Integer getReplyCnt(BbsReplySO so) {
		return (Integer)selectOne("board.getReplyCnt", so);
	}
	 /**
	  * 게시판상품목록 그리드 
	  * @param so
	  * @return
	  */
	public List<BbsLetterGoodsVO> listBbsLetterGoods(BbsLetterGoodsSO so) {
		return selectList("board.listBbsLetterGoods", so);
	}
	
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 게시 글 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterDispVO> bbsLetterDispList(BbsLetterDispSO so) {
		return selectListPage("board.pageBbsLetterDispList", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 전시우선순위 목록
	* </pre>
	* @param so
	* @return
	*/
	public int deleteBbsLetterDisp(BbsLetterDispPO po) {
		return insert("board.deleteBbsLetterDisp", po);
	}
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: phy
	* - 설명		: 전시우선순위 등록
	* </pre>
	* @param so
	* @return
	*/
	public int insertBbsLetterDisp(BbsLetterDispPO po) {
		return insert("board.insertBbsLetterDisp", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BoardDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 전시 게시판 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<BbsLetterVO> getBoardMainList(String bbsId) {
		return selectList("board.getBoardMainList", bbsId);
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: 이지희
	 * - 설명		: 게시글(공지사항/FAQ) 이력저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertBbsLetterHist(BbsLetterPO po) {
		return insert("board.insertBbsLetterHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BoardDao.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: 이지희
	 * - 설명		: 게시글(공지사항/FAQ) 등록 이력  조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public BbsLetterHistVO getBbsLetterHist(BbsLetterSO so) {
		return selectOne("board.getBbsLetterHist", so);
	}
	
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
	public void insertLetterPoc(List<BbsPocVO> list) {
		insert("board.insertLetterPoc",list);
	}

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
	public void deleteLetterPoc(List<BbsPocVO> list) {
		delete("board.deleteLetterPoc",list);
	}
		
}
