package batch.excute.delivery;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.interfaces.CisOrderReturnStateChgVO;
import biz.app.order.service.interfaces.CisOrderReturnService;
import biz.interfaces.cis.model.request.order.ReturnInquirySO;
import biz.interfaces.cis.model.response.order.ReturnInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 21.batch
* - 패키지명		: batch.excute.delivery
* - 파일명		: CisReturnStateChangeExecute.java
* - 작성일		: 2021. 3. 12.
* - 작성자		: kek01
* - 설명			: CIS 회수 상태 변경
 * </pre>
 */
@Slf4j
@Component
@EnableScheduling
public class CisReturnStateChangeExecute {

	@Autowired private BatchService batchService;
	@Autowired private MessageSourceAccessor message;
	@Autowired private CisOrderReturnService cisOrderReturnService;
	@Autowired private CisOrderService cisOrderService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 21.batch
	 * - 파일명		: CisReturnStateChangeExecute.java
	 * - 작성일		: 2021. 3. 12.
	 * - 작성자		: kek01
	 * - 설명		: CIS 회수 상태 변경 - (반품회수, 교환회수) 회수상태 변경 처리한다
	 *              - 자사 상품일때만	DB 변경만 실행
	 * </pre>
	 */
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로 로컬테스트시
	public void cronCisReturnStateChange() throws Exception {

		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_DLVR_CIS_RETURN_STATE_CHG);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;
		
		String prvCisClaimNo = "";
		ReturnInquirySO param = null;
		ReturnInquiryVO resVO = null;
		
		//------------------------------------------------
		//CIS에 회수 상태 변경 대상조회 (클레임상세구성 TBL 기준)
		//------------------------------------------------
		List<CisOrderReturnStateChgVO> clmDtlCstrtList = cisOrderReturnService.listCisReturnStateChg();

		for(CisOrderReturnStateChgVO vo : clmDtlCstrtList) {
			try {
				//-------------------------------------------------
				//클레임번호 기준으로 CIS 호출 및 배송정보를 조회
				//-------------------------------------------------
				if(!prvCisClaimNo.equals(vo.getCisClmNo())) {
					//CIS API 호출
					param = new ReturnInquirySO();
					param.setRtnsNo(vo.getCisClmNo());
					param.setSrcStaDd(DateUtil.addDay(DateUtil.getNowDate(), -30));
					param.setSrcEndDd(DateUtil.getNowDate());
					resVO = cisOrderService.listReturn(param);
				}
				if(resVO == null) { resVO = new ReturnInquiryVO(); }
				
				//후처리 (응답 Success)
				if(StringUtil.nvl(resVO.getResCd(),"").equals(CommonConstants.CIS_API_SUCCESS_CD)) {
					cisOrderReturnService.updateCisReturnStateChgAfter(vo, resVO.getItemList());
					successCnt++;
					log.info("### 회수상태변경_SUCCESS - clmNo:"+vo.getClmNo()+", clmDtlSeq:"+vo.getClmDtlSeq()+", clmDtlCstrtNo:"+vo.getClmDtlCstrtNo()+", 교환회수여부:"+vo.getExchgRtnYn());
				}
			}catch(Exception ex) {
				log.error("### 회수상태변경_EXCEPTION - clmNo:"+vo.getClmNo()+", clmDtlSeq:"+vo.getClmDtlSeq()+", clmDtlCstrtNo:"+vo.getClmDtlCstrtNo()+", 교환회수여부:"+vo.getExchgRtnYn());
				ex.printStackTrace();
			}
			totalCnt++;

			prvCisClaimNo = vo.getCisClmNo();
			
		}

		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.order.delivery.command.success", new Object[]{totalCnt, successCnt, totalCnt-successCnt}));
		batchService.insertBatchLog(blpo);
	}

}
