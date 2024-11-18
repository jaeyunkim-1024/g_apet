package biz.app.goods.service;

import biz.app.goods.dao.GoodsFiltAttrDao;
import biz.app.goods.model.GoodsFiltAttrPO;
import biz.app.goods.model.GoodsFiltAttrSO;
import biz.app.goods.model.GoodsFiltAttrVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("goodsFiltAttrService")
public class GoodsFiltAttrServiceImpl implements GoodsFiltAttrService{

	@Autowired
	private GoodsFiltAttrDao goodsFiltAttrDao;

	@Override
	public int insertFiltAttr(GoodsFiltAttrPO po) {
		return goodsFiltAttrDao.insertFiltAttr(po);
	}

	@Override
	public int updateFiltAttr(GoodsFiltAttrPO po) {
		return goodsFiltAttrDao.updateFiltAttr(po);
	}

	@Override
	public int deleteFiltAttr(GoodsFiltAttrPO po) {
		return goodsFiltAttrDao.deleteFiltAttr(po);
	}

	@Override
	public List<GoodsFiltAttrVO> getFiltAttrList(GoodsFiltAttrSO so) {
		return goodsFiltAttrDao.getFiltAttrList(so);
	}

	@Override
	public GoodsFiltAttrVO getFiltAttrInfo(GoodsFiltAttrSO so) {
		return goodsFiltAttrDao.getFiltAttrInfo(so);
	}
}
