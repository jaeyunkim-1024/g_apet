package biz.app.counsel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.counsel.dao.CounselDao;
import biz.app.counsel.dao.CounselOrderDetailDao;
import biz.app.counsel.model.CounselOrderDetailPO;
import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselStatusSO;
import biz.app.counsel.model.CounselStatusVO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.model.CsMainVO;
import biz.app.order.model.OrderDetailVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
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
public class CounselServiceImpl implements CounselService {

	@Autowired
	private CacheService cacheService;

	@Autowired
	private CounselDao counselDao;

	@Autowired
	private CounselProcessService counselProcessService;

	@Autowired
	private BizService bizService;

	@Autowired
	private MessageSourceAccessor message;

	@Autowired
	private CounselOrderDetailDao counselOrderDetailDao;

	/*
	 * 상담 목록 조회
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#listCounsel(biz.app.counsel.model.
	 * CounselSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CounselVO> listCounsel(CounselSO so) {
		return this.counselDao.listCounsel(so);
	}

	/*
	 * 상담 목록 페이징 조회
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#pageCounsel(biz.app.counsel.model.
	 * CounselSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CounselVO> pageCounsel(CounselSO so) {

		List<CounselVO> cusList = counselDao.pageCounsel(so);
		
		for(CounselVO cvo : cusList) {
			//문의자 아이디 복호화
			if(StringUtil.isNotEmpty(cvo.getLoginId())) {
				cvo.setLoginId(bizService.twoWayDecrypt(cvo.getLoginId()));
			}
		}

		List<CodeDetailVO> codeList = this.cacheService.listCodeCache(CommonConstants.CUS_CTG1, "N", null, null, null,
				null);

		for (CounselVO ctemp : cusList) {

			if (codeList != null && !codeList.isEmpty()) {
				for (CodeDetailVO code : codeList) {
					// 1:1문의 유형 코드명 저장
					if (ctemp.getCusCtg1Cd().equals(code.getDtlCd())) {
						ctemp.setDtlNm(code.getDtlNm());
					}
				}
			}

			// 1:1문의 주문정보 저장
			// if(!CommonConstants.CUS_CTG1_10.equals(ctemp.getCusCtg1Cd()) &&
			// !CommonConstants.CUS_CTG1_120.equals(ctemp.getCusCtg1Cd()) &&
			// !CommonConstants.CUS_CTG1_130.equals(ctemp.getCusCtg1Cd())){
			if (!CommonConstants.CUS_CTG1_10.equals(ctemp.getCusCtg1Cd())) {

				so.setCusNo(ctemp.getCusNo());

				List<OrderDetailVO> ordList = counselDao.listCounselOrder(so);

				if (ordList != null && !ordList.isEmpty()) {
					ctemp.setOrdList(ordList);
				}
			}

			if (ctemp.getFlNo() != null) {
				CounselSO cso = new CounselSO();
				cso.setFlNo(ctemp.getFlNo());
				List<AttachFileVO> files = this.counselDao.getCounselFile(cso);
				ctemp.setFileList(files);
			}
		}

		return cusList;
	}

	/*
	 * 1:1 문의 목록(FO)
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#getCounselListFO(biz.app.counsel.model.* CounselSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CounselVO> getCounselListFO(CounselSO so) {

		List<CounselVO> cusList = counselDao.getCounselListFO(so);
		
		for(CounselVO cvo : cusList) {
			//문의자 아이디 복호화
			if(StringUtil.isNotEmpty(cvo.getLoginId())) {
				cvo.setLoginId(bizService.twoWayDecrypt(cvo.getLoginId()));
			}
		}
		return cusList;
	}
	
	/*
	 * 상담 등록(Web)
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#insertCounselWeb(biz.app.counsel.model
	 * .CounselPO)
	 */
	@Override
	public void insertCounselWeb(CounselPO po, String deviceGb) {

		/****************************
		 * 상담 정보 설정
		 ****************************/
		po.setCusPathCd(CommonConstants.CUS_PATH_10); // 상담 경로 코드 : WEB

		/*
		 * 접수자 및 설정
		 */
		po.setCusAcptrNo(po.getEqrrMbrNo());
		
		/****************************
		 * 상담 정보 등록
		 ****************************/
		// counsel 등록
		int result = this.counselDao.insertCounsel(po);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			//flNo를 cusNo로 update
			counselDao.updateFlCounsel(po.getCusNo());
		}

