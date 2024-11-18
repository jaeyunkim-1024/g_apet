package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.DeliverDateSetPO;
import biz.app.system.model.DeliverDateSetSO;
import biz.app.system.model.DeliverDateSetVO;
import biz.app.system.model.DeliverDateStatusPO;
import biz.app.system.model.HolidayPO;
import biz.app.system.model.HolidaySO;
import biz.app.system.model.HolidayVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class CapaDao extends MainAbstractDao {

	public int insertDeliverDateSet(DeliverDateSetPO po) {
		return insert("capa.insertDeliverDateSet", po);
	}

	public int updateDeliverDateSet(DeliverDateSetPO po) {
		return update("capa.updateDeliverDateSet", po);
	}

	public DeliverDateSetVO getDeliverDateSet(DeliverDateSetSO so) {
		return (DeliverDateSetVO) selectOne("capa.getDeliverDateSet", so);
	}

	public List<DeliverDateSetVO> listCalendarDeliverDateSet(DeliverDateSetSO so) {
		return selectList("capa.listCalendarDeliverDateSet", so);
	}

	public DeliverDateSetVO getCalendarDeliverDateSet(DeliverDateSetSO so) {
		return (DeliverDateSetVO) selectOne("capa.getCalendarDeliverDateSet", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: HolidayDao.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일관리 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<HolidayVO> listHolidayCalendar(HolidaySO so) {
		return selectList("capa.listHolidayCalendar", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: HolidayDao.java
	 * - 작성일		: 2016. 6. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일 관리 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public HolidayVO getHolidayCalendar(HolidaySO so) {
		return (HolidayVO) selectOne("capa.getHolidayCalendar", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: HolidayDao.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateHoliday(HolidayPO po) {
		return update("capa.updateHoliday", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: HolidayDao.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertHoliday(HolidayPO po) {
		return insert("capa.insertHoliday", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: HolidayDao.java
	 * - 작성일		: 2016. 5. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일관리 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteHoliday(HolidayPO po) {
		return update("capa.deleteHoliday", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CapaDao.java
	* - 작성일		: 2016. 7. 14.
	* - 작성자		: snw
	* - 설명		: 현재 캐파 현황 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertDeliverDateStatus(DeliverDateStatusPO po){
		return insert("capa.insertDeliverDateStatus", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CapaDao.java
	* - 작성일		: 2016. 7. 13.
	* - 작성자		: snw
	* - 설명		: 현재 캐파 현황 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateDeliverDateStatus(DeliverDateStatusPO po){
		return update("capa.updateDeliverDateStatus", po);
	}
}