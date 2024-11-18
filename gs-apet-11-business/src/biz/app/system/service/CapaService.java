package biz.app.system.service;

import java.util.List;

import biz.app.system.model.DeliverDateSetPO;
import biz.app.system.model.DeliverDateSetSO;
import biz.app.system.model.DeliverDateSetVO;
import biz.app.system.model.DeliverDateStatusPO;
import biz.app.system.model.HolidayPO;
import biz.app.system.model.HolidaySO;
import biz.app.system.model.HolidayVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.system.service
 * - 파일명		: CapaMgmtService.java
 * - 작성일		: 2016. 5. 18.
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
public interface CapaService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CapaService.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일 관리 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<HolidayVO> listHolidayCalendar(HolidaySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CapaService.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 휴일 관리 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public HolidayVO getHolidayCalendar(HolidaySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CapaService.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파 관리 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DeliverDateSetVO> listCalendarDeliverDateSet(DeliverDateSetSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CapaService.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파 관리 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public DeliverDateSetVO getCalendarDeliverDateSet(DeliverDateSetSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CapaService.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파 일괄 저장
	 * </pre>
	 * @param po
	 */
	public void saveDeliverDateSetSetting(DeliverDateSetPO po);

	public void saveDeliverDateSetHoliday(DeliverDateSetPO deliverDateSetPO, HolidayPO holidayPO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CapaService.java
	* - 작성일		: 2016. 7. 13.
	* - 작성자		: snw
	* - 설명		: 현재 캐파 옹량 수정
	* </pre>
	* @param po
	*/
	public void updateDeliverDateStatus(DeliverDateStatusPO po); 
}