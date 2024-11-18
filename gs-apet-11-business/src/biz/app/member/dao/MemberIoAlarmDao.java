package biz.app.member.dao;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmSO;
import biz.app.member.model.MemberIoAlarmVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberIoAlarmDao.java
* - 작성일		: 2021. 2. 26.
* - 작성자		: velueFactory
* - 설명		: 입고알림 Dao
* </pre>
*/
@Repository
public class MemberIoAlarmDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "ioAlarm.";

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
	public int insertIoAlarm(MemberIoAlarmPO po){
		return insert(BASE_DAO_PACKAGE + "insertIoAlarm", po);
	}

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
	public int updateIoAlarm(MemberIoAlarmPO po){
		return update(BASE_DAO_PACKAGE + "updateIoAlarm", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberAddressDao.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: velueFactory
	 * - 설명		: 입고 알림 단일 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberIoAlarmVO> getIoAlarm(MemberIoAlarmSO so){
		return selectList(BASE_DAO_PACKAGE + "getIoAlarm", so);
	}

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
	public int deleteIoAlarm(MemberIoAlarmPO po){
		return delete(BASE_DAO_PACKAGE + "deleteIoAlarm", po);
	}

	public List<GoodsBaseVO> selectIoAlarmList(MemberIoAlarmSO so) {
		List<GoodsBaseVO> ioAlarmList = new ArrayList<GoodsBaseVO>();
		ioAlarmList = selectList(BASE_DAO_PACKAGE + "selectIoAlarmList", so);
		return ioAlarmList;
	}

	public Integer selectIoAlarmListTotalCount(MemberIoAlarmSO so) {
		return selectOne( BASE_DAO_PACKAGE + "selectIoAlarmListTotalCount", so);
	}
}
