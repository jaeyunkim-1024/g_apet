package biz.app.contents.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.contents.dao.ApetAttachFileDao;
import biz.app.contents.dao.ApetContentsConstructDao;
import biz.app.contents.dao.ApetContentsDao;
import biz.app.contents.dao.ApetContentsDetailDao;
import biz.app.contents.dao.ApetContentsGoodsMapDao;
import biz.app.contents.dao.ApetContentsTagMapDao;
import biz.app.contents.dao.EduContsDao;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.ApetContentsConstructPO;
import biz.app.contents.model.ApetContentsDetailPO;
import biz.app.contents.model.ApetContentsDetailSO;
import biz.app.contents.model.ApetContentsDetailVO;
import biz.app.contents.model.ApetContentsGoodsMapPO;
import biz.app.contents.model.ApetContentsTagMapPO;
import biz.app.contents.model.EduContsPO;
import biz.app.contents.model.EduContsSO;
import biz.app.contents.model.EduContsVO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.VodVO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.contents.service
 * - 파일명		: EduContsServiceImpl.java
 * - 작성자		: KKB
 * - 설명		: 교육용컨텐츠 Service Implement
 * </pre>
 */
@Service
@Transactional
public class EduContsServiceImpl implements EduContsService {

	@Autowired
	private EduContsDao eduContsDao;
	
	@Autowired
	private ApetContentsDao apetContentsDao;
	
	@Autowired
	private ApetAttachFileDao apetAttachFileDao;
	
	@Autowired
	private ApetContentsTagMapDao apetContentsTagMapDao;
	
	@Autowired
	private ApetContentsGoodsMapDao apetContentsGoodsMapDao;
	
	@Autowired
	private ApetContentsDetailDao apetContentsDetailDao;
	
	@Autowired
	private ApetContentsConstructDao apetContentsConstructDao;
	
	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private CacheService cacheService;
	
	@Autowired	
	private BizService bizService;
	
	@Autowired	
	private TagService tagService;
	
	@Override
	public List<CodeDetailVO> getEduCtgList(EduContsSO so) {
		List<EduContsVO> stringList = eduContsDao.getEduCtgList(so);
		List<CodeDetailVO> codeList = new ArrayList<CodeDetailVO>() ;
		String grpCd = "";
		if(StringUtil.isNotBlank(so.getEudContsCtgMCd())) { 
			grpCd =  AdminConstants.EUD_CONTS_CTG_S;
		}else if(StringUtil.isNotBlank(so.getEudContsCtgLCd())) {
			grpCd =  AdminConstants.EUD_CONTS_CTG_M;
		}else {
			grpCd =  AdminConstants.EUD_CONTS_CTG_L;
		}
		
		for(EduContsVO code : stringList ) {
			if(StringUtil.isNotBlank(code.getCode())) {
				CodeDetailVO cdvo = cacheService.getCodeCache(grpCd, code.getCode());
				codeList.add(cdvo);
			}			
		}
		return codeList;
	}

	@Override
	public List<EduContsVO> pageEduConts(EduContsSO so) {
		return eduContsDao.pageEduConts(so);
	}

	@Override
	public String insertEduContents(EduContsPO po) {
		int totalRstCnt = 0;
		Long attachFlSeq = 0l;
		Long flNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);

		/**
		 *	Apet 컨텐츠 등록
		 */
		po.setVdGbCd(CommonConstants.VD_GB_10);
		po.setHits(0l);
		po.setFlNo(flNo);
		EduContsSO so = new EduContsSO();
		so.setVdGbCd(CommonConstants.VD_GB_10);
		po.setVdId(bizService.genContentsId(so));
		int contentsResult = apetContentsDao.insertApetContents(po);
		totalRstCnt ++;
		
		/**
		 *	Apet 첨부 파일 등록
		 */
		FtpImgUtil ftpImgUtil = null;
		
