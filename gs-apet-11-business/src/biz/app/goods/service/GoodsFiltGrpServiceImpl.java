package biz.app.goods.service;

import biz.app.goods.dao.GoodsFiltGrpDao;
import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service("goodsFiltGrpService")
public class GoodsFiltGrpServiceImpl implements GoodsFiltGrpService{

	@Autowired
	private GoodsFiltGrpDao goodsFiltGrpDao;

	@Override
	public int insertFiltGrp(GoodsFiltGrpPO po) {
		return goodsFiltGrpDao.insertFiltGrp(po);
	}

	@Override
	public int updateFiltGrp(GoodsFiltGrpPO po) {
		return goodsFiltGrpDao.updateFiltGrp(po);
	}

	@Override
	public int deleteFiltGrp(GoodsFiltGrpPO po) {
		return goodsFiltGrpDao.deleteFiltGrp(po);
	}

	@Override
	public List<GoodsFiltGrpVO> getFiltGrpList(GoodsFiltGrpSO so) {
		return goodsFiltGrpDao.getFiltGrpList(so);
	}

	@Override
	public GoodsFiltGrpVO getFiltGrpInfo(GoodsFiltGrpSO so) {
		return goodsFiltGrpDao.getFiltGrpInfo(so);
	}

	@Override
	public GoodsFiltGrpVO createAutoSearchKeyWord(GoodsFiltGrpSO so) {
		GoodsFiltGrpVO vo = new GoodsFiltGrpVO();
		List<String> filtGrpMngNms = new ArrayList<String>();
		List<String> filtGrpShowNms = new ArrayList<String>();

		List<GoodsFiltGrpVO> list = goodsFiltGrpDao.getFiltGrpList(so);
		for (GoodsFiltGrpVO goodsFiltGrpVo : list) {
			filtGrpMngNms.add(goodsFiltGrpVo.getFiltGrpMngNm());
			filtGrpShowNms.add(goodsFiltGrpVo.getFiltGrpShowNm());
		}
		vo.setFiltGrpMngNms(filtGrpMngNms.stream().distinct().collect(Collectors.toList()));
		vo.setFiltGrpShowNms(filtGrpShowNms.stream().distinct().collect(Collectors.toList()));
		return vo;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsFiltGrpServiceImpl.java
	* - 작성일	: 2020. 12. 30.
	* - 작성자 	: valfac
	* - 설명 		: 필터 리스트
	* </pre>
	*
	* @param so
	* @return
	*/
	@Override
	public List<GoodsFiltGrpVO> listFilt(GoodsFiltGrpSO so) {
		return goodsFiltGrpDao.listFilt(so);
	}

}
