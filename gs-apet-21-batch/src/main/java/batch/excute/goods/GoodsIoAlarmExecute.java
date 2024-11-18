package batch.excute.goods;


import batch.config.util.BatchLogUtil;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmVO;
import biz.app.member.service.MemberIoAlarmService;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import com.google.gson.Gson;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import java.util.*;


/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : batch.excute.goods
 * - 파일명     : GoodsIoAlarmExecute.java
 * - 작성일     : 2021. 03. 30.
 * - 작성자     : valfac
 * - 설명       : 재입고 알림 push 발송 배치
 * 
 * 매일 아침 8:30분
 * </pre>
 */
@Slf4j
@Component
public class GoodsIoAlarmExecute {

	@Autowired private MessageSourceAccessor message;

	@Autowired private MemberIoAlarmService memberIoAlarmService;

	@Autowired private BizService bizService;

	@Autowired private PushService pushService;

	public void cronSendIoAlarm() {

		int total = 0;
		int success = 0;
		int fail = 0;

		BatchLogPO blpo = BatchLogUtil.initBatchLogStrtDtm(CommonConstants.BATCH_GOODS_IO_ALARM_SEND);

		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;

		String nowDateTime = DateUtil.getNowDateTime();
		String sendDateTime = DateUtil.getFormatDate(nowDateTime, "yyyy-MM-dd HH:mm:ss");

		try{

			List<MemberIoAlarmVO> ioAlarmTargetList = memberIoAlarmService.getIoAlarmGoodsTargetList();
			List<String> goodsIds = new ArrayList<>();

			total = ioAlarmTargetList.size();

			if(!ioAlarmTargetList.isEmpty() && ioAlarmTargetList.size()>0) {

				PushSO pso = new PushSO();
				pso.setTmplNo(123L);
				PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회

				for(MemberIoAlarmVO ioAlarmVO : ioAlarmTargetList) {
					List<PushTargetPO> target = new ArrayList<PushTargetPO>();
					SendPushPO ppo = new SendPushPO();
					ppo.setTmplNo(123L);//재입고알림 템플릿

					PushTargetPO tpo = new PushTargetPO();
					tpo.setTo(""+ioAlarmVO.getMbrNo());
					Map<String, String> paramMap = new HashMap<String, String>();
					String movPath = StringUtil.replaceAll(pvo.getMovPath(), CommonConstants.PUSH_TMPL_VRBL_320 , StringUtil.isNull(ioAlarmVO.getPakGoodsId()) ? ioAlarmVO.getGoodsId() : ioAlarmVO.getPakGoodsId());
					tpo.setLandingUrl(movPath);

					paramMap.put(CommonConstants.PUSH_TMPL_VRBL_60, ioAlarmVO.getGoodsNm());//템플릿에서 상품명 치환
					tpo.setParameters(paramMap);
					target.add(tpo);

					ppo.setTarget(target);
					ppo.setReservationDateTime(sendDateTime);

					try {
						String noticeSendNoStr = bizService.sendPush(ppo);

						//return String[] => Gson gson
						if (StringUtil.isNotEmpty(noticeSendNoStr)) {
							Gson gson = new Gson();
							String[] result = gson.fromJson(noticeSendNoStr, String[].class);
							//항상 첫번째 번호
							int noticeSendNo = Integer.parseInt(result[0]);

							MemberIoAlarmPO po = new MemberIoAlarmPO();
							po.setGoodsIoAlmNo(ioAlarmVO.getGoodsIoAlmNo());
							//po.setSysDelrNo(CommonConstants.COMMON_BATCH_USR_NO);
							//예약발송이지만 푸시 후 업뎃은 현재 없음. 발송 성공으로 간주
							po.setAlmYn(CommonConstants.COMM_YN_Y);
							//발송 후 시스템 삭제로 간주
							//po.setSysDelYn(CommonConstants.COMM_YN_Y);
							//예약발송
							po.setAlmSndDtm(sendDateTime);
							//푸시No
							po.setNoticeSendNo(noticeSendNo);
							//업데이트
							memberIoAlarmService.updateIoAlarm(po);

							//성공 건수
							success ++;

							if(!goodsIds.contains(ioAlarmVO.getGoodsId())) {
								goodsIds.add(ioAlarmVO.getGoodsId());
							}

						} else {
							//실패 건수
							fail ++;
						}

					} catch (Exception e) {
						//실패 건수
						fail ++;
					}
				}
			}

			//발송 후 재입고 대상 상품 삭제
			if(goodsIds.size() > 0) {
				int removeCnt = memberIoAlarmService.removeIoAlarmGoodsTargetList(goodsIds);
				log.debug("===발송 후 재입고 대상 상품 삭제 : {0}", removeCnt );
			}

		}catch(Exception e) {

			batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;

		}

		String batchRstMsg= this.message.getMessage("batch.log.result.msg.goods.success", new Object[] { total, success, fail});
		BatchLogUtil.addBatchLog(blpo, batchRstCd, batchRstMsg);
	}
}
