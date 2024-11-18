package biz.app.contents.service;

import java.io.File;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import biz.app.contents.model.SeriesVO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.model.FileVO;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.StringUtil;
import biz.app.contents.dao.SeriesDao;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesPO;
import biz.app.contents.model.SeriesSO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: SeriesServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 시리즈 Service Implement
 * </pre>
 */
@Service
@Transactional
public class SeriesServiceImpl implements SeriesService {
	
	@Autowired private SeriesDao seriesDao;
	@Autowired private BizService bizService;
	@Autowired private TagService tagService;
	@Autowired private NhnObjectStorageUtil nhnObjectStorageUtil;
	@Autowired private Properties bizConfig;
	
	/**
	 * <pre>펫로그 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public List<SeriesVO> pageSeries(SeriesSO so) {
		List<SeriesVO> list = seriesDao.pageSeries(so);

		return list;
	}
	
	@Override
	public int updateSeriesStat(List<SeriesPO> seriesPOList) {
		int updateCnt = 0;
		if(seriesPOList != null && !seriesPOList.isEmpty()) {
			for(SeriesPO po : seriesPOList) {
				insertSeriesHist(po);
				seriesDao.updateSeriesStat(po);
				updateCnt ++;
			}
		}
		return updateCnt;
	}
	
	//시리즈 이력저장
	public int insertSeriesHist(SeriesPO po) {
		int cnt = 0;
		Long histNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_HIST_SEQ);
		
		po.setHistNo(histNo);
		//시리즈 히스토리 기록
		cnt += seriesDao.insertSeriesHist(po);
		//태그 히스토리 기록
		cnt += seriesDao.insertSeriesTagHist(po);
		//첨부파일 히스토리 기록
		cnt += seriesDao.insertSeriesFileHist(po);
		
		return cnt;
	}
	
	@Transactional(readOnly = true)
	public List<SeriesVO> pageSeason(SeriesSO so) {
		List<SeriesVO> list = seriesDao.pageSeason(so);
		for(SeriesVO vo : list) {			
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
			vo.setSysUpdrNm(MaskingUtil.getName(vo.getSysUpdrNm()));
		}
		return list;
	}
	
	@Transactional(readOnly = true)
	public List<ApetAttachFileVO> getAttachFiles(SeriesSO so) {
		List<ApetAttachFileVO> list = seriesDao.getAttachFiles(so);

		return list;
	}
	
	@Override
	public int updateSeries(SeriesPO po) {
		int updateCnt = 0;		 
		Long srisNo = po.getSrisNo() != null?po.getSrisNo():this.bizService.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_SERIES_SEQ);
		String[] orgFlNms = po.getOrgFlNms();
		String[] phyPaths = po.getPhyPaths();
		String[] imgGbs   = po.getImgGbs();//이미지 구분 srisProfile, srisImg
		String[] flModYns = po.getFlModYns(); //첨부파일 수정 여부
		Long[] flSzs 	  = po.getFlSzs();
		ApetAttachFilePO filePO = null;
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		//시리즈 등록 시 시즌1 자동 생성 20210215		
		FileVO srisFileVo = new FileVO();
		SeriesPO sesnPO = new SeriesPO();
		
		//history 등록(수정시에만)
		if(po.getSrisNo() != null) {
			insertSeriesHist(po);
		}
		
		//첨부파일 등록
		if (orgFlNms != null && orgFlNms.length > 0 && po.getFlModYn().equals("Y")) {
			Long flNo = po.getFlNo() != null?po.getFlNo():this.bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);
			String contsTpCd = CommonConstants.CONTS_TP_10;//썸네일			
			po.setFlNo(flNo);	// 파일 번호
			
			for (int i = 0; i < orgFlNms.length; i++) {
				if(flModYns[i].equals("Y")) {//첨부파일 수정 여부
					String filePath = ftpImgUtil.uploadFilePath(phyPaths[i], CommonConstants.SERIES_IMAGE_PATH + FileUtil.SEPARATOR + srisNo + FileUtil.SEPARATOR + imgGbs[i]);
					//srisFileVo = nhnObjectStorageUtil.upload(phyPaths[i], filePath);
					if(imgGbs[i].equals("srisImg") && StringUtil.isEmpty(po.getSrisNo())) {//등록이면서 시리즈 이미지 일경우 시즌자동 생성시 이미지 사용 해야하므로 temp 삭제 하지 않는다.
						ftpImgUtil.upload(phyPaths[i], filePath, false);						
					}else {
						ftpImgUtil.upload(phyPaths[i], filePath);
					}
					
					filePO = new ApetAttachFilePO();
					filePO.setFlNo(flNo);
					//filePO.setPhyPath(srisFileVo.getFilePath());
					filePO.setPhyPath(filePath);
					filePO.setFlSz(flSzs[i]);
					filePO.setOrgFlNm(orgFlNms[i]);
					filePO.setSysRegrNo(po.getSysRegrNo());
					filePO.setContsTpCd(contsTpCd);
					if(imgGbs[i].equals("srisImg")) {
						filePO.setContsTpCd(CommonConstants.CONTS_TP_20);
						//시즌 등록용 PO 세팅						
						sesnPO.setOrgFlNms(new String[] {orgFlNms[i]});
						//sesnPO.setPhyPaths(new String[] {phyPaths[i]});
						//String newFilePath = bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + filePath;
						sesnPO.setPhyPaths(new String[] {phyPaths[i]}); 
						sesnPO.setFlModYns(new String[] {"Y"});
						sesnPO.setFlSzs(new Long[] {flSzs[i]});						
						sesnPO.setFlModYn("Y");
					}
					seriesDao.insertApetAttachFile(filePO);
				}				
			}
		}
		//태그 등록
		seriesDao.deleteSeriesTagMap(po);
		if(po.getTagNos() != null) {
			for(String tagNo : po.getTagNos()) {
				SeriesPO spo = new SeriesPO();
				spo.setSrisNo(srisNo);
				spo.setTagNo(tagNo);
				spo.setSysRegrNo(po.getSysRegrNo());
				seriesDao.updateSeriesTagMap(spo);
			}
		}
		
		//시리즈 등록
		if(po.getSrisNo() != null) {//수정
			updateCnt = seriesDao.updateSeries(po);
		}else {//등록			
			po.setSrisNo(srisNo);
			updateCnt = seriesDao.insertSeries(po);			
			//시리즈 등록 후 시즌1자동 생성
			if(updateCnt > 0) {
				sesnPO.setSrisNo(srisNo);
				sesnPO.setSesnNm("시즌1");
				sesnPO.setSesnDscrt(po.getSrisDscrt());
				sesnPO.setDispYn("Y");
				updateCnt = this.updateSeason(sesnPO);
			}
		}
		
		//시리즈 정렬순서(가나다 순) 저장
		seriesDao.updateSeriesSeqSort();
		
		// 구성의 설명내 tag 추출 등록
		List<String> tagNos = tagService.insertTagsWithString(po.getSrisDscrt());
		
		return updateCnt;
	}
	
	
	@Transactional(readOnly = true)
	public SeriesVO getSeasonDetail(SeriesSO so) {
		SeriesVO vo = seriesDao.getSeasonDetail(so);

		return vo;
	}
	
	@Override
	public int updateSeason(SeriesPO po) {
		int updateCnt = 0;		
		Long srisNo = po.getSrisNo();
		String[] orgFlNms = po.getOrgFlNms();
		String[] phyPaths = po.getPhyPaths();
		String[] imgGbs   = po.getImgGbs();
		String[] flModYns = po.getFlModYns(); //첨부파일 수정 여부
		Long[] flSzs 	  = po.getFlSzs();
		ApetAttachFilePO filePO = null;
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		//시즌 히스토리 등록
		if(po.getSesnNo() != null) {//수정
			insertSeasonHist(po);
		}
		
		if (orgFlNms != null && orgFlNms.length > 0 && po.getFlModYn().equals("Y")) {
			Long flNo = po.getFlNo() != null?po.getFlNo():this.bizService.getSequence(CommonConstants.SEQUENCE_APET_ATTATCH_FILE_SEQ);
			String contsTpCd = CommonConstants.CONTS_TP_20;//상단노출이미지		
			po.setFlNo(flNo);	// 파일 번호
			
			for (int i = 0; i < orgFlNms.length; i++) {
				if(flModYns[i].equals("Y")) {//첨부파일 수정 여부
					String filePath = ftpImgUtil.uploadFilePath(phyPaths[i], CommonConstants.SEASON_IMAGE_PATH + FileUtil.SEPARATOR + srisNo);				
					//FileVO sesnFileVo = nhnObjectStorageUtil.upload(phyPaths[i], filePath);
					ftpImgUtil.upload(phyPaths[i], filePath);
					
					filePO = new ApetAttachFilePO();
					filePO.setFlNo(flNo);
					//filePO.setPhyPath(sesnFileVo.getFilePath());
					filePO.setPhyPath(filePath);
					filePO.setFlSz(flSzs[i]);
					filePO.setOrgFlNm(orgFlNms[i]);
					filePO.setSysRegrNo(po.getSysRegrNo());
					filePO.setContsTpCd(contsTpCd);					
					seriesDao.insertApetAttachFile(filePO);	
				}
									
			}
		}		
		if(po.getSesnNo() != null) {//수정
			updateCnt = seriesDao.updateSeason(po);
		}else {//등록
			updateCnt = seriesDao.insertSeason(po);	
		}
		// 구성의 설명내 tag 추출 등록
		List<String> tagNos = tagService.insertTagsWithString(po.getSesnDscrt());
		
		return updateCnt;
	}
	
	@Override
	public int updateSeasonStat(List<SeriesPO> seasonPOList) {
		int updateCnt = 0;
		if(seasonPOList != null && !seasonPOList.isEmpty()) {
			for(SeriesPO po : seasonPOList) {
				insertSeasonHist(po);
				seriesDao.updateSeasonStat(po);
				updateCnt ++;
			}
		}
		return updateCnt;
	}
	
	//시리즈 이력저장
	public int insertSeasonHist(SeriesPO po) {
		int cnt = 0;
		Long histNo = bizService.getSequence(CommonConstants.SEQUENCE_APET_CONTENTS_HIST_SEQ);
		
		po.setHistNo(histNo);
		//시즌 히스토리 기록
		cnt += seriesDao.insertSeasonHist(po);
		//첨부파일 히스토리 기록
		cnt += seriesDao.insertSeriesFileHist(po);
		
		return cnt;
	}
	
	@Override
	public List<SeriesVO> getSeriesTagMap(SeriesSO so){
		List<SeriesVO> vo = seriesDao.getSeriesTagMap(so);

		return vo;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesServiceImpl.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public SeriesVO foGetSeries(SeriesSO so) {
		return seriesDao.foGetSeries(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesServiceImpl.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<SeriesVO> foGetSeason(SeriesSO so) {
		return seriesDao.foGetSeason(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesServiceImpl.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<SeriesVO> foSeriesList(SeriesSO so) {
		return seriesDao.foSeriesList(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesServiceImpl.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<SeriesVO> foSeasonList(SeriesSO so) {
		return seriesDao.foSeasonList(so);
	}
	
	@Override
	public int deleteSeries(List<SeriesPO> seriesPOList) {
		int deleteCnt = 0;
		if(seriesPOList != null && !seriesPOList.isEmpty()) {
			for(SeriesPO po : seriesPOList) {
				//삭제 전 영상 또는 시즌 매핑정보 확인
				SeriesSO so = new SeriesSO();
				SeriesVO vo = new SeriesVO();
				so.setSrisNo(po.getSrisNo());
				if(so.getSrisNo() != null) {
					List<SeriesVO> list = pageSeries(so);
					vo = list.get(0);
				}
				if(StringUtil.isNotEmpty(vo) && vo.getVdCnt() == 0 && vo.getSesnCnt() == 0) {
					//태그매핑 삭제
					seriesDao.deleteSeriesTagMap(po);
					//시리즈 삭제
					seriesDao.deleteSeries(po);
					deleteCnt ++;
				}
				
			}
		}
		
		//시리즈 정렬순서(가나다 순) 저장
		seriesDao.updateSeriesSeqSort();
		
		return deleteCnt;
	}
	
	@Override
	public int deleteSeason(List<SeriesPO> seriesPOList) {
		int deleteCnt = 0;
		if(seriesPOList != null && !seriesPOList.isEmpty()) {
			for(SeriesPO po : seriesPOList) {
				//삭제 전 영상 매핑정보 확인
				SeriesSO so = new SeriesSO();
				SeriesVO vo = new SeriesVO();
				so.setSrisNo(po.getSrisNo());
				so.setSesnNo(po.getSesnNo());
				if(so.getSrisNo() != null && so.getSesnNo() != null) {
					vo = getSeasonDetail(so);					
				}
				if(StringUtil.isNotEmpty(vo) && vo.getVdCnt() == 0 ) {
					//시리즈 삭제
					seriesDao.deleteSeason(po);
					deleteCnt ++;
				}
				
			}
		}
		return deleteCnt;
	}
}