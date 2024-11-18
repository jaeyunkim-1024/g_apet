package biz.app.goods.service;

import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;

import java.util.List;

public interface GoodsFiltGrpService {

	int insertFiltGrp(GoodsFiltGrpPO po);
	int updateFiltGrp(GoodsFiltGrpPO po);
	int deleteFiltGrp(GoodsFiltGrpPO po);
	List<GoodsFiltGrpVO> getFiltGrpList(GoodsFiltGrpSO so);
	GoodsFiltGrpVO getFiltGrpInfo(GoodsFiltGrpSO so);
	GoodsFiltGrpVO createAutoSearchKeyWord(GoodsFiltGrpSO so);
	List<GoodsFiltGrpVO> listFilt(GoodsFiltGrpSO so);
}
