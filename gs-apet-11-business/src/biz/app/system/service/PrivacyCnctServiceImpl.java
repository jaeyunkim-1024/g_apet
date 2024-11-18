package biz.app.system.service;

import biz.app.system.dao.MenuDao;
import biz.app.system.dao.PrivacyCnctDao;
import biz.app.system.model.*;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.MaskingUtil;
import framework.common.util.RequestUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
public class PrivacyCnctServiceImpl implements PrivacyCnctService{

    @Autowired
    private PrivacyCnctDao privacyCnctDao;

    @Autowired
    private MenuDao menuDao;

    @Autowired
    private BizService bizService;

    @Autowired
    private CacheService cacheService;

    @Override
    public Long insertPrivacyCnctHist(PrivacyCnctHistPO po) {
        po.setUsrNo(AdminSessionUtil.getSession().getUsrNo());

        Long menuNo = Optional.ofNullable(po.getMenuNo()).orElseGet(()->0L);
        Long actNo = Optional.ofNullable(po.getActNo()).orElseGet(()->0L);

        if(Long.compare(menuNo,0L) == 0 || Long.compare(actNo,0L) == 0){
            MenuActionSO so = new MenuActionSO();
            so.setUrl(Optional.ofNullable(po.getUrl()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT)));
            so.setActGbCd(Optional.ofNullable(po.getActGbCd()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT)));

            MenuActionVO menu = menuDao.listMenuActionByUrlAndActGbCd(so);
            po.setMenuNo(menu.getMenuNo());
            po.setActNo(menu.getActNo());
        }
        po.setIp(RequestUtil.getClientIp());

        Long cnctHistNo = 0L;
        if(privacyCnctDao.insertPrivacyCnctHist(po) == 0){
            throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
        }

        cnctHistNo = po.getCnctHistNo();
        return cnctHistNo;
    }

    @Override
    public Long insertPrivacyCnctInquiry(PrivacyCnctHistPO po) {
        if(privacyCnctDao.insertPrivacyCnctInquiry(po) == 0){
            throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
        }
        return po.getInqrHistNo();
    }

    @Override
    public List<PrivacyCnctHistVO> pageLog(PrivacyCnctHistSO so) {
        so.setSidx("T.ACS_DTM");
        so.setSord("DESC");
        List<PrivacyCnctHistVO> list = Optional.ofNullable(privacyCnctDao.pageLog(so)).orElseGet(
                ()->new ArrayList<PrivacyCnctHistVO>());
        return list;
    }

    @Override
    public PrivacyCnctHistVO getDetailHistoryInfo(PrivacyCnctHistSO so) {
        PrivacyCnctHistVO vo = Optional.ofNullable(privacyCnctDao.getDetailHistoryInfo(so)).orElseGet(
                ()->new PrivacyCnctHistVO());

        //마스킹 처리  , TO-DO :: 정보처리 주체 컬럼 값
        String loginId = bizService.twoWayDecrypt(vo.getLoginId());

        vo.setUsrNm(MaskingUtil.getName(vo.getUsrNm()));
        vo.setMbrNm(MaskingUtil.getName(vo.getMbrNm()));
        vo.setAdminLoginId(MaskingUtil.getId(vo.getAdminLoginId()));
        vo.setLoginId(MaskingUtil.getId(loginId));

        return vo;
    }

    @Override
    public void updateExecSql(PrivacyCnctHistPO po) {
        privacyCnctDao.updateExecSql(po);
    }
}
