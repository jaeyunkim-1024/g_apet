package biz.app.contents.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.contents.dao.ApetAttachFileDao;
import biz.app.contents.dao.SeriesDao;
import biz.app.contents.dao.VodDao;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodGoodsPO;
import biz.app.contents.model.VodGoodsVO;
import biz.app.contents.model.VodPO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodTagPO;
import biz.app.contents.model.VodVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.util.FileUtil;
import framework.common.util.FtpFileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: ContentsServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 컨텐츠 Service Implement
 * </pre>
 */
@Service
@Transactional
public class VodServiceImpl implements VodService {

	@Autowired
	private BizService bizService;
	
	@Autowired
	private TagService tagService;

	@Autowired
	private VodDao vodDao;
	
	@Autowired
	private SeriesDao seriesDao;
	
	@Autowired
	private ApetAttachFileDao apetAttachFileDao;
	
	@Autowired
	private NhnObjectStorageUtil nhnObjectStorageUtil;

	@Override
	public List<VodVO> pageVod(VodSO so) {
		List<VodVO> list = vodDao.pageVod(so);
		return list;
	}

	@Override
	public int batchUpdateDisp(List<VodPO> vodPOList) {
		int updateCnt = 0;
		if(vodPOList != null && !vodPOList.isEmpty()) {
			for(VodPO po : vodPOList) {
				vodDao.batchUpdateDisp(po);
				updateCnt ++;
			}
		}
		return updateCnt;
	}

	@Override
	public VodVO getVod(VodSO so) {
		VodVO vo = vodDao.getVod(so);
		List<ApetAttachFileVO> flVoList = vodDao.getAttachFiles(vo.getFlNo());
		for (ApetAttachFileVO flVo : flVoList) {
			if (StringUtils.equals(CommonConstants.CONTS_TP_10, flVo.getContsTpCd())) {
				vo.setThumImg(flVo);
			}
			if (StringUtils.equals(CommonConstants.CONTS_TP_20, flVo.getContsTpCd())) {
				vo.setTopDispImg(flVo);
			}
			if (StringUtils.equals(CommonConstants.CONTS_TP_60, flVo.getContsTpCd())) {
				vo.setVodFile(flVo);
			}
			
			if (StringUtils.equals(CommonConstants.CONTS_TP_70, flVo.getContsTpCd())) {
				vo.setThumVod(flVo);
			}
			
			if (StringUtils.equals(CommonConstants.CONTS_TP_90, flVo.getContsTpCd())) {
				vo.setThumImgDownloadUrl(flVo.getPhyPath());
			}
		}
			
		if (vo.getSrisNo() == null) {
			vo.setSrisYn(CommonConstants.COMM_YN_N);
		} else {
			vo.setSrisYn(CommonConstants.COMM_YN_Y);
		}
//		vo.setHits(StringUtil.formatNum(vo.getHits()));
		return vo;
	}

	@Override
	public List<SeriesVO> getSeriesAll() {
		return vodDao.getSeriesAll();
	}

	@Override
	public List<SeriesVO> getSeasonBySrisNo(Long srisNo) {
		return vodDao.getSeasonBySrisNo(srisNo);
	}

	@Override
	public List<VodVO> getTagsByVdId(String vdId) {
		return vodDao.getTagsByVdId(vdId);
	}

	@Override
	public List<VodGoodsVO> getGoodsByVdId(String vdId) {
		return vodDao.getGoodsByVdId(vdId);
	}

	@Override
	public void updateVod(VodPO vodPo) {
		// 추가 요건사항 이력 저장 start
		VodSO so = new VodSO();
		so.setVdId(vodPo.getVdId());
		// 
		VodVO vo = vodDao.getVod(so);
		List<ApetAttachFileVO> flVoList = vodDao.getAttachFiles(vo.getFlNo());
		List<VodVO> tags = vodDao.getTagsByVdId(vo.getVdId());
		List<VodGoodsVO> goods = vodDao.getGoodsByVdId(vo.getVdId());
		Long histNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_HIST_SEQ);
		
		vo.setHistNo(histNo);
		vo.setVdGbCd(CommonConstants.VD_GB_20);
		vodDao.insertVodHist(vo);
		
		flVoList.stream().forEach(v->{
			v.setHistNo(histNo);
			vodDao.insertApetAttachFileHist(v);
		});
		
		tags.stream().forEach(v->{
			v.setHistNo(histNo);
			vodDao.insertTagsMapHist(v);
		});
		
		goods.stream().forEach(v->{
			v.setHistNo(histNo);
			vodDao.insertGoodsMapHist(v);
		});
		
		// 이력 저장 end
		String[] phyPaths = vodPo.getPaths();
		if (!StringUtils.equals(vo.getThumAutoYn(), vodPo.getThumAutoYn()) && StringUtil.isEmpty(phyPaths[1])) {
			vodPo.setThumAutoYn(CommonConstants.COMM_YN_Y);
		}
		