		/***************************
		 * 상담 주문 정보 등록
		 ***************************/
		if (po.getOrdNo() != null && !"".equals(po.getOrdNo()) && po.getOrdDtlSeqs() != null
				&& po.getOrdDtlSeqs().length > 0) {
			CounselOrderDetailPO codpo = null;

			for (int i = 0; i < po.getOrdDtlSeqs().length; i++) {
				codpo = new CounselOrderDetailPO();
				codpo.setCusNo(po.getCusNo());
				codpo.setOrdNo(po.getOrdNo());
				codpo.setOrdDtlSeq(po.getOrdDtlSeqs()[i]);

				// counsel_order_detail 등록
				result = this.counselOrderDetailDao.insertCounselOrderInfo(codpo);

				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

			}
		}

		
		if(deviceGb != CommonConstants.DEVICE_GB_30) {
			/****************************
			 * 첨부파일 정보 등록
			 ****************************/
			String[] orgFlNms = po.getOrgFlNms();
			String[] phyPaths = po.getPhyPaths();
			Long[] flSzs = po.getFlSzs();
			AttachFilePO filePO = null;

			if (orgFlNms != null && orgFlNms.length > 0) {
				//Long flNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ);
				//po.setFlNo(flNo); // 파일 번호
				po.setFlNo(po.getCusNo());

				for (int i = 0; i < orgFlNms.length; i++) {
					filePO = new AttachFilePO();

					//FtpFileUtil ftpFileUtil = new FtpFileUtil();
					FtpImgUtil ftpImgUtil = new FtpImgUtil();
					
					String filePath = ftpImgUtil.uploadFilePath(phyPaths[i],
							CommonConstants.COUNSEL_IMAGE_PATH + FileUtil.SEPARATOR + po.getFlNo());

					filePO.setFlNo(po.getFlNo());
					filePO.setPhyPath(filePath);
					filePO.setFlSz(flSzs[i]);
					filePO.setOrgFlNm(orgFlNms[i]);
					filePO.setSysRegrNo(po.getSysRegrNo());

					ftpImgUtil.upload(phyPaths[i], filePath);

					this.bizService.insertAttachFile(filePO);
				}
			}
		}
	}

	/*
	 * 콜센터 상담 등록
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#insertCounselCc(biz.app.counsel.model.
	 * CounselPO, biz.app.counsel.model.CounselProcessPO, boolean)
	 */
	@Override
	public void insertCounselCc(CounselPO cpo, CounselProcessPO cppo, boolean lastPrcsYn) {
		/****************************
		 * 상담 정보 설정
		 ****************************/
		cpo.setCusPathCd(CommonConstants.CUS_PATH_20); // 상담 경로 코드 : Call Center

		/*
		 * 접수자 및 설정
		 */
		Session session = AdminSessionUtil.getSession();
		cpo.setCusAcptrNo(session.getUsrNo());

		/****************************
		 * 상담 정보 등록
		 ****************************/
		int result = this.counselDao.insertCounsel(cpo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/***************************
		 * 상담 당당자 설정
		 ***************************/
		this.updateCounselChrg(cpo.getCusNo(), session.getUsrNo());

		/****************************
		 * 처리 내용 등록
		 ****************************/
		cppo.setCusNo(cpo.getCusNo());
		this.counselProcessService.insertCounselProcess(cppo, lastPrcsYn);

		/***************************
		 * 상담 주문 정보 등록
		 ***************************/
		if (cpo.getOrdNo() != null && !"".equals(cpo.getOrdNo()) && cpo.getOrdDtlSeqs() != null
				&& cpo.getOrdDtlSeqs().length > 0) {
			CounselOrderDetailPO codpo = null;

			for (int i = 0; i < cpo.getOrdDtlSeqs().length; i++) {
				codpo = new CounselOrderDetailPO();
				codpo.setCusNo(cpo.getCusNo());
				codpo.setOrdNo(cpo.getOrdNo());
				codpo.setOrdDtlSeq(cpo.getOrdDtlSeqs()[i]);

				// counsel_order_detail 등록
				result = this.counselOrderDetailDao.insertCounselOrderInfo(codpo);

				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

			}
		}
	}

	/*
	 * 상담 상세 조회
	 * 
	 * @see biz.app.counsel.service.CounselService#getCounsel(biz.app.counsel.model.
	 * CounselSO)
	 */
	@Override
	@Transactional
	public CounselVO getCounsel(CounselSO so) {
		return this.counselDao.getCounsel(so);
	}

	/*
	 * 상담 취소
	 * 
	 * @see biz.app.counsel.service.CounselService#cancelCounsel(java.lang.Long,
	 * java.lang.Long)
	 */
	@Override
	public void cancelCounsel(Long cusNo, Long cusCncrNo) {

		/************************************
		 * 상담 내역 조회
		 ************************************/
		CounselSO cso = new CounselSO();
		cso.setCusNo(cusNo);
		CounselVO counsel = this.counselDao.getCounsel(cso);

		/*
		 * 상담 내역이 존재하지 않은 경우
		 */
		if (counsel == null) {
			throw new CustomException(ExceptionConstants.ERROR_COUNSEL_NO_DATA);
		}

		CounselPO cpo = new CounselPO();
		cpo.setCusNo(cusNo);
		int result = this.counselDao.deleteInquiry(cpo);
		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		/*
		 * 접수,처리중인 경우에만 취소 가능
		 * 
		 * if(!CommonConstants.CUS_STAT_10.equals(counsel.getCusStatCd()) &&
		 * !CommonConstants.CUS_STAT_20.equals(counsel.getCusStatCd())){ throw new
		 * CustomException(ExceptionConstants.ERROR_COUNSEL_NO_CANCEL_STATUS_NOT_WAITING
		 * ); }
		 * 
		 * CounselPO cpo = new CounselPO(); cpo.setCusNo(cusNo);
		 * cpo.setCusCncrNo(cusCncrNo); int result =
		 * this.counselDao.updateCounselCancel(cpo); if(result != 1){ throw new
		 * CustomException(ExceptionConstants.ERROR_CODE_DEFAULT); }
		 */
	}

	/*
	 * 상담 답변 완료 수
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#getCounselAnswerCount(biz.app.counsel.
	 * model.CounselSO)
	 */
	@Override
	public Integer getCounselAnswerCount(CounselSO so) {
		return this.counselDao.getCounselAnswerCount(so);
	}

	/*
	 * 상담 답변 대기 수
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#getCounselWaitCount(biz.app.counsel.
	 * model.CounselSO)
	 */
	@Override
	public Integer getCounselWaitCount(CounselSO so) {
		return this.counselDao.getCounselWaitCount(so);
	}

	/*
	 * 상담 당당자 변경
	 * 
	 * @see biz.app.counsel.service.CounselService#updateCounselChrg(java.lang.Long,
	 * java.lang.Long)
	 */
	@Override
	public void updateCounselChrg(Long cusNo, Long cusChrgNo) {

		/************************************
		 * 상담 내역 조회
		 ************************************/
		CounselSO cso = new CounselSO();
		cso.setCusNo(cusNo);
		CounselVO counsel = this.counselDao.getCounsel(cso);

		/*
		 * 상담 내역이 존재하지 않은 경우
		 */
		if (counsel == null) {
			throw new CustomException(ExceptionConstants.ERROR_COUNSEL_NO_DATA);
		}

		/*
		 * 접수/처리중인 경우에만 변경 가능
		 */
		if (!CommonConstants.CUS_STAT_10.equals(counsel.getCusStatCd())
				&& !CommonConstants.CUS_STAT_20.equals(counsel.getCusStatCd())) {
			throw new CustomException(ExceptionConstants.ERROR_COUNSEL_NO_CHARGE_STATUS);
		}

		/***********************************
		 * 담당자 변경
		 ***********************************/
		CounselPO cpo = new CounselPO();
		cpo.setCusNo(counsel.getCusNo());
		cpo.setCusChrgNo(cusChrgNo);

		int result = this.counselDao.updateCounselChrg(cpo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			/*********************************
			 * 접수인 상태일 경우 진행중 처리
			 *********************************/
			if (CommonConstants.CUS_STAT_10.equals(counsel.getCusStatCd())) {
				CounselPO po = new CounselPO();
				po.setCusNo(counsel.getCusNo());
				po.setCusStatCd(CommonConstants.CUS_STAT_20);

				result = counselDao.updateCounselCusStatCd(po);

				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

	/*
	 * 상담 당당자 변경(멀티)
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#updateCounselChrg(java.lang.Long[],
	 * java.lang.Long)
	 */
	@Override
	public void updateCounselChrg(Long[] cusNos, Long cusChrgNo) {
		if (cusNos != null && cusNos.length > 0) {
			for (Long cusNo : cusNos) {
				this.updateCounselChrg(cusNo, cusChrgNo);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	/*
	 * 상담 기본 카테고리 수정
	 * 
	 * @see biz.app.counsel.service.CounselService#updateCounselCtg(java.lang.Long,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public void updateCounselCtg(Long cusNo, String cusCtg2Cd, String cusCtg3Cd) {
		CounselPO po = new CounselPO();
		po.setCusNo(cusNo);
		po.setCusCtg2Cd(cusCtg2Cd);
		po.setCusCtg3Cd(cusCtg3Cd);

		int result = this.counselDao.updateCounselCtg(po);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/*
	 * 상담 요약 정보 조회
	 * 
	 * @see
	 * biz.app.counsel.service.CounselService#getCounselStatus(biz.app.counsel.model
	 * .CounselStatusSO)
	 */
	@Override
	public CounselStatusVO getCounselStatus(CounselStatusSO so) {
		CounselStatusVO result = null;

		if (so.getMbrNo() != null) {
			result = this.counselDao.getCounselStatusMem(so.getMbrNo());
		} else {
			result = this.counselDao.getCounselStatusNoMem(so);
		}

		return result;
	}

	@Override
	public CsMainVO getCsMain() {
		return counselDao.getCsMain();
	}

	@Override
	public List<CounselVO> listMOCounsel(CounselSO so) {
		return this.counselDao.listMOCounsel(so);
	}

	@Override
	public int deleteInquiry(CounselPO po) {
		return this.counselDao.deleteInquiry(po);
	}

	@Override
	public List<AttachFileVO> getCounselFile(CounselSO so) {
		return this.counselDao.getCounselFile(so);
	}

	@Override
	public Long inquiryAppImgUpload(CounselPO po) {
		/****************************
		 * 첨부파일 정보 등록
		 ****************************/
		String[] orgFlNms = po.getOrgFlNms();
		String[] phyPaths = po.getPhyPaths();
		Long[] flSzs = po.getFlSzs();
		AttachFilePO filePO = null;
		Long flNo = null;
		if (orgFlNms != null && orgFlNms.length > 0) {
			flNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ);
			po.setFlNo(flNo); // 파일 번호

			for (int i = 0; i < orgFlNms.length; i++) {
				filePO = new AttachFilePO();

				FtpImgUtil ftpImgUtil = new FtpImgUtil();
				//FtpFileUtil ftpFileUtil = new FtpFileUtil();
				String filePath = ftpImgUtil.uploadFilePath(phyPaths[i],
						CommonConstants.COUNSEL_IMAGE_PATH + FileUtil.SEPARATOR + po.getFlNo());

				filePO.setFlNo(po.getFlNo());
				filePO.setPhyPath(filePath);
				filePO.setFlSz(flSzs[i]);
				filePO.setOrgFlNm(orgFlNms[i]);
				filePO.setSysRegrNo(po.getSysRegrNo());

				ftpImgUtil.upload(phyPaths[i], filePath);

				this.bizService.insertAttachFile(filePO);
			}
		}
		return flNo;
		
	}

	@Override
	public int updateFlCounsel(Long cusNo) {
		return counselDao.updateFlCounsel(cusNo);
	}

	@Override
	public void updateInquiry(CounselPO po, String deviceGb) {
		po.setCusAcptrNo(po.getEqrrMbrNo());
		int result = this.counselDao.updateInquiry(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			
		}else {
			
			AttachFilePO filePO = new AttachFilePO();
			//삭제 이미지 있으면
			if(StringUtil.isNotEmpty(po.getDelLen())) {
				filePO.setFlNo(po.getFlNo());
				for (int i = 0; i < po.getDelLen().length; i++) {
					filePO.setSeq(po.getDelLen()[i]);
					counselDao.deleteInquiryImg(filePO);
				}
			}
			
			if(deviceGb != CommonConstants.DEVICE_GB_30) {
				if(StringUtil.isNotEmpty(po.getPhyPaths())) {
					String[] orgFlNms = po.getOrgFlNms();
					String[] phyPaths = po.getPhyPaths();
					Long[] flSzs = po.getFlSzs();
					
					//FLNO가 있으면
					if(StringUtil.isEmpty(po.getFlNo())) {
						po.setFlNo(this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ));
					}
					
					for (int i = 0; i < orgFlNms.length; i++) {
						
						filePO = new AttachFilePO();
						FtpImgUtil ftpImgUtil = new FtpImgUtil();
						String filePath = ftpImgUtil.uploadFilePath(phyPaths[i],
								CommonConstants.COUNSEL_IMAGE_PATH + FileUtil.SEPARATOR + po.getFlNo());
						filePO.setFlNo(po.getFlNo());
						filePO.setPhyPath(filePath);
						filePO.setFlSz(flSzs[i]);
						filePO.setOrgFlNm(orgFlNms[i]);
						filePO.setSysRegrNo(po.getSysRegrNo());

						ftpImgUtil.upload(phyPaths[i], filePath);
						this.bizService.insertAttachFile(filePO);
					}
					
					this.counselDao.updateIqrImg(po);
				}
				
			}
		}
	}

	@Override
	public void insertInquiry(CounselPO po, String deviceGb) {
		po.setCusAcptrNo(po.getEqrrMbrNo());
		int result = this.counselDao.insertCounsel(po);
		
		//이미지 등록
		if(deviceGb != CommonConstants.DEVICE_GB_30) {
			if(StringUtil.isNotEmpty(po.getPhyPaths())) {
				
				String[] orgFlNms = po.getOrgFlNms();
				String[] phyPaths = po.getPhyPaths();
				Long[] flSzs = po.getFlSzs();
				AttachFilePO filePO = null;

				po.setFlNo(this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ));
				
//				if (orgFlNms != null && orgFlNms.length > 0) {
					for (int i = 0; i < orgFlNms.length; i++) {
						
						filePO = new AttachFilePO();
						FtpImgUtil ftpImgUtil = new FtpImgUtil();
						String filePath = ftpImgUtil.uploadFilePath(phyPaths[i],
								CommonConstants.COUNSEL_IMAGE_PATH + FileUtil.SEPARATOR + po.getFlNo());
						filePO.setFlNo(po.getFlNo());
						filePO.setPhyPath(filePath);
						filePO.setFlSz(flSzs[i]);
						filePO.setOrgFlNm(orgFlNms[i]);
						filePO.setSysRegrNo(po.getSysRegrNo());

						ftpImgUtil.upload(phyPaths[i], filePath);
						this.bizService.insertAttachFile(filePO);
					}
//				}
				
				//이미지 flNo 업데이트
				this.counselDao.updateIqrImg(po);
			}
		}
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public void appInquiryImageUpdate(CounselPO po) {
		/****************************
		 * 첨부파일 정보 등록
		 ****************************/
		AttachFilePO filePO = null;
		
		//FLNO가 있으면
		if(StringUtil.isEmpty(po.getFlNo())) {
			po.setFlNo(this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ));
		}

			for (int i = 0; i < po.getPhyPaths().length; i++) {
				filePO = new AttachFilePO();

				filePO.setFlNo(po.getFlNo());
				filePO.setPhyPath(po.getPhyPaths()[i]);
				filePO.setOrgFlNm(po.getOrgFlNms()[i]);
				filePO.setSysRegrNo(po.getSysRegrNo());

				this.bizService.insertAttachFile(filePO);
			}
			
			//이미지 flNo 업데이트
			this.counselDao.updateIqrImg(po);
	}
}