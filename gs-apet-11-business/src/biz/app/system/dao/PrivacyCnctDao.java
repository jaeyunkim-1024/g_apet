package biz.app.system.dao;

import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.model.PrivacyCnctHistSO;
import biz.app.system.model.PrivacyCnctHistVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PrivacyCnctDao extends MainAbstractDao {
    private static final String BASE_DAO_PACKAGE = "privacyCnct.";

    public int insertPrivacyCnctHist(PrivacyCnctHistPO po){
        return insert(BASE_DAO_PACKAGE + "insertPrivacyCnctHist",po);
    }

    public int insertPrivacyCnctInquiry(PrivacyCnctHistPO po){
        return insert(BASE_DAO_PACKAGE + "insertPrivacyCnctInquiry",po);
    }

    public List<PrivacyCnctHistVO> pageLog(PrivacyCnctHistSO so){
        return selectListPage(BASE_DAO_PACKAGE + "pageLog",so);
    }

    public PrivacyCnctHistVO getDetailHistoryInfo(PrivacyCnctHistSO so){
        return selectOne(BASE_DAO_PACKAGE + "getDetailHistoryInfo",so);
    }

    public void updateExecSql(PrivacyCnctHistPO po){
        update(BASE_DAO_PACKAGE+"updateExecSql",po);
    }
}