		int result = vodDao.updateVod(vodPo);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 영상, 썸네일, 상단 노출 이미지 update
		String[] orgFlNms = vodPo.getNames();
		Long[] flSzs = vodPo.getFlSzs();
		ApetAttachFilePO flPo = null;
		FtpImgUtil ftpImgUtil = null;
		String[] contsTpCds = {CommonConstants.CONTS_TP_60, CommonConstants.CONTS_TP_10, CommonConstants.CONTS_TP_20, CommonConstants.CONTS_TP_70};

		// 비필수인 상단 노출 이미지 하기 조건에 따라 삭제
		if (StringUtil.isEmpty(vodPo.getTopImgPath())) {
			flPo = new ApetAttachFilePO();
			flPo.setFlNo(vodPo.getFlNo());
			flPo.setContsTpCd(CommonConstants.CONTS_TP_20);
			apetAttachFileDao.deleteApetAttatchFile(flPo);
		}

		for (int i = 0; i < phyPaths.length; i++) {
			String phyPath = phyPaths[i];
			if (StringUtil.isNotEmpty(phyPath)) {
				flPo = new ApetAttachFilePO();
				flPo.setFlNo(vodPo.getFlNo());
				String contsTpCd = contsTpCds[i];
				flPo.setContsTpCd(contsTpCd);
				ftpImgUtil = new FtpImgUtil();
//				String filePath = ftpImgUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
				String filePath = phyPath;
				flPo.setPhyPath(filePath);
				flPo.setFlSz(flSzs[i]);
				flPo.setOrgFlNm(orgFlNms[i]);
				if (StringUtils.equals(CommonConstants.CONTS_TP_60, contsTpCd)) {
					flPo.setVdLnth(vodPo.getVdLnth());
					flPo.setOutsideVdId(vodPo.getOutsideVdId());
				}
				if ((StringUtils.equals(CommonConstants.CONTS_TP_10, contsTpCd) && StringUtils.equals(CommonConstants.COMM_YN_N, vodPo.getThumAutoYn())) || StringUtils.equals(CommonConstants.CONTS_TP_20, contsTpCd)) {
//					filePath = nhnObjectStorageUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
//					FileVO vo = nhnObjectStorageUtil.upload(phyPath, filePath);
					filePath = ftpImgUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
					ftpImgUtil.upload(phyPath, filePath);
					flPo.setPhyPath(filePath);
				}
				if ((StringUtils.equals(CommonConstants.CONTS_TP_10, contsTpCd) && StringUtils.equals(CommonConstants.COMM_YN_Y, vodPo.getThumAutoYn()))) {
					ApetAttachFilePO flPo2 = new ApetAttachFilePO();
					flPo2.setFlNo(vodPo.getFlNo());
					flPo2.setPhyPath(vodPo.getThumImgChgDownloadUrl());
					flPo2.setContsTpCd(CommonConstants.CONTS_TP_90);
					if (StringUtil.isEmpty(vodPo.getThumImgDownloadUrl())) {
						vodDao.insertApetAttachFile(flPo2);
					} else {
						apetAttachFileDao.updateApetAttachFile(flPo2);
					}
				}
				if ((StringUtils.equals(CommonConstants.CONTS_TP_10, contsTpCd) && StringUtils.equals(CommonConstants.COMM_YN_N, vodPo.getThumAutoYn()))) {
					ApetAttachFilePO flPo2 = new ApetAttachFilePO();
					flPo2.setFlNo(vodPo.getFlNo());
					flPo2.setContsTpCd(CommonConstants.CONTS_TP_90);
					vodDao.deleteApetAttachFile(flPo2);
				}
				if (StringUtils.equals(CommonConstants.CONTS_TP_20, contsTpCd) && StringUtil.isEmpty(vodPo.getTopImgPath())) {
					//임시 Start
					//filePath = nhnObjectStorageUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
					//임시 End
					vodDao.insertApetAttachFile(flPo);
				} else {
					apetAttachFileDao.updateApetAttachFile(flPo);
				}
			}
		}
		
