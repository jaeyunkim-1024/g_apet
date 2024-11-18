package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.DirectDeliverAreaDao;
import biz.app.system.model.DeliverAreaSetPO;
import biz.app.system.model.DeliverAreaSetSO;
import biz.app.system.model.DeliverAreaSetVO;
import biz.app.system.model.ZipcodeMappingPO;
import biz.app.system.model.ZipcodeMappingSO;
import biz.app.system.model.ZipcodeMappingVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Service
@Transactional
public class DirectDeliverAreaServiceImpl implements DirectDeliverAreaService {

	@Autowired
	private DirectDeliverAreaDao directDeliverAreaDao;

	@Override
	public List<DeliverAreaSetVO> listDirectDeliverArea(DeliverAreaSetSO so) {
		return directDeliverAreaDao.listDirectDeliverArea(so);
	}

	@Override
	public void deleteDirectDeliverArea(DeliverAreaSetPO po) {
		int result = 0;
		List<DeliverAreaSetPO> directDeliverAreaPOList = po.getDirectDeliverAreaPOList();

		if(directDeliverAreaPOList != null && !directDeliverAreaPOList.isEmpty()) {
			for(DeliverAreaSetPO item : directDeliverAreaPOList) {
				result = directDeliverAreaDao.deleteDirectDeliverArea(item);
			}
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<DeliverAreaSetVO> listWareHouse(DeliverAreaSetSO so) {
		return directDeliverAreaDao.listWareHouse(so);
	}

	@Override
	public void saveDirectDeliverArea(DeliverAreaSetPO po) {
		int result = 0;

		if(po.getAreaId() != null) {
			// 직배송지역 수정
			result = directDeliverAreaDao.updateDirectDeliverArea(po);
		} else {
			// 직배송지역 추가
			result = directDeliverAreaDao.insertDirectDeliverArea(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<ZipcodeMappingVO> iistZipCodeGrid(ZipcodeMappingSO so) {
		return directDeliverAreaDao.iistZipCodeGrid(so);
	}

	@Override
	public void saveDeliverAreaZipCode(ZipcodeMappingPO po) {
		int result = 0;
		List<ZipcodeMappingPO> zipCodePOList = po.getZipCodePOList();

		if(zipCodePOList != null && !zipCodePOList.isEmpty()) {
			for(ZipcodeMappingPO item : zipCodePOList) {
				directDeliverAreaDao.saveDeliverAreaZipCode(item);

				result++;
			}
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void insertDeliverAreaZipCode(ZipcodeMappingPO po) {
		// 신우편번호 존재 여부 확인
		ZipcodeMappingSO so = new ZipcodeMappingSO();
		so.setZipcode(po.getZipcode());
		ZipcodeMappingVO vo = directDeliverAreaDao.getAreaZipCode(so);

		if(vo == null) {
			// 신우편번호 추가
			int result = directDeliverAreaDao.insertDeliverAreaZipCode(po);

			if(result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_DISPLAY_CATEGORY_LOWER_IN_USE);
		}
	}
}