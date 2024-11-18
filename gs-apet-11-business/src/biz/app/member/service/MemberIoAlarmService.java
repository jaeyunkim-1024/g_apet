package biz.app.member.service;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsIoAlmVO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmSO;
import biz.app.member.model.MemberIoAlarmVO;

import java.util.List;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.member.dao
 * - 파일명		: MemberIoAlarmDao.java
 * - 작성일		: 2021. 2. 26.
 * - 작성자		: velueFactory
 * - 설명		: 입고알림 Service
 * </pre>
 */
public interface MemberIoAlarmService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberAddressDao.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: velueFactory
	 * - 설명		: 입고 알림 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	int insertIoAlarm(MemberIoAlarmPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberAddressDao.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: velueFactory
	 * - 설명		: 입고 알림 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	int updateIoAlarm(MemberIoAlarmPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberAddressDao.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: velueFactory
	 * - 설명		: 입고 알림 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	int deleteIoAlarm(MemberIoAlarmPO po);

	List<MemberIoAlarmVO> getIoAlarm(MemberIoAlarmPO po);

	List<GoodsBaseVO> selectIoAlarmList(MemberIoAlarmSO so);

	Integer selectIoAlarmListTotalCount(MemberIoAlarmSO so);

	List<MemberIoAlarmVO> getIoAlarmGoodsTargetList();

	List<GoodsIoAlmVO> getIoAlarmList(MemberIoAlarmSO so);

	int removeIoAlarmGoodsTargetList(List<String> goodsIds);
}