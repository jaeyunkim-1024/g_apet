package batch.excute.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.dao.DlvrAreaInfoDao;
import biz.app.order.model.OrderDlvrAreaPO;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.order.service.DlvrAreaInfoService;
import biz.app.order.service.DlvrAreaInfoServiceImpl;
import biz.common.service.BizService;
import biz.interfaces.cis.model.request.order.RngeInquirySO;
import biz.interfaces.cis.model.response.order.RngeInquiryItemVO;
import biz.interfaces.cis.model.response.order.RngeInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@EnableScheduling
public class CisDlvrAreaSearchExcute {

	@Autowired private DlvrAreaInfoDao dlvrAreaInfoDao;
	@Autowired private CisOrderService cisOrderService;
	@Autowired	private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private BizService bizService;

	public void cronCisDlvrAreaSearch() {
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_DLVR_AREA_INFO_CIS_SEARCH);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		
		Rtn rtn = new Rtn();
		rtn.setSuccessCnt(0);
		rtn.setTotalCnt(0);
		try {
			OrderDlvrAreaPO mapPO = new OrderDlvrAreaPO();
			mapPO.setPrcsYn("Y");
			dlvrAreaInfoDao.updateDlvrAreaPostMap(mapPO);
			
			//당일배송
			cisDlvrAreaSearch(CommonConstants.DLVR_PRCS_TP_20, rtn);
			
			//새벽배송
			cisDlvrAreaSearch(CommonConstants.DLVR_PRCS_TP_21, rtn);
					
			dlvrAreaInfoDao.deleteDlvrAreaPostMapForBatch();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			int successCnt = rtn.getSuccessCnt();
			int totalCnt = rtn.getTotalCnt();
			/***********************
			 * Batch Log End
			 ***********************/
			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.order.delivery.command.success", new Object[]{totalCnt, successCnt, totalCnt-successCnt}));
			batchService.insertBatchLog(blpo);		
		}
	}
	
	public void cisDlvrAreaSearch(String dlvrPrcsTpCd, Rtn rtn) {
		RngeInquirySO so = new RngeInquirySO();
		so.setDlvtTpCd(dlvrPrcsTpCd);
		Long dlvrAreaNo = null;
		try {
			RngeInquiryVO oneDay = cisOrderService.listRnge(so);
			if(CommonConstants.CIS_API_SUCCESS_CD.equals(oneDay.getResCd())) {
				List<RngeInquiryItemVO> list = oneDay.getItemList();
				rtn.setTotalCnt(rtn.getTotalCnt() + list.size());
				for(RngeInquiryItemVO item :  list) {
					
					OrderDlvrAreaSO areaSO = new OrderDlvrAreaSO();
					areaSO.setDlvrPrcsTpCd(item.getDlvtTpCd());
					areaSO.setDlvrAreaCd(item.getDlvGrpCd());
					OrderDlvrAreaVO dlvrArea =  dlvrAreaInfoDao.getDlvrAreaInfo(areaSO);
					if(dlvrArea == null) {
						OrderDlvrAreaPO areaPO = new OrderDlvrAreaPO();
						dlvrAreaNo = bizService.getSequence(CommonConstants.SEQUENCE_DLVR_AREA_INFO_SEQ);
						areaPO.setDlvrAreaNo(dlvrAreaNo);
						areaPO.setDlvrAreaCd(item.getDlvGrpCd());
						areaPO.setDlvrPrcsTpCd(item.getDlvtTpCd());
						areaPO.setUseYn("Y");
						areaPO.setSlotQty(0L);
						dlvrAreaInfoDao.insertDlvrAreaInfo(areaPO);
					}else {
						dlvrAreaNo = dlvrArea.getDlvrAreaNo();
					}
					
					OrderDlvrAreaPO areaMapPO = new OrderDlvrAreaPO();
					areaMapPO.setDlvrAreaNo(dlvrAreaNo);
					areaMapPO.setPostNo(item.getZipcode());
					areaMapPO.setSido(item.getSido());
					areaMapPO.setGugun(item.getGugun());
					areaMapPO.setDong(item.getDong());
					areaMapPO.setDlvrAreaNm(item.getDlvGrpCdNm());
					areaMapPO.setDlvrCntrCd(item.getMallId());
					areaMapPO.setDlvrCntrNm(item.getMallNm());
					
					dlvrAreaInfoDao.insertDlvrAreaPostMap(areaMapPO);
					
					rtn.setSuccessCnt(rtn.getSuccessCnt() + 1);
				}
			}else {
				log.debug("=== CIS 배송 권역 조회 API 오류 - NOT SUCCESS== ");
				throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR);
			}
			
		} catch(Exception e){
			log.debug("=== CIS 배송 권역 조회 API 오류 == ");
			throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR);
		}
	}
	
	@Data
	public class Rtn {
		Integer successCnt = 0;
		Integer totalCnt = 0;
	}
	
}
