package biz.app.system.service;

import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.model.PrivacyCnctHistSO;
import biz.app.system.model.PrivacyCnctHistVO;

import java.util.List;

public interface PrivacyCnctService {

    public Long insertPrivacyCnctHist(PrivacyCnctHistPO po);

    public Long insertPrivacyCnctInquiry(PrivacyCnctHistPO po);

    public List<PrivacyCnctHistVO> pageLog(PrivacyCnctHistSO so);

    public PrivacyCnctHistVO getDetailHistoryInfo(PrivacyCnctHistSO so);

    public void updateExecSql(PrivacyCnctHistPO po);
}
