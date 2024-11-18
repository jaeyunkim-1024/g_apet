package biz.app.member.service;

import biz.app.goods.dao.GoodsIoAlmDao;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsIoAlmPO;
import biz.app.goods.model.GoodsIoAlmVO;
import biz.app.member.dao.MemberInterestGoodsDao;
import biz.app.member.dao.MemberIoAlarmDao;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmSO;
import biz.app.member.model.MemberIoAlarmVO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.member.dao
 * - 파일명		: MemberIoAlarmDao.java
 * - 작성일		: 2021. 2. 26.
 * - 작성자		: velueFactory
 * - 설명		: 입고알림 ServiceImpl
 * </pre>
 */
@Slf4j
@Transactional
@Service("memberIoAlarmService")
public class MemberIoAlarmServiceImpl implements MemberIoAlarmService {

	@Autowired private MemberIoAlarmDao memberIoAlarmDao;
	@Autowired private GoodsIoAlmDao goodsIoAlmDao;


	@Override
	public int insertIoAlarm(MemberIoAlarmPO po) {
		int result = memberIoAlarmDao.insertIoAlarm(po);
		if(result>0) {
			GoodsIoAlmPO goodsIoAlmPO = new GoodsIoAlmPO();
			goodsIoAlmPO.setGoodsId(po.getGoodsId());
			goodsIoAlmPO.setSndCpltYn(CommonConstants.COMM_YN_N);
			goodsIoAlmPO.setStkQty(0);
			goodsIoAlmPO.setSysRegrNo(CommonConstants.SYSTEM_USR_NO);
			goodsIoAlmDao.insertDupIoAlmTgGoods(goodsIoAlmPO);
		}
		return result;
	}

	@Override
	public int updateIoAlarm(MemberIoAlarmPO po) {
		return memberIoAlarmDao.updateIoAlarm(po);
	}

	@Override
	public int deleteIoAlarm(MemberIoAlarmPO po) {
		return memberIoAlarmDao.deleteIoAlarm(po);
	}

	@Override
	public List<MemberIoAlarmVO> getIoAlarm(MemberIoAlarmPO po) {
		MemberIoAlarmSO so = new MemberIoAlarmSO();
		so.setGoodsId(po.getGoodsId());
		so.setMbrNo(po.getMbrNo());
		so.setDelYn(po.getDelYn());
		if(StringUtils.isNotEmpty(po.getPakGoodsId())) {
			so.setPakGoodsId(po.getPakGoodsId());
		}

		return memberIoAlarmDao.getIoAlarm(so);
	}

	@Override
	public List<GoodsBaseVO> selectIoAlarmList(MemberIoAlarmSO so) {
		List<GoodsBaseVO> ioAlarmList = memberIoAlarmDao.selectIoAlarmList(so);

		return ioAlarmList;
	}

	@Override
	public Integer selectIoAlarmListTotalCount(MemberIoAlarmSO so) {
		return memberIoAlarmDao.selectIoAlarmListTotalCount(so);
	}


	@Override
	public List<MemberIoAlarmVO> getIoAlarmGoodsTargetList() {
		return goodsIoAlmDao.selectIoAlarmGoodsTargetList();
	}

	public List<GoodsIoAlmVO> getIoAlarmList(MemberIoAlarmSO so) { return goodsIoAlmDao.selectIoAlarmList(so); }

	@Override
	public int removeIoAlarmGoodsTargetList(List<String> goodsIds) {
		return goodsIoAlmDao.deleteIoAlarmTargetList(goodsIds);
	}

}