		// 태그 매핑 정보 삭제 후 등록
		vodDao.deleteTagMap(vodPo);
		if (vodPo.getTags() != null && vodPo.getTags().length > 0) {
			for (String tagNo : vodPo.getTags()) {
				VodTagPO vodTagPo = new VodTagPO();
				vodTagPo.setTagNo(tagNo);
				vodTagPo.setVdId(vodPo.getVdId());
				result = vodDao.insertTagsMap(vodTagPo);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
		// 상품 매핑 정보 삭제 후 등록
		vodDao.deleteGoodsMap(vodPo);
		if (vodPo.getVodGoodsPoList() != null && !vodPo.getVodGoodsPoList().isEmpty() && StringUtil.equals(CommonConstants.VD_TP_20, vodPo.getVdTpCd())) {
			for (VodGoodsPO vodGoodsPo : vodPo.getVodGoodsPoList()) {
				vodGoodsPo.setVdId(vodPo.getVdId());
				
				result = vodDao.insertGoodsMap(vodGoodsPo);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
		// 내용 중 태그 등록
		List<String> tagNos = tagService.insertTagsWithString(vodPo.getContent());
	}

	@Override
	public List<VodGoodsVO> listVodGoods(VodSO so) {
		return vodDao.listVodGoods(so);
	}

	@Override
	public void insertVod(VodPO vodPo) {
		vodPo.setVdGbCd(CommonConstants.VD_GB_20);
		vodPo.setHits(0L);
		// vdId generate
		VodSO so = new VodSO();
		so.setVdGbCd(vodPo.getVdGbCd());
		vodPo.setVdId(bizService.genContentsId(so));

		// 영상, 썸네일, 상단 노출 이미지 등록
		String[] phyPaths = vodPo.getPaths();
		String[] orgFlNms = vodPo.getNames();
		Long[] flSzs = vodPo.getFlSzs();
		ApetAttachFilePO flPo = null;
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		Long flNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);
		String[] contsTpCds = {CommonConstants.CONTS_TP_60, CommonConstants.CONTS_TP_10, CommonConstants.CONTS_TP_20, CommonConstants.CONTS_TP_70};
		vodPo.setFlNo(flNo);
		for (int i = 0; i < phyPaths.length; i++) {
			String phyPath = phyPaths[i];
			if (StringUtil.isNotEmpty(phyPath)) {
				flPo = new ApetAttachFilePO();
				flPo.setFlNo(flNo);
				String contsTpCd = contsTpCds[i];
//				String filePath = ftpImgUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
				String filePath = phyPath;
				if (StringUtils.equals(CommonConstants.CONTS_TP_60, contsTpCd)) {
					flPo.setVdLnth(vodPo.getVdLnth());
					flPo.setOutsideVdId(vodPo.getOutsideVdId());
//					filePath = phyPath;
				}
				flPo.setPhyPath(filePath);
				flPo.setFlSz(flSzs[i]);
				flPo.setOrgFlNm(orgFlNms[i]);
				flPo.setContsTpCd(contsTpCd);
				if ((StringUtils.equals(CommonConstants.CONTS_TP_10, contsTpCd) && StringUtils.equals(CommonConstants.COMM_YN_N, vodPo.getThumAutoYn())) || StringUtils.equals(CommonConstants.CONTS_TP_20, contsTpCd)) {
//					filePath = nhnObjectStorageUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
//					FileVO vo = nhnObjectStorageUtil.upload(phyPath, filePath);
					filePath = ftpImgUtil.uploadFilePath(phyPath, CommonConstants.VOD_FILE_PATH + FileUtil.SEPARATOR + vodPo.getVdId() + FileUtil.SEPARATOR + contsTpCd);
					ftpImgUtil.upload(phyPath, filePath);
					flPo.setPhyPath(filePath);
				}

				vodDao.insertApetAttachFile(flPo);
				
			}
		}
		
		//썸네일 다운로드 url 등록
		if (StringUtils.equals(CommonConstants.COMM_YN_Y, vodPo.getThumAutoYn())) {
			flPo = new ApetAttachFilePO();
			flPo.setFlNo(flNo);
			flPo.setPhyPath(vodPo.getThumImgDownloadUrl());
			flPo.setContsTpCd(CommonConstants.CONTS_TP_90);
			vodDao.insertApetAttachFile(flPo);
		}

		// 영상 기본 정보 등록
		int result = vodDao.insertVod(vodPo);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 태그 매핑 정보 등록
		if (vodPo.getTags() != null && vodPo.getTags().length > 0) {
			for (String tagNo : vodPo.getTags()) {
				VodTagPO vodTagPo = new VodTagPO();
				vodTagPo.setTagNo(tagNo);
				vodTagPo.setVdId(vodPo.getVdId());
				result = vodDao.insertTagsMap(vodTagPo);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 상품 매핑 정보 등록
		if (vodPo.getVodGoodsPoList() != null && !vodPo.getVodGoodsPoList().isEmpty()) {
			for (VodGoodsPO vodGoodsPo : vodPo.getVodGoodsPoList()) {
				vodGoodsPo.setVdId(vodPo.getVdId());
				
				result = vodDao.insertGoodsMap(vodGoodsPo);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
		// 내용 중 태그 등록
		List<String> tagNos = tagService.insertTagsWithString(vodPo.getContent());
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodServiceImpl.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 영상목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<VodVO> foSesnVodList(VodSO so) {
		return vodDao.foSesnVodList(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodServiceImpl.java
	 * - 작성일        : 2021. 2. 10.
	 * - 작성자        : YKU
	 * - 설명          : 랜덤으로 시리즈 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public VodVO srisRandom(VodSO so) {
		return vodDao.srisRandom(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodServiceImpl.java
	 * - 작성일        : 2021. 2. 10.
	 * - 작성자        : YKU
	 * - 설명          : 랜덤 영상 리스트 
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<VodVO> srisRandomList(VodSO so) {
		return vodDao.srisRandomList(so);
	}

	@Override
	public List<VodVO> listGetTag(VodSO so) {
		return vodDao.listGetTag(so);
	}

	@Override
	public List<VodVO> excelDownVodList(VodSO so) {
		List<VodVO> list = vodDao.excelDownVodList(so);
		return list;
	}
}