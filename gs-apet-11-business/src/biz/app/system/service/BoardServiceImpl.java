package biz.app.system.service;

import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.BoardDao;
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
import biz.common.model.AttachFilePO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpFileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Autowired
	private BizService bizService;

	@Override
	@Transactional(readOnly=true)
	public List<BbsBaseVO> pageBoardBase(BbsSO so) {
		return boardDao.pageBoardBase(so);
	}

	@Override
	public BbsBaseVO getBoardBase(BbsSO so) {
		return boardDao.getBoardBase(so);
	}

	@Override
	public List<BbsGbVO> listBoardGb(BbsGbSO so) {
		return boardDao.listBoardGb(so);
	}

	@Override
	public void insertBoardBase(BbsBasePO po, List<BbsGbPO> listPO){

		//파일 사용 여부가 'N'일때 입력 값 초기화
		if(AdminConstants.FL_USE_YN_N.equals(po.getFlUseYn())){
			po.setAtchFlCnt(null);
			po.setUploadExt(null);
		}
		
		//이미지 등록
		
		if(!StringUtil.isEmpty(po.getBbsImgPath() ) ) {
			
			String  strBbsId = po.getBbsId();
			String realImgPath = AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + String.valueOf(strBbsId ) + FileUtil.SEPARATOR;
			String fileNm = null;
			
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			
			fileNm = String.format("%s.%s", String.valueOf(strBbsId ), FilenameUtils.getExtension(po.getBbsImgPath()  ));
			ftpImgUtil.upload(po.getBbsImgPath(), realImgPath + fileNm );	// 원본 이미지 FTP 복사 
			try {
				FileUtil.delete(po.getBbsImgPath()  );	// 복사된 이미지 삭제.. [temp]
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			po.setBbsImgPath(realImgPath + fileNm );
		}
				
		
		int result = boardDao.insertBoardBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		//구분 사용여부가 'Y'일때 구분자 등록(insert)
		if(AdminConstants.GB_USE_YN_Y.equals(po.getGbUseYn())) {
			if(listPO != null) {
				for(BbsGbPO bbsInGbPO : listPO){
					bbsInGbPO.setBbsId(po.getBbsId());
					result = boardDao.insertBoardGb(bbsInGbPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}

	@Override
	public void updateBoardBase(BbsBasePO basePo, List<BbsGbPO> listPO){

		//파일 사용 여부가 'N'일때 입력 값 초기화
		if(AdminConstants.FL_USE_YN_N.equals(basePo.getFlUseYn())){
			basePo.setAtchFlCnt(null);
			basePo.setUploadExt(null);
		}
		
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		// 이미지등록
		if(ftpImgUtil.tempFileCheck(basePo.getBbsImgPath())){
			String  strBbsId = basePo.getBbsId();
			String realImgPath = AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + String.valueOf(strBbsId ) + FileUtil.SEPARATOR;
			String fileNm = null;
			
			fileNm = String.format("%s.%s", String.valueOf(strBbsId ), FilenameUtils.getExtension(basePo.getBbsImgPath()  ));
			ftpImgUtil.upload(basePo.getBbsImgPath(), realImgPath + fileNm );	// 원본 이미지 FTP 복사 
			try {
				FileUtil.delete(basePo.getBbsImgPath()  );	// 복사된 이미지 삭제.. [temp]
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			basePo.setBbsImgPath(realImgPath + fileNm );
		}

		boardDao.updateBoardBase(basePo);

		//구분 사용 여부가 'Y'일때 구분자 다시 등록
		if(AdminConstants.GB_USE_YN_Y.equals(basePo.getGbUseYn())
				&& listPO != null) {
			for(BbsGbPO bbsInGbPO : listPO){
				bbsInGbPO.setBbsId(basePo.getBbsId());
				int result = boardDao.insertBoardGb(bbsInGbPO);
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

	@Override
	public void deleteBoardBase(BbsBasePO po) {

		//게시판 관리 글 전체 삭제시 - 게시판 글 있는지 체크
		int cnt = boardDao.selectBoardCheck(po);

		if(cnt > 0){
			throw new CustomException(ExceptionConstants.ERROR_BOARD_FAIL);
		}

		int result = boardDao.deleteBoardBase(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteBoardGb(BbsGbPO po) {

		// 게시판 글 있는지 카운트 체크
		int cnt = boardDao.selectBoardGbCheck(po);
		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_BOARD_FAIL);
		}

		int result = boardDao.deleteBoardGb(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public int getBbsIdCheck(String bbsId) {
		return boardDao.getBbsIdCheck(bbsId);
	}

	@Transactional
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertBbsLetter(BbsLetterPO po){
		BbsSO so = new BbsSO();
		so.setBbsId(po.getBbsId());
		BbsBaseVO vo = getBoardBase(so);

//		if(AdminConstants.USE_YN_Y.equals(vo.getFlUseYn())){
//			Long flNo = bizService.getSequence(AdminConstants.SEQUENCE_ATTACH_FILE_SEQ);
//			po.setFlNo(flNo);
//
//			if(StringUtil.isNotBlank(po.getArrFileStr())){
//				JsonUtil jsonUtil = new JsonUtil();
//				List<AttachFilePO> list = jsonUtil.toArray(AttachFilePO.class, po.getArrFileStr());
//				FtpFileUtil ftpFileUtil = new FtpFileUtil();
//				if(list != null && !list.isEmpty()) {
//					for(AttachFilePO filePO : list) {
//						filePO.setFlNo(flNo);
//						String filePath = ftpFileUtil.uploadFilePath(filePO.getPhyPath(), AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + flNo);
//						ftpFileUtil.upload(filePO.getPhyPath(), filePath);
//						filePO.setPhyPath(filePath);
//						bizService.insertAttachFile(filePO);
//					}
//				}
//			}
//		}

//		FtpImgUtil ftpImgUtil = new FtpImgUtil();
//		if(ftpImgUtil.tempFileCheck(po.getImgPath())){
//			String filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + po.getLettNo());
//			ftpImgUtil.upload(po.getImgPath(), filePath);
//			po.setImgPath(filePath);
//		}
		
		FtpFileUtil fileUtil = new FtpFileUtil();
		if(StringUtil.isNotBlank(po.getFilePath())){
			Long flNo = bizService.getSequence(AdminConstants.SEQUENCE_ATTACH_FILE_SEQ);
			po.setFlNo(flNo);
			String filePath = fileUtil.uploadFilePath(po.getFilePath(), AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + po.getLettNo());
			fileUtil.upload(po.getFilePath(), filePath);
				
			log.info("asdsadasdads : " + filePath);
			if(StringUtil.isNotBlank(filePath)) {
				AttachFilePO filePO = new AttachFilePO();
				filePO.setFlNo(flNo);
				filePO.setPhyPath(filePath);
				filePO.setOrgFlNm(po.getFileName());
				bizService.insertAttachFile(filePO);
			}
		}
		

		if(AdminConstants.USE_YN_N.equals(vo.getGbUseYn())){
			po.setBbsGbNo(null);
		}
		if(AdminConstants.USE_YN_N.equals(vo.getScrUseYn())){
			po.setScrYn(AdminConstants.USE_YN_N);
		}
		po.setHits(0L);
		po.setOpenYn(AdminConstants.USE_YN_Y);
		int result = boardDao.insertBbsLetter(po);
		po.setHistGb(CommonConstants.BBS_INSERT); 
		int result2 = boardDao.insertBbsLetterHist(po);
		if(result == 0 || result2 == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		if(AdminConstants.USE_YN_Y.equals(po.getGoodsUseYn()) ){
			deleteInsertBbsLetterGoods(po);
		}
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void updateBbsLetter(BbsLetterPO po) {
		BbsSO so = new BbsSO();
		so.setBbsId(po.getBbsId());
		BbsBaseVO vo = getBoardBase(so);
		BbsLetterSO bbsLetterSO = new BbsLetterSO();
		bbsLetterSO.setBbsId(po.getBbsId());
		bbsLetterSO.setLettNo(po.getLettNo());
		BbsLetterVO bbsLetterVO = getBbsLetter(bbsLetterSO);

//		if(AdminConstants.USE_YN_Y.equals(vo.getFlUseYn())
//				&& StringUtil.isNotBlank(po.getArrFileStr())){
//			JsonUtil jsonUtil = new JsonUtil();
//			List<AttachFilePO> list = jsonUtil.toArray(AttachFilePO.class, po.getArrFileStr());
//			FtpFileUtil ftpFileUtil = new FtpFileUtil();
//			if(list != null && !list.isEmpty()) {
//				for(AttachFilePO filePO : list) {
//					if(ftpFileUtil.tempFileCheck(filePO.getPhyPath())) {
//						filePO.setFlNo(bbsLetterVO.getFlNo());
//						String filePath = ftpFileUtil.uploadFilePath(filePO.getPhyPath(), AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + bbsLetterVO.getFlNo());
//						ftpFileUtil.upload(filePO.getPhyPath(), filePath);
//						filePO.setPhyPath(filePath);
//						bizService.insertAttachFile(filePO);
//					}
//				}
//			}
//		}

		FtpFileUtil fileUtil = new FtpFileUtil();
		if(StringUtil.isNotBlank(po.getFilePath())){
			String filePath = fileUtil.uploadFilePath(po.getFilePath(), AdminConstants.BOARD_IMAGE_PATH + FileUtil.SEPARATOR + po.getLettNo());
			fileUtil.upload(po.getFilePath(), filePath);
				
			if(StringUtil.isNotBlank(filePath)) {
				AttachFilePO filePO = new AttachFilePO();
				filePO.setFlNo(bbsLetterVO.getFlNo());
				filePO.setPhyPath(filePath);
				filePO.setOrgFlNm(po.getFileName());
				bizService.insertAttachFile(filePO);
			}
		}

		if(AdminConstants.USE_YN_N.equals(vo.getGbUseYn())){
			po.setBbsGbNo(null);
		}
		if(AdminConstants.USE_YN_N.equals(vo.getScrUseYn())){
			po.setScrYn(AdminConstants.USE_YN_N);
		}
		po.setHits(0L);
		po.setOpenYn(AdminConstants.USE_YN_Y);
		int result = boardDao.updateBbsLetter(po);
		
		po.setHistGb(CommonConstants.BBS_UPDATE); 
		boardDao.insertBbsLetterHist(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if(AdminConstants.USE_YN_Y.equals(po.getGoodsUseYn()) ){
			deleteInsertBbsLetterGoods(po);
		}
		
		
		
	}
	
	@Override
	public List<BbsLetterVO> listFlickBbsLetter(BbsLetterSO so) {
		return boardDao.listFlickBbsLetter(so);
	}

	/* 게시판 글 목록
	 * @see biz.app.system.service.BoardService#pageBbsLetter(biz.app.system.model.BbsInLetterSO)
	 */
	@Override
	public List<BbsLetterVO> pageBbsLetter(BbsLetterSO so) {
		return boardDao.pageBbsLetter(so);
	}
	
	/* 입점제휴문의 팝업
	 * @see biz.app.system.service.BoardService#pageBbsLetter(biz.app.system.model.BbsInLetterSO)
	 */
	@Override
	public BbsLetterVO getBbsPopupDetail(BbsLetterSO so) {
		return boardDao.getBbsPopupDetail(so);
	}
	
	

	/* 게시판 구분 목록
	 * @see biz.app.system.service.BoardService#listBbsGb(biz.app.system.model.BbsInGbSO)
	 */
	@Override
	public List<BbsGbVO> listBbsGb(BbsGbSO so) {
		return boardDao.listBbsGb(so);
	}

	@Override
	public BbsLetterVO getBbsLetter(BbsLetterSO so) {
		return boardDao.getBbsLetter(so);
	}

	@Override
	public List<BbsReplyVO> listBoardReply(BbsReplySO bsReplySO) {
		return boardDao.listBoardReply(bsReplySO);
	}

	/* FAQ 자주하는 질문 TOP 10
	 * @see biz.app.system.service.BoardService#listBbsLetterTop(biz.app.system.model.BbsLetterSO)
	 */
	@Override
	public List<BbsLetterVO> listBbsLetterTop(BbsLetterSO so) {
		return boardDao.listBbsLetterTop(so);
	}

	/* 스토리 게시판 목록
	 * @see biz.app.system.service.BoardService#listBbsBase(biz.app.system.model.BbsInSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<BbsBaseVO> listBbsBase(BbsSO so){

		return this.boardDao.listBbsBase(so);
	}

	/* 스토리 게시판 상세
	 * @see biz.app.system.service.BoardService#getBbsDetail(biz.app.system.model.BbsLetterSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public BbsLetterVO getBbsDetail(BbsLetterSO so){

		return this.boardDao.getBbsDetail(so);
	}

	/* 스토리 댓글 목록
	 * @see biz.app.system.service.BoardService#pageBbsLetter(biz.app.system.model.BbsReplySO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<BbsReplyVO> pageBbsReply(BbsReplySO so) {
		return boardDao.pageBbsReply(so);
	}

	/* 스토리 게시판 조회 수 업데이트
	 * @see biz.app.system.service.BoardService#updateBbsLetterHits(biz.app.system.model.BbsLetterPO)
	 */
	@Override
	public void updateBbsLetterHits(BbsLetterPO po) {
		int result = this.boardDao.updateBbsLetterHits(po);

		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/* 스토리 이전글 다음글 목록
	 * @see biz.app.system.service.BoardService#listBbsPrev(biz.app.system.model.BbsLetterSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public BbsLetterVO listBbsPrev(BbsLetterSO so){

		return this.boardDao.listBbsPrev(so);
	}

	/* (non-Javadoc)
	 * @see biz.app.system.service.BoardService#listBbsNext(biz.app.system.model.BbsLetterSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public BbsLetterVO listBbsNext(BbsLetterSO so){

		return this.boardDao.listBbsNext(so);
	}

	/* (스토리 댓글 업데이트)
	 * @see biz.app.system.service.BoardService#updateBbsReply(biz.app.system.model.BbsReplyPO)
	 */
	@Override
	public void updateBbsReply(BbsReplyPO po) {
		int result = this.boardDao.updateBbsReply(po);

		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void insertBbsReply(BbsReplyPO po) {
		int result = this.boardDao.insertBbsReply(po);

		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public int deleteBbsReply(BbsReplyPO bbsReplyPO) {
		bbsReplyPO.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());
		return boardDao.deleteBbsReply(bbsReplyPO);
	}

	@Transactional
	@Override
	public void deleteBoardLetter(BbsLetterPO po) {

		BbsReplyPO bbsReplyPO = new BbsReplyPO();
		bbsReplyPO.setLettNo(po.getLettNo());

		bbsReplyPO.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());

		boardDao.deleteBbsReply(bbsReplyPO); // 답변글 삭제
		
		po.setHistGb(CommonConstants.BBS_DELETE);
		boardDao.insertBbsLetterHist(po);
		int result = boardDao.deleteBoardLetter(po);  // 게시글 삭제

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	@Transactional(readOnly=true)
	public Integer getReplyCnt(BbsReplySO brso){

		return this.boardDao.getReplyCnt(brso);
	}
	
	/**
	 * 게시판 관련 상품 삭제 및 등록
	 */
	@Override 
	public void deleteInsertBbsLetterGoods(BbsLetterPO po) {
		 
		if(AdminConstants.USE_YN_Y.equals(po.getGoodsUseYn()) ){
				
			BbsLetterGoodsPO insertBbsLetterGoodsPO = new BbsLetterGoodsPO();
			insertBbsLetterGoodsPO.setLettNo(po.getLettNo());
			
			boardDao.deleteBbsLetterGoods(insertBbsLetterGoodsPO);
			
			if(po.getArrGoodsId() != null && po.getArrGoodsId().length > 0){
				int dispPriorRank = 1 ;
				for(String goodsId : po.getArrGoodsId()) {
					
					BbsLetterGoodsPO bbsLetterGoodsPO = new BbsLetterGoodsPO();
					bbsLetterGoodsPO.setLettNo(po.getLettNo());
					bbsLetterGoodsPO.setGoodsId(goodsId);
					bbsLetterGoodsPO.setDispPriorRank(dispPriorRank); 
					int result = boardDao.insertBbsLetterGoods(bbsLetterGoodsPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					dispPriorRank++;
				} 
			}
		}
	}
	/**
	 * 게시판상품 목록 그리드 
	 */
	@Override
	@Transactional(readOnly=true)
	public List<BbsLetterGoodsVO> listBbsLetterGoods( BbsLetterGoodsSO so) {
		return boardDao.listBbsLetterGoods(so);
	}
	
	/** 게시글 전시우선순위목록 */ 
	@Override
	public List<BbsLetterDispVO> bbsLetterDispList(BbsLetterDispSO so) {
		return boardDao.bbsLetterDispList(so);
	}
	
	/** 게시글 전시우선순위등록 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertBbsLetterDisp( BbsLetterDispPO  po, String bbsId) {
		
		List<BbsLetterDispPO> listPo = po.getBbsLetterDispPOList();
		
		if(listPo != null && !listPo.isEmpty()) {
			for(BbsLetterDispPO insertPO : listPo) {
				BbsLetterDispPO deletePo = new BbsLetterDispPO();
				deletePo.setBbsId(bbsId);
				deletePo.setLettNo(insertPO.getLettNo() );
				boardDao.deleteBbsLetterDisp(deletePo);
				
				int result = boardDao.insertBbsLetterDisp(insertPO);
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		 
	}
	/** 게시글 전시우선순위 삭제*/
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteBbsLetterDisp( BbsLetterDispPO  po, String bbsId) {
		
		List<BbsLetterDispPO> listPo = po.getBbsLetterDispPOList();
		
		if(listPo != null && !listPo.isEmpty()) {
			for(BbsLetterDispPO deletePo : listPo) {
				deletePo.setBbsId(bbsId);
				int result = boardDao.deleteBbsLetterDisp(deletePo);
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		 
	}
	
	/* 메인 전시 게시판 글 목록 */
	@Override
	public List<BbsLetterVO> getBoardMainList(String bbsId) {
		return boardDao.getBoardMainList(bbsId);
	}

	/* 게시판 이력 조회 */
	@Override
	public BbsLetterHistVO getBbsLetterHist(BbsLetterSO so) {
		return boardDao.getBbsLetterHist(so); 
	}

	/* 공지사항 POC 등록*/
	@Override
	public void insertLetterPoc(List<BbsPocVO> list) {
		boardDao.insertLetterPoc(list);
	}

	/* 공지사항 POC 삭제*/
	@Override
	public void deleteLetterPoc(List<BbsPocVO> list) {
		boardDao.deleteLetterPoc(list); 
	}
	
	
}