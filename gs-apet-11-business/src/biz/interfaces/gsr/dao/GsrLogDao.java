package biz.interfaces.gsr.dao;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.interfaces.gsr.model.*;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.interface.gsr.dao
 * - 파일명		: GsrLogDao.java
 * - 작성일		: 2021. 03. 12.
 * - 작성자		: 김재윤
 * - 설명			: GS 연동 포인트
 * </pre>
 */
@Repository
public class GsrLogDao extends MainAbstractDao {
    private static final String BASE_DAO_PACKAGE = "gsrLog.";

    public List<GsrLnkHistVO> listGsrLnkHist(GsrLnkHistSO so){
        return selectListPage(BASE_DAO_PACKAGE + "listGsrLnkHist",so);
    }

    public GsrLnkHistVO getGsrLnkHistDetail(GsrLnkHistSO so){
        return selectOne(BASE_DAO_PACKAGE + "getGsrLnkHistDetail",so);
    }

    public List<GsrLnkHistVO> gsrLinkedHistoryGrid(GsrLnkHistSO so){
    	return selectListPage(BASE_DAO_PACKAGE + "gsrLinkedHistoryGrid" , so);
    }

    public void insertGsrLnkHist(GsrLnkHistPO po){
        insert_batch(BASE_DAO_PACKAGE + "insertGsrLnkHist",po);
    }

    public void insertGsrLnkMap(GsrLnkMapPO po){ insert_batch(BASE_DAO_PACKAGE + "insertGsrLnkMap",po); }

    public GsrLnkMapVO getGsrLnkMap(GsrLnkMapSO so){return selectOne(BASE_DAO_PACKAGE + "getGsrLnkMap",so);}

    public Integer getRcptNoCnt(GsrLnkMapSO so){return selectOne(BASE_DAO_PACKAGE + "getRcptNoCnt",so);}

    public List<MemberBaseVO> listCheckMember(){
        return selectList(BASE_DAO_PACKAGE + "listCheckMember");
    }

    public void updateMemberGsrState(MemberBasePO po){
        update(BASE_DAO_PACKAGE + "updateGsptState",po);
        insert(BASE_DAO_PACKAGE + "insertMemberBaseHistroyByGsptNo",po);
    }

    public List<CodeDetailVO> listCodeDetailVO(CodeDetailSO so){
        return selectList(BASE_DAO_PACKAGE + "getCodeDetailVO",so);
    }

    public CodeDetailVO getCodeDetailVO(CodeDetailSO so){
        return selectOne(BASE_DAO_PACKAGE + "getCodeDetailVO",so);
    }

    public List<GsrMemberPointPO> getGsrPointAccumeForPetLogReview() {
        return selectList(BASE_DAO_PACKAGE+"getGsrPointAccumeForPetLogReview");
    }

    public List<MemberBasePO> findMemberBaseByMobile(MemberBaseSO so){
        return selectList(BASE_DAO_PACKAGE + "findMemberBaseByMobile",so);
    }
}
