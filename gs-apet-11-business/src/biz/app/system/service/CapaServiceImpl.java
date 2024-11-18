package biz.app.system.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.CapaDao;
import biz.app.system.model.DeliverDateSetPO;
import biz.app.system.model.DeliverDateSetSO;
import biz.app.system.model.DeliverDateSetVO;
import biz.app.system.model.DeliverDateStatusPO;
import biz.app.system.model.HolidayPO;
import biz.app.system.model.HolidaySO;
import biz.app.system.model.HolidayVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * Capa ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Slf4j
@Service
@Transactional
public class CapaServiceImpl implements CapaService {

	@Autowired
	private CapaDao capaDao;

	@Override
	public List<HolidayVO> listHolidayCalendar(HolidaySO so) {
		return capaDao.listHolidayCalendar(so);
	}

	@Override
	public HolidayVO getHolidayCalendar(HolidaySO so) {
		return capaDao.getHolidayCalendar(so);
	}

	@Override
	public List<DeliverDateSetVO> listCalendarDeliverDateSet(DeliverDateSetSO so) {
		if(StringUtil.isNotBlank(so.getStrtDate()) && StringUtil.isNotBlank(so.getEndDate())){
			List<DeliverDateSetVO> list = new ArrayList<>();

			int plusDay = DateUtil.intervalDay(so.getStrtDate(), so.getEndDate()) + 1;
			for(int i=0; plusDay > i; i++) {
				so.setDeliverDate(DateUtil.addDay(so.getStrtDate(), "yyyy-MM-dd", i));
				list.addAll(capaDao.listCalendarDeliverDateSet(so));
			}
			return list;
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public DeliverDateSetVO getCalendarDeliverDateSet(DeliverDateSetSO so) {
		return capaDao.getCalendarDeliverDateSet(so);
	}

	@Override
	public void saveDeliverDateSetSetting(DeliverDateSetPO po) {
		try {
			int result = 0;
			DeliverDateSetSO so = new DeliverDateSetSO();

			// 기간 설정
			if(AdminConstants.DELIVER_GUBUN_10.equals(po.getDeliverGubunCd())) {
				if(StringUtil.isNotBlank(po.getStrtDeliverDate()) && StringUtil.isNotBlank(po.getEndDeliverDate())) {
					int plusDay = DateUtil.intervalDay(po.getStrtDeliverDate(), po.getEndDeliverDate()) + 1;

					for(int i=0; plusDay > i; i++) {
						po.setDeliverDate(DateUtil.addDay(po.getStrtDeliverDate(), "yyyy-MM-dd", i));
						if(!DateUtil.isDate(po.getDeliverDate().replaceAll("-", ""))) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}

						BeanUtils.copyProperties( so, po );
						so.setDsId(null);
						DeliverDateSetVO vo = capaDao.getDeliverDateSet(so);

						if(vo != null) {
							po.setDsId(vo.getDsId());
							result = capaDao.updateDeliverDateSet(po);
						} else {
							result = capaDao.insertDeliverDateSet(po);
						}

						if(result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
				} else {
					BeanUtils.copyProperties( so, po );
					so.setDsId(null);
					DeliverDateSetVO vo = capaDao.getDeliverDateSet(so);

					if(!DateUtil.isDate(po.getDeliverDate().replaceAll("-", ""))) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

					if(vo != null) {
						po.setDsId(vo.getDsId());
						result = capaDao.updateDeliverDateSet(po);
					} else {
						result = capaDao.insertDeliverDateSet(po);
					}

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			// 기간 이후 설정
			} else if(AdminConstants.DELIVER_GUBUN_20.equals(po.getDeliverGubunCd())) {
				BeanUtils.copyProperties( so, po );
				so.setDsId(null);
				so.setDeliverDate(null);
				DeliverDateSetVO vo = capaDao.getDeliverDateSet(so);

				if(!DateUtil.isDate(po.getDeliverDate().replaceAll("-", ""))) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				if(vo != null) {
					po.setDsId(vo.getDsId());
					result = capaDao.updateDeliverDateSet(po);
				} else {
					result = capaDao.insertDeliverDateSet(po);
				}

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	@Override
	public void saveDeliverDateSetHoliday(DeliverDateSetPO deliverDateSetPO, HolidayPO holidayPO) {
		try {
			int result = 0;

			if(deliverDateSetPO.getDaysDeliveryLimit() != null && deliverDateSetPO.getDaysDeliveryCntLimit() != null && deliverDateSetPO.getDeliveryIncrease() != null)  {
				DeliverDateSetSO deliverDateSetSO = new DeliverDateSetSO();
				deliverDateSetPO.setDeliverGubunCd(AdminConstants.DELIVER_GUBUN_10);
				BeanUtils.copyProperties( deliverDateSetSO, deliverDateSetPO );
				deliverDateSetSO.setDsId(null);
				DeliverDateSetVO vo = capaDao.getDeliverDateSet(deliverDateSetSO);

				if(!DateUtil.isDate(deliverDateSetPO.getDeliverDate().replaceAll("-", ""))) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				if(vo != null) {
					deliverDateSetPO.setDsId(vo.getDsId());
					result = capaDao.updateDeliverDateSet(deliverDateSetPO);
				} else {
					result = capaDao.insertDeliverDateSet(deliverDateSetPO);
				}

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}

			if(StringUtil.isNotBlank(holidayPO.getHolidayDateYn()) && AdminConstants.COMM_YN_Y.equals(holidayPO.getHolidayDateYn())){
				HolidaySO holidaySO = new HolidaySO();
				holidaySO.setHolidayDate(holidayPO.getHolidayDate());
				HolidayVO holidayVO = capaDao.getHolidayCalendar(holidaySO);
				if(holidayVO != null) {
					result = capaDao.updateHoliday(holidayPO);
				} else {
					result = capaDao.insertHoliday(holidayPO);
				}

				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} else {
				capaDao.deleteHoliday(holidayPO);
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	/*
	 * 현재 캐파 옹량 수정
	 * @see biz.app.system.service.CapaService#updateDeliverDateStatus(biz.app.system.model.DeliverDateStatusPO)
	 */
	@Override
	public void updateDeliverDateStatus(DeliverDateStatusPO po) {
		int result = this.capaDao.updateDeliverDateStatus(po);
		
		if(result == 0){
			result = this.capaDao.insertDeliverDateStatus(po);
			
			if(result != 1){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}else if(result > 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
	}
	
	

}