package biz.app.order.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.OrderDlvrAreaDao;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.SlotInquirySO;
import biz.interfaces.cis.model.response.order.SlotInquiryItemVO;
import biz.interfaces.cis.model.response.order.SlotInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: OrderDlvrAreaServiceImpl.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class OrderDlvrAreaServiceImpl implements OrderDlvrAreaService {

	@Autowired private CacheService cacheService;
	
	@Autowired private OrderDlvrAreaDao orderDlvrAreaDao;
	
	@Autowired private CisOrderService cisOrderService;
	
	@Autowired private MessageSourceAccessor message;
	
	private static final String YYYYMMDD = "yyyyMMdd";
	private static final String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";
	
	@Override
	public List<OrderDlvrAreaVO> getDlvrPrcsListFromTime(String postNo) {
		
		List<OrderDlvrAreaVO> list = new ArrayList<>();
		//현재 시간
		Timestamp now = DateUtil.getTimestamp();
		
		//현재 날짜
		String nowDt = DateUtil.getTimestampToString(now);
		
		
		OrderDlvrAreaVO matchDtVO = null;
		
		/** 당일 배송 set - start */
		//oneDay
		CodeDetailVO oneDay  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_20);
		OrderDlvrAreaVO oneDayArea = null;
		OrderDlvrAreaSO oneDaySO = new OrderDlvrAreaSO();
		OrderDlvrAreaVO oneDayVO = new OrderDlvrAreaVO();
		oneDayVO.setDlvrPrcsTpCd(oneDay.getDtlCd());
		
		if(StringUtil.isNotEmpty(postNo)) {
			oneDaySO.setPostNo(postNo);
			oneDaySO.setDlvrPrcsTpCd(oneDay.getDtlCd());
			
			oneDayArea = orderDlvrAreaDao.getDlvrAreaInfo(oneDaySO);
			
			if(oneDayArea != null) {
				oneDayVO.setIsPostArea(true);
				oneDayVO.setDlvrCntrCd(oneDayArea.getDlvrCntrCd());
				oneDayVO.setDlvrAreaCd(oneDayArea.getDlvrAreaCd());
			}
		}
		
		Timestamp dlvrDateTime = null;
		int dlvrleftDt = -1;
		
		OrderDlvrAreaSO so = new OrderDlvrAreaSO();
		so.setNowDateTime(now);
		so.setDlvrPrcsTpCd(oneDay.getDtlCd());
		so.setTimeCheckYn("Y");
		List<OrderDlvrAreaVO> oneClsdDtList = orderDlvrAreaDao.listDlvrAreaClsdDt(so);
		
		Timestamp oneDayCloseTime = DateUtil.getTimestamp(nowDt + oneDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		
		//마감시간 전
		if (now.before(oneDayCloseTime)) {
			dlvrDateTime = DateUtil.getTimestamp(nowDt + oneDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 0;
		}else {
			String nextDt = DateUtil.addDay(nowDt, YYYYMMDD, 1);
			dlvrDateTime = DateUtil.getTimestamp(nextDt + oneDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			oneDayCloseTime = DateUtil.getTimestamp(nextDt + oneDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 1;
		}
		
		String targetOneDt = DateUtil.getTimestampToString(dlvrDateTime);
		
		matchDtVO = oneClsdDtList.stream().filter(vo ->  Long.valueOf(vo.getClsdStrtDt()) >= Long.valueOf(targetOneDt) && Long.valueOf(vo.getClsdEndDt()) <= Long.valueOf(targetOneDt))
				.findFirst().orElse(null);
		//휴무일 포함 체크
		if(matchDtVO != null) {
			this.getHolidayText(oneDayVO, matchDtVO);
		}else {
			oneDayVO.setOrdDt(targetOneDt);
			oneDayVO.setOrdDateTime(dlvrDateTime);
			if(dlvrleftDt == 0) {
				oneDayVO.setDlvrTimeShowText("오늘밤 도착 예정");
				oneDayVO.setOrdDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tody") , targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));
			}else if(dlvrleftDt == 1) {
				oneDayVO.setDlvrTimeShowText("내일 오후 도착 예정");
				oneDayVO.setOrdDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));
			}
			
		}
		
		
		if(StringUtil.isNotEmpty(oneDayVO.getOrdDt())) {
			this.getRestTimeShowText(oneDayVO, now, oneDayCloseTime);
			if(oneDayVO.getIsPostArea()) {
				oneDayVO.setDlvrAreaNo(oneDayArea.getDlvrAreaNo());
				
				SlotInquirySO cisSO = new SlotInquirySO();
				cisSO.setDlvtTpCd(oneDayVO.getDlvrPrcsTpCd());
				cisSO.setYmd(oneDayVO.getOrdDt());
				cisSO.setZipcode(postNo);
				cisSO.setMallId(oneDayVO.getDlvrCntrCd());
				cisSO.setDlvGrpCd(oneDayVO.getDlvrAreaCd());
				
				try {
					SlotInquiryVO slotVO = cisOrderService.listSlot(cisSO);
					
					if(CommonConstants.CIS_API_SUCCESS_CD.equals(slotVO.getResCd())) {
						List<SlotInquiryItemVO> itemList = slotVO.getItemList();
						
						if(CollectionUtils.isEmpty(itemList)) {
							oneDayVO.setIsCisSlotClose(true);
						}else {
							for(SlotInquiryItemVO item : itemList) {
								if(item.getSlotCnt() <= item.getUsedCnt()) {
									oneDayVO.setIsCisSlotClose(true);
								}
							}
						}
					}
				} catch (Exception e) {
					log.error("CIS 슬롯 조회 인터페이스 오류");
					oneDayVO.setIsCisSlotClose(true);
				}
					
				
			}
		}
		
		list.add(oneDayVO);
		
		/** 당일 배송 set - end */
		
		
		dlvrDateTime = null;
		dlvrleftDt = -1;
		String cisIfDt = "";
		
		/** 새벽 배송 set - start */
		
		CodeDetailVO dawnDay  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_21);
		OrderDlvrAreaVO dawnDayArea = null;
		OrderDlvrAreaSO dawnDaySO = new OrderDlvrAreaSO();
		OrderDlvrAreaVO dawnDayVO = new OrderDlvrAreaVO();
		dawnDayVO.setDlvrPrcsTpCd(dawnDay.getDtlCd());
		
		if(StringUtil.isNotEmpty(postNo)) {
			dawnDaySO.setPostNo(postNo);
			dawnDaySO.setDlvrPrcsTpCd(dawnDay.getDtlCd());
			
			dawnDayArea = orderDlvrAreaDao.getDlvrAreaInfo(dawnDaySO);
			
			if(dawnDayArea != null) {
				dawnDayVO.setIsPostArea(true);
				dawnDayVO.setDlvrCntrCd(dawnDayArea.getDlvrCntrCd());
				dawnDayVO.setDlvrAreaCd(dawnDayArea.getDlvrAreaCd());
			}
		}
		
		OrderDlvrAreaSO dawnSO = new OrderDlvrAreaSO();
		dawnSO.setNowDateTime(now);
		dawnSO.setDlvrPrcsTpCd(dawnDay.getDtlCd());
		dawnSO.setTimeCheckYn("Y");
		List<OrderDlvrAreaVO> dawnClsdDtList = orderDlvrAreaDao.listDlvrAreaClsdDt(dawnSO);
		
		Timestamp dawnDayCloseTime = DateUtil.getTimestamp(nowDt + dawnDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		
		String nextDt = DateUtil.addDay(nowDt, YYYYMMDD, 1);
		//마감시간 전
		if (now.before(dawnDayCloseTime)) {
			dlvrDateTime = DateUtil.getTimestamp(nextDt + dawnDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 1;
			cisIfDt = nowDt; 
		}else {
			String twoAfterDt = DateUtil.addDay(nowDt, YYYYMMDD, 2);
			dlvrDateTime = DateUtil.getTimestamp(twoAfterDt + dawnDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dawnDayCloseTime = DateUtil.getTimestamp(nextDt + dawnDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 2;
			cisIfDt = nextDt;
		}
		
		String targetDawnDt = DateUtil.getTimestampToString(dlvrDateTime);
		
		matchDtVO = dawnClsdDtList.stream().filter(vo ->  Long.valueOf(vo.getClsdStrtDt()) >= Long.valueOf(targetDawnDt) && Long.valueOf(vo.getClsdEndDt()) <= Long.valueOf(targetDawnDt))
				.findFirst().orElse(null);
		//휴무일 포함 체크
		if(matchDtVO != null) {
			this.getHolidayText(dawnDayVO, matchDtVO);
		}else {
			dawnDayVO.setOrdDt(targetDawnDt);
			dawnDayVO.setOrdDateTime(dlvrDateTime);
			if(dlvrleftDt == 1) {
				dawnDayVO.setDlvrTimeShowText("내일 오전 도착 예정");
				dawnDayVO.setOrdDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));
			}else if(dlvrleftDt == 2) {
				dawnDayVO.setDlvrTimeShowText("모레 오전 도착 예정");
				dawnDayVO.setOrdDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.day_after_tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));
			}
			
		}
		
		
		if(StringUtil.isNotEmpty(dawnDayVO.getOrdDt())) {
			this.getRestTimeShowText(dawnDayVO, now, dawnDayCloseTime);
			if(dawnDayVO.getIsPostArea()) {
				dawnDayVO.setDlvrAreaNo(dawnDayArea.getDlvrAreaNo());
				
				SlotInquirySO cisSO = new SlotInquirySO();
				cisSO.setDlvtTpCd(dawnDayVO.getDlvrPrcsTpCd());
				cisSO.setYmd(cisIfDt);
				cisSO.setZipcode(postNo);
				cisSO.setMallId(dawnDayVO.getDlvrCntrCd());
				cisSO.setDlvGrpCd(dawnDayVO.getDlvrAreaCd());
				
				try {
					SlotInquiryVO slotVO = cisOrderService.listSlot(cisSO);
					
					if(CommonConstants.CIS_API_SUCCESS_CD.equals(slotVO.getResCd())) {
						List<SlotInquiryItemVO> itemList = slotVO.getItemList();
						
						if(CollectionUtils.isEmpty(itemList)) {
							dawnDayVO.setIsCisSlotClose(true);
						}else {
							for(SlotInquiryItemVO item : itemList) {
								if(item.getSlotCnt() <= item.getUsedCnt()) {
									dawnDayVO.setIsCisSlotClose(true);
								}
							}
						}
					}
				} catch (Exception e) {
					log.error("CIS 슬롯 조회 인터페이스 오류");
					dawnDayVO.setIsCisSlotClose(true);
				}
				
			}
		}
		
		list.add(dawnDayVO);
		/** 새벽 배송 set - end */
		
		/** 택배 배송 set - start */
		//현재 16시 이후일 경우 다음날 16시로 계산 - 휴무일 체크 안함.
		//pack
		CodeDetailVO pack  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_10);
		OrderDlvrAreaVO packVO = new OrderDlvrAreaVO();
		packVO.setDlvrPrcsTpCd(pack.getDtlCd());
		Timestamp packCloseTime = DateUtil.getTimestamp(nowDt + pack.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		if (!now.before(packCloseTime)) {
			packCloseTime = DateUtil.getTimestamp(nextDt + pack.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		}
		
		this.getRestTimeShowText(packVO, now, packCloseTime);
		/* 2021.05.31 사용안하는것 같음*/
		packVO.setDlvrTimeShowText("1~4일 소요 예정");
		packVO.setOrdDlvrTimeShowText("1~4일 소요 예정");
		
		list.add(packVO);
		
		/** 택배 배송 set - end */
		return list;
	}

	@Override
	public List<OrderDlvrAreaVO> listDlvrAreaInfo(OrderDlvrAreaSO so){
		return orderDlvrAreaDao.listDlvrAreaInfo(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 07.
	 * - 작성자		: JinHong
	 * - 설명		: 남은 시간 return
	 * </pre>
	 * @param vo
	 * @param nowTime
	 * @param targetTime
	 */
	@SuppressWarnings("unused")
	private void getRestTimeShowText(OrderDlvrAreaVO vo, Timestamp nowTime, Timestamp targetTime) {
		//요일 한글
		if(StringUtil.isNotEmpty(vo.getOrdDt())) {
			vo.setOrdDayOfWeek(DateUtil.getKoreanDay(DateUtil.getDate(vo.getOrdDt())));
		}
		long diff = targetTime.getTime() - nowTime.getTime();
		long diffMinute = (long) Math.ceil(diff / (60 * 1000));
		long diffHour  = (long) Math.floor(diffMinute / 60);
		long mod = diffMinute % 60;
		
		String restHour = String.valueOf(diffHour);
		if(restHour.length() == 1) {
			restHour = "0" + restHour; 
		}
		vo.setRestTimeHour(restHour);
		
		String restMinute = String.valueOf(mod);
		if(restMinute.length() == 1) {
			restMinute = "0" + restMinute; 
		}
		vo.setRestTimeMinute(restMinute);
		
		if("00".equals(restHour)) {
			vo.setRestTimeShowText(restMinute + "분");
		}else {
			vo.setRestTimeShowText(restHour+"시 "+restMinute + "분");
		}
		
		vo.setTargetCloseDtm(targetTime);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 07.
	 * - 작성자		: JinHong
	 * - 설명		: 휴무일자 set
	 * </pre>
	 * @param vo
	 * @param matchDt
	 */
	private void getHolidayText(OrderDlvrAreaVO vo, OrderDlvrAreaVO matchDt) {
		if(matchDt.getClsdStrtDt().equals(matchDt.getClsdEndDt())) {
			String clsdDt = matchDt.getClsdStrtDt();
			vo.setRestTimeShowText(clsdDt.substring(4, 6)+ "/" +  clsdDt.substring(6, 8)+" 배송 휴무");
		}else {
			String clsdStrtDt = matchDt.getClsdStrtDt();
			String clsdEndDt = matchDt.getClsdEndDt();
			vo.setRestTimeShowText(clsdStrtDt.substring(4, 6)+ "/" +  clsdStrtDt.substring(6, 8) + "~" + clsdEndDt.substring(4, 6)+ "/" +  clsdEndDt.substring(6, 8));
		}
		
		vo.setIsHoliday(true);
	}

	@Override
	public OrderDlvrAreaVO validOrderDlvr(OrderDlvrAreaSO so) {
		OrderDlvrAreaVO result = new OrderDlvrAreaVO();
		String exCode = "";
		String exMsg = "";
		List<OrderDlvrAreaVO> dlvrList = this.getDlvrPrcsListFromTime(so.getPostNo());
		
		OrderDlvrAreaVO selDlvr = dlvrList.stream().filter(vo -> vo.getDlvrPrcsTpCd().equals(so.getDlvrPrcsTpCd())).findFirst().orElse(new OrderDlvrAreaVO());
		
		if(selDlvr != null) {
			if(selDlvr.getIsCisSlotClose()) {
				//CIS 슬롯 재고 여부
				//상품 예정일 변경 팝업
				exCode = ExceptionConstants.ERROR_CHANGE_ORD_DT;
				exMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + exCode);
			}
			
			if(!so.getOrdDt().equals(selDlvr.getOrdDt())){
				//상품 예정일 변경 팝업
				exCode = ExceptionConstants.ERROR_CHANGE_ORD_DT;
				exMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + exCode);
			}
		}
		
		result.setExCode(exCode);
		result.setExMsg(exMsg);
		return result;
	}
	
	@Override
	public List<OrderDlvrAreaVO> getDlvrPrcsListForGoodsDetail() {
		
		List<OrderDlvrAreaVO> list = new ArrayList<>();
		//현재 시간
		Timestamp now = DateUtil.getTimestamp();
		
		//현재 날짜
		String nowDt = DateUtil.getTimestampToString(now);
		
		//now = DateUtil.getTimestamp(nowDt + "1100000", YYYYMMDDHHMMSS);
		//now = DateUtil.getTimestamp(nowDt + "1200000", YYYYMMDDHHMMSS);
		//now = DateUtil.getTimestamp(nowDt + "2200000", YYYYMMDDHHMMSS);
		
		/** 당일 배송 set - start */
		//oneDay
		CodeDetailVO oneDay  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_20);
		OrderDlvrAreaVO oneDayVO = new OrderDlvrAreaVO();
		oneDayVO.setDlvrPrcsTpCd(oneDay.getDtlCd());
		
		Timestamp dlvrDateTime = null;
		int dlvrleftDt = -1;
		
		OrderDlvrAreaSO so = new OrderDlvrAreaSO();
		so.setNowDateTime(now);
		so.setDlvrPrcsTpCd(oneDay.getDtlCd());
		OrderDlvrAreaVO oneClsdDt = orderDlvrAreaDao.dlvrAreaClsdDt(so);
		
		Timestamp oneDayCloseTime = DateUtil.getTimestamp(nowDt + oneDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		
		//마감시간 전
		if (now.before(oneDayCloseTime)) {
			dlvrDateTime = DateUtil.getTimestamp(nowDt + oneDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 0;
		}else {
			String nextDt = DateUtil.addDay(nowDt, YYYYMMDD, 1);
			dlvrDateTime = DateUtil.getTimestamp(nextDt + oneDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			oneDayCloseTime = DateUtil.getTimestamp(nextDt + oneDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 1;
		}
		
		String targetOneDt = DateUtil.getTimestampToString(dlvrDateTime);
		
		//휴무일 포함 체크
		if(oneClsdDt != null) {// 휴무일이 있는경우 
			if(dlvrleftDt == 0) { // 21:00  이전 주문시
				if(nowDt.equals(oneClsdDt.getClsdEndDt())) {//당일 휴무
					oneDayVO.setIsHoliday(true);
					oneDayVO.setRestTimeShowText(oneClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  oneClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else if(oneClsdDt.getClsdStrtDt().equals(oneClsdDt.getClsdEndDt())) {//다음날 휴일인경우
					oneDayVO.setOrdDt(targetOneDt);
					oneDayVO.setOrdDateTime(dlvrDateTime);
//					oneDayVO.setDlvrTimeShowText("오늘밤 도착 예정");
					oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tody") , targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));					
				}else if(!oneClsdDt.getClsdStrtDt().equals(oneClsdDt.getClsdEndDt())){//연휴인경우
					oneDayVO.setOrdDt(targetOneDt);
					oneDayVO.setOrdDateTime(dlvrDateTime);
//					oneDayVO.setDlvrTimeShowText("오늘밤 도착 예정");
					oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tody") , targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));										
				}else {//다음날 평일인 경우 
					oneDayVO.setOrdDt(targetOneDt);
					oneDayVO.setOrdDateTime(dlvrDateTime);
//					oneDayVO.setDlvrTimeShowText("내일 오후 도착 예정");
					oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));
				}
			}else{// 21:00 이후 주문시
				if(nowDt.equals(oneClsdDt.getClsdEndDt())){////당일 휴무
					oneDayVO.setOrdDt(targetOneDt);
					oneDayVO.setOrdDateTime(dlvrDateTime);
//					oneDayVO.setDlvrTimeShowText("내일 오후 도착 예정");
					oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));					
				}else if(oneClsdDt.getClsdStrtDt().equals(oneClsdDt.getClsdEndDt())) {//다음날 휴일인경우
					oneDayVO.setIsHoliday(true);
					oneDayVO.setRestTimeShowText(oneClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  oneClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else if(!oneClsdDt.getClsdStrtDt().equals(oneClsdDt.getClsdEndDt())){//연휴인경우
					oneDayVO.setIsHoliday(true);
					oneDayVO.setRestTimeShowText(oneClsdDt.getClsdStrtDt().substring(4, 6)+ "/" +  oneClsdDt.getClsdStrtDt().substring(6, 8) + "~" 
							+ oneClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  oneClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else {//다음날 평일인 경우 
					oneDayVO.setOrdDt(targetOneDt);
					oneDayVO.setOrdDateTime(dlvrDateTime);
//					oneDayVO.setDlvrTimeShowText("내일 오후 도착 예정");
					oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));					
				}
			}
		}else {// 휴무일이 없는경우 
			oneDayVO.setOrdDt(targetOneDt);
			oneDayVO.setOrdDateTime(dlvrDateTime);
			if(dlvrleftDt == 0) {
//				oneDayVO.setDlvrTimeShowText("오늘밤 도착 예정");
				oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tody") , targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));														
			}else if(dlvrleftDt == 1) {
//				oneDayVO.setDlvrTimeShowText("내일 오후 도착 예정");
				oneDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_20", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetOneDt.substring(4, 6)+ "/" +  targetOneDt.substring(6, 8)}));									
			}
		}
		
		
		if(StringUtil.isNotEmpty(oneDayVO.getOrdDt())) {
			this.getRestTimeShowText(oneDayVO, now, oneDayCloseTime);
		}
		
		list.add(oneDayVO);
		
		/** 당일 배송 set - end */
		
		
		dlvrDateTime = null;
		dlvrleftDt = -1;
		
		
		/** 새벽 배송 set - start */
		
		CodeDetailVO dawnDay  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_21);
		OrderDlvrAreaVO dawnDayVO = new OrderDlvrAreaVO();
		dawnDayVO.setDlvrPrcsTpCd(dawnDay.getDtlCd());
		
		OrderDlvrAreaSO dawnSO = new OrderDlvrAreaSO();
		dawnSO.setNowDateTime(now);
		dawnSO.setDlvrPrcsTpCd(dawnDay.getDtlCd());
		OrderDlvrAreaVO dawnClsdDt = orderDlvrAreaDao.dlvrAreaClsdDt(dawnSO);
		
		Timestamp dawnDayCloseTime = DateUtil.getTimestamp(nowDt + dawnDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		
		String nextDt = DateUtil.addDay(nowDt, YYYYMMDD, 1);
		//마감시간 전
		if (now.before(dawnDayCloseTime)) {
			dlvrDateTime = DateUtil.getTimestamp(nextDt + dawnDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 1;
		}else {
			String twoAfterDt = DateUtil.addDay(nowDt, YYYYMMDD, 2);
			dlvrDateTime = DateUtil.getTimestamp(twoAfterDt + dawnDay.getUsrDfn2Val(), YYYYMMDDHHMMSS);
			dawnDayCloseTime = DateUtil.getTimestamp(nextDt + dawnDay.getUsrDfn1Val(), YYYYMMDDHHMMSS);
			dlvrleftDt = 2;
		}
		
		String targetDawnDt = DateUtil.getTimestampToString(dlvrDateTime);
		//휴무일 포함 체크
		if(dawnClsdDt != null) {// 휴무일이 있는경우 
			if(dlvrleftDt == 1) { // 11:30  이전 주문시
				if(nowDt.equals(dawnClsdDt.getClsdEndDt())) {//당일 휴무
					dawnDayVO.setOrdDt(targetDawnDt);
					dawnDayVO.setOrdDateTime(dlvrDateTime);
//					dawnDayVO.setDlvrTimeShowText("내일 오전 도착 예정");
					dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));					
				}else if(dawnClsdDt.getClsdStrtDt().equals(dawnClsdDt.getClsdEndDt())) {//다음날 휴일인경우
					dawnDayVO.setIsHoliday(true);
					dawnDayVO.setRestTimeShowText(dawnClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  dawnClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else if(!dawnClsdDt.getClsdStrtDt().equals(dawnClsdDt.getClsdEndDt())){//연휴인경우
					dawnDayVO.setIsHoliday(true);
					dawnDayVO.setRestTimeShowText(dawnClsdDt.getClsdStrtDt().substring(4, 6)+ "/" +  dawnClsdDt.getClsdStrtDt().substring(6, 8) + "~" 
							+ dawnClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  dawnClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else {//다음날 평일인 경우 
					dawnDayVO.setOrdDt(targetDawnDt);
					dawnDayVO.setOrdDateTime(dlvrDateTime);
//					dawnDayVO.setDlvrTimeShowText("내일 오전 도착 예정");
					dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));					
				}
			}else {// 11:30 이후 주문시
				if(nowDt.equals(dawnClsdDt.getClsdEndDt())){////당일 휴무
					dawnDayVO.setOrdDt(targetDawnDt);
					dawnDayVO.setOrdDateTime(dlvrDateTime);
//					dawnDayVO.setDlvrTimeShowText("모레 오전 도착 예정");
					dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.day_after_tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));					
				}else if(dawnClsdDt.getClsdStrtDt().equals(dawnClsdDt.getClsdEndDt())) {//다음날 휴일인경우
					dawnDayVO.setOrdDt(targetDawnDt);
					dawnDayVO.setOrdDateTime(dlvrDateTime);
//					dawnDayVO.setDlvrTimeShowText("모레 오전 도착 예정");
					dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.day_after_tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));										
				}else if(!dawnClsdDt.getClsdStrtDt().equals(dawnClsdDt.getClsdEndDt())){//연휴인경우
					dawnDayVO.setIsHoliday(true);
					dawnDayVO.setRestTimeShowText(dawnClsdDt.getClsdStrtDt().substring(4, 6)+ "/" +  dawnClsdDt.getClsdStrtDt().substring(6, 8) + "~" 
							+ dawnClsdDt.getClsdEndDt().substring(4, 6)+ "/" +  dawnClsdDt.getClsdEndDt().substring(6, 8)+" 배송 휴무");
				}else {//다음날 평일인 경우 
					dawnDayVO.setOrdDt(targetDawnDt);
					dawnDayVO.setOrdDateTime(dlvrDateTime);
//					dawnDayVO.setDlvrTimeShowText("내일 오전 도착 예정");
					dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));										
				}
			}
		}else {
			dawnDayVO.setOrdDt(targetDawnDt);
			dawnDayVO.setOrdDateTime(dlvrDateTime);
			if(dlvrleftDt == 1) {
//				dawnDayVO.setDlvrTimeShowText("내일 오전 도착 예정");
				dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));									
			}else if(dlvrleftDt == 2) {
//				dawnDayVO.setDlvrTimeShowText("모레 오전 도착 예정");
				dawnDayVO.setDlvrTimeShowText(message.getMessage("front.web.view.order.dlvrTime.dlvrPrcsTp_30", new String[] {message.getMessage("front.web.view.order.dlvrTime.day_after_tomorrow"), targetDawnDt.substring(4, 6)+ "/" +  targetDawnDt.substring(6, 8)}));									
			}
		}
		
		
		if(StringUtil.isNotEmpty(dawnDayVO.getOrdDt())) {
			this.getRestTimeShowText(dawnDayVO, now, dawnDayCloseTime);
		}
		
		list.add(dawnDayVO);
		/** 새벽 배송 set - end */
		
		/** 택배 배송 set - start */
		//현재 16시 이후일 경우 다음날 16시로 계산 - 휴무일 체크 안함.
		//pack
		CodeDetailVO pack  = cacheService.getCodeCache(CommonConstants.DLVR_PRCS_TP, CommonConstants.DLVR_PRCS_TP_10);
		OrderDlvrAreaVO packVO = new OrderDlvrAreaVO();
		packVO.setDlvrPrcsTpCd(pack.getDtlCd());
		Timestamp packCloseTime = DateUtil.getTimestamp(nowDt + pack.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		if (!now.before(packCloseTime)) {
			packCloseTime = DateUtil.getTimestamp(nextDt + pack.getUsrDfn1Val(), YYYYMMDDHHMMSS);
		}
		
		this.getRestTimeShowText(packVO, now, packCloseTime);
		/* 2021.05.31 사용안하는것 같음*/
		packVO.setDlvrTimeShowText("1~4일 소요 예정");
		packVO.setOrdDlvrTimeShowText("1~4일 소요 예정");
		
		list.add(packVO);
		
		/** 택배 배송 set - end */
		return list;
	}	
	
	private void getHolidayTextMake(OrderDlvrAreaVO vo, OrderDlvrAreaVO matchDt) {
		if(matchDt.getClsdStrtDt().equals(matchDt.getClsdEndDt())) {
			String clsdDt = matchDt.getClsdStrtDt();
			vo.setRestTimeShowText(clsdDt.substring(4, 6)+ "/" +  clsdDt.substring(6, 8)+" 배송 휴무");
		}else {
			String clsdStrtDt = matchDt.getClsdStrtDt();
			String clsdEndDt = matchDt.getClsdEndDt();
			vo.setRestTimeShowText(clsdStrtDt.substring(4, 6)+ "/" +  clsdStrtDt.substring(6, 8) + "~" + clsdEndDt.substring(4, 6)+ "/" +  clsdEndDt.substring(6, 8)+" 배송 휴무");
		}
		
		vo.setIsHoliday(true);
	}	
}
