package batch.excute.pet;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.service.PetBatchService;
import biz.app.pet.service.PetService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class PetExecute {
	
	@Autowired PetBatchService petBatchService;
	
	@Autowired private BatchService batchService;
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 
	 * - 파일명		: PetExecute.java
	 * - 작성일		: 2021. 4. 15.
	 * - 작성자		: 조은지
	 * - 설명			: 반려동물 나이 계산 
	 * </pre>
	 */
	public void petAgeCalculate() {
		/**
		 * 데일리 배치(새벽 2시 실행)
		 * 
		 * BIRTH_BATCH 컬럼과 현재날짜 기준으로 년/개월 역산 
		 */
		
		int updateCnt = 0;
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setBatchId(CommonConstants.BATCH_PET_AGE_CALCULATE);
		
		List<PetBasePO> poList = petBatchService.listPetForAgeBatch();
		
		try {
			for(PetBasePO po : poList) {
				updateCnt += petBatchService.updatePetAge(po);
			}
			
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		} catch(Exception e) {
			e.printStackTrace();
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
		} finally {
			String RstMsg = "Success[" + poList.size() + " total, " + updateCnt + " update]";

			blpo.setBatchRstMsg(RstMsg);
			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			
			batchService.insertBatchLog(blpo);
		}
	}
}
