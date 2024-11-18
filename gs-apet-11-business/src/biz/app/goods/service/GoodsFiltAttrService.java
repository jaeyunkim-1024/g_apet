package biz.app.goods.service;

import biz.app.goods.model.GoodsFiltAttrPO;
import biz.app.goods.model.GoodsFiltAttrSO;
import biz.app.goods.model.GoodsFiltAttrVO;

import java.util.List;

public interface GoodsFiltAttrService {

	int insertFiltAttr(GoodsFiltAttrPO po);
	int updateFiltAttr(GoodsFiltAttrPO po);
	int deleteFiltAttr(GoodsFiltAttrPO po);
	List<GoodsFiltAttrVO> getFiltAttrList(GoodsFiltAttrSO so);
	GoodsFiltAttrVO getFiltAttrInfo(GoodsFiltAttrSO so);
}
