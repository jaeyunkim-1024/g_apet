package biz.app.display.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.display.dao.EventPopupDao;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupPO;
import biz.app.display.model.EventPopupVO;
import biz.common.model.AttachFilePO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class EventPopupServiceImpl implements EventPopupService {

	@Autowired private EventPopupDao eventPopupDao;
	@Autowired private BizService bizService;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	@Override
	public List<EventPopupVO> pageEventPopupList(EventPopupSO so) {
		List<EventPopupVO> list = eventPopupDao.pageEventPopupList(so);
		for(EventPopupVO vo : list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}		
		return list;
	}


	@Override
	public int insertEventPopup (EventPopupPO po) {
		int result = 0;		
		
		if(po != null ) {
			Long evtpopNo = this.bizService.getSequence(CommonConstants.SEQUENCE_EVTPOP_BASE_SEQ);
			po.setEvtpopNo(evtpopNo);
			//첨부 이미지 등록
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			AttachFilePO filePO = null;
			if(StringUtil.isNotEmpty(po.getOrgFileNm()) && StringUtil.isNotEmpty(po.getPhyPath())) {
				Long flNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ);
				po.setFlNo(flNo);
				
				String filePath = ftpImgUtil.uploadFilePath(po.getPhyPath(), CommonConstants.EVTPOP_IMG_PATH + FileUtil.SEPARATOR + evtpopNo);
				ftpImgUtil.upload(po.getPhyPath(), filePath);
				
				filePO = new AttachFilePO();
				filePO.setFlNo(flNo);				
				filePO.setPhyPath(filePath);
				filePO.setFlSz(po.getFlSz());
				filePO.setOrgFlNm(po.getOrgFileNm());
				filePO.setSysRegrNo(po.getSysRegrNo());
				bizService.insertAttachFile(filePO);
				
				po.setEvtpopImgPath(filePath);
			}
			
			result = eventPopupDao.insertEventPopup(po);
		}
		return result;
	}

	@Override
	public int updateEventPopup(EventPopupPO po) {
		int result = 0;

		if(po != null ) {			
			//첨부 이미지 등록
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			AttachFilePO filePO = null;
			if(StringUtil.isNotEmpty(po.getOrgFileNm()) && StringUtil.isNotEmpty(po.getPhyPath())) {
				Long flNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ATTACH_FILE_SEQ);
				po.setFlNo(flNo);
				
				String filePath = ftpImgUtil.uploadFilePath(po.getPhyPath(), CommonConstants.EVTPOP_IMG_PATH + FileUtil.SEPARATOR + po.getEvtpopNo());
				ftpImgUtil.upload(po.getPhyPath(), filePath);
				
				filePO = new AttachFilePO();
				filePO.setFlNo(flNo);				
				filePO.setPhyPath(filePath);
				filePO.setFlSz(po.getFlSz());
				filePO.setOrgFlNm(po.getOrgFileNm());
				filePO.setSysRegrNo(po.getSysRegrNo());
				bizService.insertAttachFile(filePO);
				
				po.setEvtpopImgPath(filePath);
			}
			result = eventPopupDao.updateEventPopup(po );
		}
		return result;
	}


	@Override
	public EventPopupVO getEventPopupDetail (EventPopupSO so) {
		return eventPopupDao.getEventPopupDetail(so);
	}
	
	@Override
	public int deleteEventPopup(EventPopupPO po) {
		int result = 0;

		if(po != null ) {	
			result = eventPopupDao.deleteEventPopup(po );
		}
		return result;
	}

}