		// 썸네일 관련 처리
		int thumbResult = 0;
		if(StringUtil.isNotBlank(po.getThumbImgPath())) { // 썸네일
			ApetAttachFilePO aafpo = new ApetAttachFilePO();			
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_10);
			if(CommonConstants.THUM_AUTO_YN_N.equals(po.getThumAutoYn())) { // 자동추줄이 아닌경우 직접 올린 파일 처리
				ftpImgUtil = new FtpImgUtil();
				String thumbImgPath = ftpImgUtil.uploadFilePath(po.getThumbImgPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
				ftpImgUtil.upload(po.getThumbImgPath(), thumbImgPath);
				aafpo.setPhyPath(thumbImgPath);
			}else { // 자동추출인 경우 받아온path 등록
				aafpo.setPhyPath(po.getThumbImgPath());
			}
			aafpo.setOrgFlNm(po.getThumbImgOrgFlNm());
			aafpo.setFlSz(po.getThumbImgSize());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);
			thumbResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		if(StringUtil.isNotBlank(po.getThumbDownloadUrl())) { // 썸네일 다운로드 URl
			ApetAttachFilePO aafpo = new ApetAttachFilePO();			
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_90);
			aafpo.setPhyPath(po.getThumbDownloadUrl());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			thumbResult += apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		// PC배너
		int bnrPcResult = 0;
		if(StringUtil.isNotBlank(po.getBnrPcPath())) {
			ApetAttachFilePO aafpo = new ApetAttachFilePO();			
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_80);
			ftpImgUtil = new FtpImgUtil();
			String bnrPcPath = ftpImgUtil.uploadFilePath(po.getBnrPcPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
			ftpImgUtil.upload(po.getBnrPcPath(), bnrPcPath);
			aafpo.setPhyPath(bnrPcPath);
			aafpo.setOrgFlNm(po.getBnrPcOrgFlNm());
			aafpo.setFlSz(po.getBnrPcSize());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			bnrPcResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		// 큰배너
		int bnrLResult = 0;
		if(StringUtil.isNotBlank(po.getBnrLPath())) {
			ApetAttachFilePO aafpo = new ApetAttachFilePO();			
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_40);
			ftpImgUtil = new FtpImgUtil();
			String bnrLPath = ftpImgUtil.uploadFilePath(po.getBnrLPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
			ftpImgUtil.upload(po.getBnrLPath(), bnrLPath);
			aafpo.setPhyPath(bnrLPath);
			aafpo.setOrgFlNm(po.getBnrLOrgFlNm());
			aafpo.setFlSz(po.getBnrLSize());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			bnrLResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		// 작은배너
		int bnrSResult = 0;
		if(StringUtil.isNotBlank(po.getBnrSPath())) {
			ApetAttachFilePO aafpo = new ApetAttachFilePO();
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_50);
			ftpImgUtil = new FtpImgUtil();
			String bnrSPath = ftpImgUtil.uploadFilePath(po.getBnrSPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
			ftpImgUtil.upload(po.getBnrSPath(), bnrSPath);
			aafpo.setPhyPath(bnrSPath);
			aafpo.setOrgFlNm(po.getBnrSOrgFlNm());
			aafpo.setFlSz(po.getBnrSSize());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			bnrSResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		// 웹툰
		int webToonResult = 0;
		if(StringUtil.isNotBlank(po.getWebToonPath())) {
			ApetAttachFilePO aafpo = new ApetAttachFilePO();
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_30);
			ftpImgUtil = new FtpImgUtil();
			String webToonPath = ftpImgUtil.uploadFilePath(po.getWebToonPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
			ftpImgUtil.upload(po.getWebToonPath(), webToonPath);
			aafpo.setPhyPath(webToonPath);
			aafpo.setOrgFlNm(po.getWebToonOrgFlNm());
			aafpo.setFlSz(po.getWebToonSize());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			webToonResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		// 영상
		int vodResult = 0;
		if(StringUtil.isNotBlank(po.getVodOutsideVdId())) {
			ApetAttachFilePO aafpo = new ApetAttachFilePO();
			aafpo.setFlNo(flNo);
			aafpo.setSeq(attachFlSeq++);
			aafpo.setContsTpCd(CommonConstants.CONTS_TP_60);
			aafpo.setPhyPath(po.getVodPath());
			aafpo.setOrgFlNm(po.getVodOrgFlNm());
			aafpo.setFlSz(po.getVodSize());
			aafpo.setOutsideVdId(po.getVodOutsideVdId());
			aafpo.setVdLnth(po.getVodVdLnth());
			aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
			vodResult = apetAttachFileDao.insertApetAttachFile(aafpo);
			totalRstCnt ++;
		}
		
		/**
		 *	Apet 컨텐츠 태그 매핑 등록
		 */
		int tagResult = 0;
		for(String tagNo : po.getTagNo()) {
			ApetContentsTagMapPO actmpo = new ApetContentsTagMapPO();
			actmpo.setVdId(po.getVdId());
			actmpo.setTagNo(tagNo);
			tagResult += apetContentsTagMapDao.insertApetContentsTagMap(actmpo);
			totalRstCnt ++;
		}
		
		/**
		 *	Apet 컨텐츠 상품 매핑 등록
		 */
		int goodsResult = 0;
		for(String goodsId : po.getGoodsId()) {
			ApetContentsGoodsMapPO acgmpo = new ApetContentsGoodsMapPO();
			acgmpo.setVdId(po.getVdId());
			acgmpo.setGoodsId(goodsId);
			goodsResult += apetContentsGoodsMapDao.insertApetContentsGoodsMap(acgmpo);
			totalRstCnt ++;
		}
		
		/**
		 *	Apet 컨텐츠 상세 등록
		 */

		int contsDtlResult = 0;
		if(StringUtil.isNotEmpty(po.getStepPath())) {
			for(int i=0 ; i < po.getStepPath().length ; i++) {
				// 영상
				ApetAttachFilePO aafpo = new ApetAttachFilePO();
				Long thisStepflNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);
				aafpo.setFlNo(thisStepflNo);
				aafpo.setSeq(0l);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_60);
				aafpo.setPhyPath(po.getStepPath()[i]);
				aafpo.setOrgFlNm(po.getStepOrgFlNm()[i]);
				aafpo.setFlSz(po.getStepSize()[i]);
				aafpo.setOutsideVdId(po.getStepOutsideVdId()[i]);
				aafpo.setVdLnth(po.getStepVdLnth()[i]);
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				int thisResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				if(thisResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				// 스텝			
				ApetContentsDetailPO acdpo = new ApetContentsDetailPO();
				acdpo.setVdId(po.getVdId());
				acdpo.setStepNo(po.getStepNo()[i]);			
				acdpo.setFlNo(thisStepflNo);
				acdpo.setTtl(po.getStepTtl()[i]);
				acdpo.setDscrt(po.getStepDscrt()[i]);
				contsDtlResult += apetContentsDetailDao.insertApetContentsDetail(acdpo);
				totalRstCnt ++;
				
				// 구성의 설명내 tag 추출 등록
				List<String> tagNos = tagService.insertTagsWithString(po.getStepDscrt()[i]);
			}
		}
		
		/**
		 *	Apet 컨텐츠 구성 등록
		 */
		Long cstrtSeq = 0l;
		// Tip
		int tipResult = 0;
		if(StringUtil.isNotBlank(po.getTipContent())) {
			ApetContentsConstructPO accpo = new ApetContentsConstructPO();
			accpo.setVdId(po.getVdId());
			accpo.setCstrtSeq(cstrtSeq++);
			accpo.setCstrtGbCd(CommonConstants.CSTRT_GB_10);
			accpo.setContent(po.getTipContent());
			tipResult = apetContentsConstructDao.insertApetContentsConstruct(accpo);
			totalRstCnt ++;
		}
		// QnA
		int QnaResult = 0;
		if(StringUtil.isNotEmpty(po.getQnaTtl())) {
			for(int i=0; i<po.getQnaTtl().length ; i++) {			
				ApetContentsConstructPO accpo = new ApetContentsConstructPO();
				accpo.setVdId(po.getVdId());
				accpo.setCstrtSeq(cstrtSeq++);
				accpo.setCstrtGbCd(CommonConstants.CSTRT_GB_20);
				accpo.setTtl(po.getQnaTtl()[i]);
				accpo.setContent(po.getQnaContent()[i]);
				QnaResult += apetContentsConstructDao.insertApetContentsConstruct(accpo);
				totalRstCnt ++;			
			}
		}
		if(totalRstCnt == (contentsResult + thumbResult + bnrPcResult + bnrLResult + bnrSResult + webToonResult + vodResult + tagResult + goodsResult + contsDtlResult + tipResult + QnaResult)) {
			return po.getVdId();
		}
		return "F";
	}

	@Override
	public EduContsVO getEduConts(EduContsSO so) {
		EduContsVO eduConts = eduContsDao.getEduConts(so);
		if(StringUtil.isNotEmpty(eduConts) && !eduConts.getEudContsCtgLCd().equals(CommonConstants.EUD_CONTS_CTG_L_20)) {
			eduConts.setDetailList(apetContentsDetailDao.getApetContentsDetail(so));
			eduConts.setCnstrList(apetContentsConstructDao.getApetContentsConstruct(so));
		}
		return eduConts;
	}

	@Override
	public String updateEduContents(EduContsPO po) {
		/**
		 *	Apet 컨텐츠 이력 정보 이력 저장
		 */
		EduContsSO lstso = new EduContsSO();
		lstso.setVdId(po.getVdId());
		EduContsVO lstvo = getEduConts(lstso);
		Long histNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_HIST_SEQ);
		// Apet 컨텐츠 이력 등록
		lstvo.setHistNo(histNo);
		lstvo.setVdGbCd(CommonConstants.VD_GB_10);
		apetContentsDao.insertApetContentsHist(lstvo);
		// Apet 첨부 파일 이력 등록
		if(lstvo.getFileList() != null) {
			lstvo.getFileList().forEach(v->{
				v.setHistNo(histNo);
				apetAttachFileDao.insertApetAttachFileHist(v);
			});
		}
		// Apet 태그 매핑 이력 등록
		if(lstvo.getTagList() != null) {
			lstvo.getTagList().forEach(v->{
				v.setHistNo(histNo);
				apetContentsTagMapDao.insertApetContentsTagMapHist(v);
			});
		}
		// Apet 상품 매핑 이력 등록
		if(lstvo.getGoodsList() != null) {
			lstvo.getGoodsList().forEach(v->{
				v.setHistNo(histNo);
				apetContentsGoodsMapDao.insertApetContentsGoodsMapHist(v);
			});
		}
		// Apet 컨텐츠 상세 등록
		if(lstvo.getDetailList() != null) {
			lstvo.getDetailList().forEach(v->{
				// 영상
				ApetAttachFileVO lstafvo = new ApetAttachFileVO();
				lstafvo.setHistNo(histNo);
				lstafvo.setFlNo(v.getFlNo());
				lstafvo.setSeq(v.getSeq());
				lstafvo.setContsTpCd(v.getContsTpCd());
				lstafvo.setPhyPath(v.getPhyPath());
				lstafvo.setOrgFlNm(v.getOrgFlNm());
				lstafvo.setFlSz(v.getFlSz());
				lstafvo.setOutsideVdId(v.getOutsideVdId());
				lstafvo.setVdLnth(v.getVdLnth());
				lstafvo.setSysDelYn(CommonConstants.COMM_YN_N);
				apetAttachFileDao.insertApetAttachFileHist(lstafvo);
				// 스텝	
				v.setHistNo(histNo);
				apetContentsDetailDao.insertApetContentsDetailHist(v);
			});
		}
		// Apet 컨텐츠 구성 이력 등록
		if(lstvo.getCnstrList() != null) {
			lstvo.getCnstrList().forEach(v->{
				v.setHistNo(histNo);
				apetContentsConstructDao.insertApetContentsConstructHist(v);
			});
		}
		/**
		 *	Apet 컨텐츠 공통변수 
		 */
		int totalRstCnt = 0;
		Long attachFlSeq = 0l;
		Long flNo = (po.isChkChgFile())? bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ):0;

		/**
		 *	Apet 컨텐츠 수정
		 */
		int contentsResult = 0;
		if(po.isChkChgContents() || po.isChkChgFile()) {
			if(po.isChkChgFile()) po.setFlNo(flNo);
			contentsResult = apetContentsDao.updateApetContents(po);
			totalRstCnt ++;
		}
				
		/**
		 *	Apet 첨부 파일 삭제 및 등록
		 */
		int bnrPcResult = 0;
		int bnrLResult = 0;
		int bnrSResult = 0;
		int webToonResult = 0;
		int vodResult = 0;
		int thumbResult = 0;
		if(po.isChkChgFile()) {
			// 모든 첨부파일 삭제
			EduContsSO so = new EduContsSO();
			so.setVdId(po.getVdId());
			Long delFlNo = eduContsDao.getEduConts(so).getFlNo();			
			ApetAttachFilePO delAafpo = new ApetAttachFilePO();
			delAafpo.setFlNo(delFlNo);
			apetAttachFileDao.deleteApetAttatchFile(delAafpo);
			
			FtpImgUtil ftpImgUtil = null;
			
			// 썸네일 관련 처리
			if(StringUtil.isNotBlank(po.getThumbImgPath())) { // 썸네일
				ApetAttachFilePO aafpo = new ApetAttachFilePO();			
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_10);
				if(CommonConstants.THUM_AUTO_YN_N.equals(po.getThumAutoYn()) && po.getThumbImgPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) { // 자동추줄이 아닌경우 직접 올린 파일 처리
					ftpImgUtil = new FtpImgUtil();
					String thumbImgPath = ftpImgUtil.uploadFilePath(po.getThumbImgPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
					ftpImgUtil.upload(po.getThumbImgPath(), thumbImgPath);
					aafpo.setPhyPath(thumbImgPath);
				}else { // 자동추출인 경우 받아온path 등록
					aafpo.setPhyPath(po.getThumbImgPath());
				}
				aafpo.setOrgFlNm(po.getThumbImgOrgFlNm());
				aafpo.setFlSz(po.getThumbImgSize());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				thumbResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			
			if(StringUtil.isNotBlank(po.getThumbDownloadUrl())) { // 썸네일 다운로드 URl
				ApetAttachFilePO aafpo = new ApetAttachFilePO();			
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_90);
				aafpo.setPhyPath(po.getThumbDownloadUrl());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				thumbResult += apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			
			// PC배너
			if(StringUtil.isNotBlank(po.getBnrPcPath())) {
				ApetAttachFilePO aafpo = new ApetAttachFilePO();			
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_80);
				if(po.getBnrPcPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
					ftpImgUtil = new FtpImgUtil();
					String bnrPcPath = ftpImgUtil.uploadFilePath(po.getBnrPcPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
					ftpImgUtil.upload(po.getBnrPcPath(), bnrPcPath);
					aafpo.setPhyPath(bnrPcPath);
				}else {
					aafpo.setPhyPath(po.getBnrPcPath());
				}
				aafpo.setOrgFlNm(po.getBnrPcOrgFlNm());
				aafpo.setFlSz(po.getBnrPcSize());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				bnrPcResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			
			// 큰배너			
			if(StringUtil.isNotBlank(po.getBnrLPath())) {
				ApetAttachFilePO aafpo = new ApetAttachFilePO();			
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_40);
				if(po.getBnrLPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
					ftpImgUtil = new FtpImgUtil();
					String bnrLPath = ftpImgUtil.uploadFilePath(po.getBnrLPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
					ftpImgUtil.upload(po.getBnrLPath(), bnrLPath);
					aafpo.setPhyPath(bnrLPath);
				}else {
					aafpo.setPhyPath(po.getBnrLPath());
				}
				aafpo.setOrgFlNm(po.getBnrLOrgFlNm());
				aafpo.setFlSz(po.getBnrLSize());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				bnrLResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			
			// 작은배너			
			if(StringUtil.isNotBlank(po.getBnrSPath())) {
				ApetAttachFilePO aafpo = new ApetAttachFilePO();
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_50);
				if(po.getBnrSPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
					ftpImgUtil = new FtpImgUtil();
					String bnrSPath = ftpImgUtil.uploadFilePath(po.getBnrSPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
					ftpImgUtil.upload(po.getBnrSPath(), bnrSPath);
					aafpo.setPhyPath(bnrSPath);
				}else {
					aafpo.setPhyPath(po.getBnrSPath());
				}
				aafpo.setOrgFlNm(po.getBnrSOrgFlNm());
				aafpo.setFlSz(po.getBnrSSize());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				bnrSResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			
			// 웹툰			
			if(StringUtil.isNotBlank(po.getWebToonPath())) {
				ApetAttachFilePO aafpo = new ApetAttachFilePO();
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_30);
				if(po.getWebToonPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
					ftpImgUtil = new FtpImgUtil();
					String webToonPath = ftpImgUtil.uploadFilePath(po.getWebToonPath(), CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + po.getVdId() + FileUtil.SEPARATOR + aafpo.getContsTpCd());
					ftpImgUtil.upload(po.getWebToonPath(), webToonPath);
					aafpo.setPhyPath(webToonPath);
				}else {
					aafpo.setPhyPath(po.getWebToonPath());
				}
				aafpo.setOrgFlNm(po.getWebToonOrgFlNm());
				aafpo.setFlSz(po.getWebToonSize());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				webToonResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
			// 영상			
			if(StringUtil.isNotBlank(po.getVodPath())) {
				ApetAttachFilePO aafpo = new ApetAttachFilePO();
				aafpo.setFlNo(flNo);
				aafpo.setSeq(attachFlSeq++);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_60);
				aafpo.setPhyPath(po.getVodPath());
				aafpo.setOrgFlNm(po.getVodOrgFlNm());
				aafpo.setFlSz(po.getVodSize());
				aafpo.setOutsideVdId(po.getVodOutsideVdId());
				aafpo.setVdLnth(po.getVodVdLnth());
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				vodResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				totalRstCnt ++;
			}
		}
		
		/**
		 *	Apet 컨텐츠 태그 매핑 삭제 및 등록
		 */
		int tagResult = 0;
		if(po.isChkChgTag()) {
			// 삭제
			ApetContentsTagMapPO delActmpo = new ApetContentsTagMapPO();
			delActmpo.setVdId(po.getVdId());
			apetContentsTagMapDao.deleteApetContentsTagMap(delActmpo);
			
			// 등록
			for(String tagNo : po.getTagNo()) {
				ApetContentsTagMapPO actmpo = new ApetContentsTagMapPO();
				actmpo.setVdId(po.getVdId());
				actmpo.setTagNo(tagNo);
				tagResult += apetContentsTagMapDao.insertApetContentsTagMap(actmpo);
				totalRstCnt ++;
			}
		}		
		
		/**
		 *	Apet 컨텐츠 상품 매핑 삭제 및 등록
		 */
		int goodsResult = 0;
		if(po.isChkChgGoods()) {
			// 삭제
			ApetContentsGoodsMapPO delAcgmpo = new ApetContentsGoodsMapPO();
			delAcgmpo.setVdId(po.getVdId());
			apetContentsGoodsMapDao.deleteApetContentsGoodsMap(delAcgmpo);
			
			// 등록
			for(String goodsId : po.getGoodsId()) {
				ApetContentsGoodsMapPO acgmpo = new ApetContentsGoodsMapPO();
				acgmpo.setVdId(po.getVdId());
				acgmpo.setGoodsId(goodsId);
				goodsResult += apetContentsGoodsMapDao.insertApetContentsGoodsMap(acgmpo);
				totalRstCnt ++;
			}
		}
		
		/**
		 *	Apet 컨텐츠 상세 및 등록
		 */

		int contsDtlResult = 0;
		if(po.isChkChgDetail()) {
			// 영상 삭제
			EduContsSO ecso = new EduContsSO();
			ecso.setVdId(po.getVdId());
			List<ApetContentsDetailVO> acdList = apetContentsDetailDao.getApetContentsDetail(ecso);
			for(ApetContentsDetailVO acdvo : acdList) {		
				ApetAttachFilePO delAafpo = new ApetAttachFilePO();
				delAafpo.setFlNo(acdvo.getFlNo());
				apetAttachFileDao.deleteApetAttatchFile(delAafpo);
			}			
			
			// 스텝 삭제
			ApetContentsDetailPO delAcdpo = new ApetContentsDetailPO();
			delAcdpo.setVdId(po.getVdId());
			apetContentsDetailDao.deleteApetContentsDetail(delAcdpo);
			
			for(int i=0 ; i < po.getStepPath().length ; i++) {
				// 영상 등록
				ApetAttachFilePO aafpo = new ApetAttachFilePO();
				Long thisStepflNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);
				aafpo.setFlNo(thisStepflNo);
				aafpo.setSeq(0l);
				aafpo.setContsTpCd(CommonConstants.CONTS_TP_60);
				aafpo.setPhyPath(po.getStepPath()[i]);
				aafpo.setOrgFlNm(po.getStepOrgFlNm()[i]);
				aafpo.setFlSz(po.getStepSize()[i]);
				aafpo.setOutsideVdId(po.getStepOutsideVdId()[i]);
				aafpo.setVdLnth(po.getStepVdLnth()[i]);
				aafpo.setSysDelYn(CommonConstants.COMM_YN_N);			
				int thisResult = apetAttachFileDao.insertApetAttachFile(aafpo);
				if(thisResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				// 스텝 등록	
				ApetContentsDetailPO acdpo = new ApetContentsDetailPO();
				acdpo.setVdId(po.getVdId());
				acdpo.setStepNo(po.getStepNo()[i]);			
				acdpo.setFlNo(thisStepflNo);
				acdpo.setTtl(po.getStepTtl()[i]);
				acdpo.setDscrt(po.getStepDscrt()[i]);
				contsDtlResult += apetContentsDetailDao.insertApetContentsDetail(acdpo);
				totalRstCnt ++;
				
				// 구성의 설명내 tag 추출 등록
				List<String> tagNos = tagService.insertTagsWithString(po.getStepDscrt()[i]);
			}
		}
		
		/**
		 *	Apet 컨텐츠 구성 삭제 및 등록
		 */
		Long cstrtSeq = 0l;
		int tipResult = 0;
		int QnaResult = 0;
		
		if(po.isChkChgConstruct()) {
			// 삭제
			ApetContentsConstructPO delAccpo = new ApetContentsConstructPO();
			delAccpo.setVdId(po.getVdId());
			apetContentsConstructDao.deleteApetContentsConstruct(delAccpo);
			
			// Tip
			if(StringUtil.isNotBlank(po.getTipContent())) {
				ApetContentsConstructPO accpo = new ApetContentsConstructPO();
				accpo.setVdId(po.getVdId());
				accpo.setCstrtSeq(cstrtSeq++);
				accpo.setCstrtGbCd(CommonConstants.CSTRT_GB_10);
				accpo.setContent(po.getTipContent());
				tipResult = apetContentsConstructDao.insertApetContentsConstruct(accpo);
				totalRstCnt ++;
			}
			// QnA
			
			if(StringUtil.isNotEmpty(po.getQnaTtl())) {
				for(int i=0; i<po.getQnaTtl().length ; i++) {			
					ApetContentsConstructPO accpo = new ApetContentsConstructPO();
					accpo.setVdId(po.getVdId());
					accpo.setCstrtSeq(cstrtSeq++);
					accpo.setCstrtGbCd(CommonConstants.CSTRT_GB_20);
					accpo.setTtl(po.getQnaTtl()[i]);
					accpo.setContent(po.getQnaContent()[i]);
					QnaResult += apetContentsConstructDao.insertApetContentsConstruct(accpo);
					totalRstCnt ++;			
				}
			}
		}
		if(totalRstCnt == (contentsResult + thumbResult + bnrPcResult + bnrLResult + bnrSResult + webToonResult + vodResult + tagResult + goodsResult + contsDtlResult + tipResult + QnaResult)) {
			return po.getVdId();
		}
		return "F";
	}
	
	@Override
	public ApetContentsDetailVO getPetTvContsHistory(ApetContentsDetailSO so) {		
		ApetContentsDetailVO hisVo = new ApetContentsDetailVO();
		hisVo =  eduContsDao.getApetContentsWatchHist(so);		
		return hisVo;
	}
	
	@Override
	public VodVO getInterestYn(EduContsSO so) {		
		VodVO vo =  eduContsDao.getInterestYn(so);		
		return vo;
	}
	
	@Override
	public String getMyPetYn(EduContsSO so) {		
		String interestYn = "N";		
		interestYn =  eduContsDao.getMyPetYn(so);		
		return interestYn;
	}
	
	@Override
	public List<VodVO> getApetContentsList(EduContsSO so) {
		List<VodVO> vo = eduContsDao.getApetContentsList(so);		
		return vo;
	}
	
	@Override
	public int saveContsInterest(ApetContentsDetailPO po, String deleteYn) {
		if(deleteYn.equals("Y")) {
			return eduContsDao.deleteContsInterest(po);			
		}else {
			return eduContsDao.saveContsInterest(po);
		}		
	}
	
	@Override
	public List<PetLogBaseVO> listPetSchoolCatch(PetLogMgmtSO so) {
		List<PetLogBaseVO> list = eduContsDao.listPetSchoolCatch(so);
		 if(list != null && !list.isEmpty()) {
            for(PetLogBaseVO vo : list){
                //로그인 아이디 복호화
            	String decId = bizService.twoWayDecrypt(vo.getLoginId());
            	//마스킹
            	decId = MaskingUtil.getId(decId);
                vo.setLoginId(decId);	                
            }		
		 }
		return eduContsDao.listPetSchoolCatch(so);		
	}
	
	@Override
	public int saveContsHit(EduContsPO po) {
		return eduContsDao.saveContsHit(po);	
	}
	
	@Override
	public int saveSrtUrl(EduContsPO po) {
		return eduContsDao.saveSrtUrl(po);	
	}
}