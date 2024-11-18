package front.web.view.mypage.controller;


import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsIoAlmVO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmSO;
import biz.app.member.model.MemberIoAlarmVO;
import biz.app.member.service.MemberIoAlarmService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import kcb.module.v3.crypto.symmetric.KISA_SEED_CBC;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * <pre>
 * - 프로젝트명	: 31.front.web
 * - 패키지명	: front.web.view.mypage.controller
 * - 파일명		: MyIoAlarmController.java
 * - 작성일		: 2016. 3. 2.
 * - 작성자		: snw
 * - 설명		: 재입고 알림 컨트롤러
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("mypage")
public class MyIoAlarmController {

	@Autowired private MemberIoAlarmService memberIoAlarmService;


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명	: MyIoAlarmController.java
	 * - 작성일	: 2021. 3. 28.
	 * - 작성자 	: valfac
	 * - 설명 		: 재입고 알림 목록
	 * </pre>
	 *
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value = "indexIoAlarmList")
	public String indexIoAlarmList(MemberIoAlarmSO so, ModelMap map, ViewBase view, Session session) {
		Integer page = Optional.ofNullable(so.getPage()).orElseGet(()->1);
		int totalPage = 0;

		if(page < 1) {page = 1;}

		so.setPage(page);
		so.setRows(FrontConstants.PAGE_ROWS_20);
		so.setLimit((page-1) * so.getRows());
		so.setOffset(so.getRows());
		so.setMbrNo(session.getMbrNo());

		List<GoodsIoAlmVO> ioAlarmList = memberIoAlarmService.getIoAlarmList(so);

		int totalCount = ioAlarmList.size();
		totalPage = (int)(totalCount/so.getRows()) + (totalCount%so.getRows()>0?1:0);
		
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("ioAlarmList", ioAlarmList);
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);

		map.put("session", session);
		map.put("view", view);
		map.put("page", so.getPage());

		return TilesView.none(new String[] { "mypage", "goods", "indexIoAlarmList" });
	}

	@RequestMapping(value = "loadIoAlarmList")
	public String loadIoAlarmList(ModelMap map, ViewBase view, Session session, MemberIoAlarmSO so) {
		List<GoodsBaseVO> ioAlarmList = new ArrayList<GoodsBaseVO>();
		Integer page = Optional.ofNullable(so.getPage()).orElseGet(()->1);
		if(page < 1) {page = 1;}
		int totalPage = 0;
		if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			so.setPage(page);
			so.setRows(FrontConstants.PAGE_ROWS_20);
			so.setLimit((page-1) * so.getRows());
			so.setOffset(so.getRows());

			so.setMbrNo(session.getMbrNo());
			//so.setSysDelYn(FrontConstants.COMM_YN_N);
			so.setDelYn(FrontConstants.COMM_YN_N);
			so.setGoodsId(null);
			so.setPakGoodsId(null);

			ioAlarmList = this.memberIoAlarmService.selectIoAlarmList(so);

			int totalCount = this.memberIoAlarmService.selectIoAlarmListTotalCount(so);
			totalPage = (int)(totalCount/so.getRows()) + (totalCount%so.getRows()>0?1:0);
		}
		map.put("ioAlarmList", ioAlarmList);
		map.put("session", session);
		map.put("view", view);
		map.put("page", so.getPage());
		map.put("totalPage", totalPage);

		return TilesView.none(new String[] { "mypage", "goods", "include", "includeIoAlarmList" });
	}


	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: MyIoAlarmController.java
	 * - 작성일		: 2021. 3. 29
	 * - 작성자		: valueFactory
	 * - 설명		: 입고 알림 삭제
	 * </pre>
	 * @param po
	 * @param session
	 * @param view
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteIoAlarm")
	@ResponseBody
	public ModelMap deleteIoAlarm(MemberIoAlarmPO po, Session session, ViewBase view, HttpServletRequest request){
		ModelMap map = new ModelMap();

		String message = "";
		if(session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			message = "login";
		}else{
			String goodsId = po.getGoodsId();
			if(StringUtils.isNotEmpty(goodsId)) {
				String[] goodsIds = goodsId.split(":");
				po.setGoodsId(goodsIds[0]);
				if(goodsIds.length>1) {
					po.setPakGoodsId(goodsIds[1]);
				}
			}
			po.setMbrNo(session.getMbrNo());
			po.setDelYn("N");
			po.setSysDelYn("N");
			List<MemberIoAlarmVO> alarmList = memberIoAlarmService.getIoAlarm(po);
			if(alarmList == null || alarmList.isEmpty()) {
				message = "noData";
			}else{
				// 이미 알림 등록된 상태
				MemberIoAlarmVO alarmVO = alarmList.stream().findFirst().orElse(new MemberIoAlarmVO());

				if( CommonConstants.COMM_YN_Y.contentEquals( alarmVO.getDelYn() ) || CommonConstants.COMM_YN_Y.contentEquals( alarmVO.getSysDelYn() ) ) {
					message = "deleted";
				}else{
					po.setGoodsIoAlmNo(alarmVO.getGoodsIoAlmNo());
					if(po.getGoodsIoAlmNo() != null) {
						po.setDelYn("Y");
						po.setSysDelYn("Y");
						po.setSysDelrNo(session.getMbrNo());
						int result = memberIoAlarmService.deleteIoAlarm(po);
						if(result>0) {
							message = "deleted";
						}else{
							message = "fail";
						}
					}else{
						message = "noData";
					}
				}
				//map.put("alarmVO", alarmVO);
				log.debug("deleteIoAlarm : {}", po);
			}
		}

		map.put("message", message);
		//map.put("session", session);
		//map.put("view", view);

		return  map;
	}

}
