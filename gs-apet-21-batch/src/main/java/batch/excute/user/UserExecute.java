package batch.excute.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.service.UserBatchService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class UserExecute {
	
	@Autowired private UserBatchService userBatchService;
	
	@Autowired private BatchService batchService;
	
	@Autowired private CacheService cacheService;
	
	/**
	 * BO사용자 상태변경 배치
	 * 매일 새벽 3시 실행
	 * 
	 * 로그인한지 30일 경과시 사용자 상태 '사용불가'로 변경
	 */
	public void changeUserStatForUnUsed() {
		int updateCnt = 0;
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setBatchId(CommonConstants.BATCH_USER_STAT_UN_USED);

		CodeDetailVO codeVO = cacheService.getCodeCache(CommonConstants.VARIABLE_CONSTANTS, CommonConstants.VARIABLE_CONSTATNS_USER_LAST_LOGIN_VALID_DAY);
		Integer validDay = Integer.parseInt(codeVO.getUsrDfn1Val());
		
		UserBaseSO so = new UserBaseSO();
		so.setValidDayForBatch(validDay);
		
		List<UserBaseVO> voList = userBatchService.listUserStatForUnUsed(so);
		List<UserBasePO> poList = new ArrayList<UserBasePO>();
		
		try {
			if(voList.size() > 0) {
				for(UserBaseVO vo : voList) {
					UserBasePO po = new UserBasePO();
					po.setUsrNo(vo.getUsrNo());
					poList.add(po);
				}
				
				updateCnt = userBatchService.updateUserStatForUnUsed(poList);
			}
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		} catch(Exception e) {
			e.printStackTrace();
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);	
		} finally {
			String RstMsg = "Success[" + voList.size() + " total, " + updateCnt + " update]";

			blpo.setBatchRstMsg(RstMsg);
			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			
			batchService.insertBatchLog(blpo);
		}
	}
}
