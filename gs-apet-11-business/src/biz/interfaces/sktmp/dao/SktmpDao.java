package biz.interfaces.sktmp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.interfaces.sktmp.model.SktmpCardInfoPO;
import biz.interfaces.sktmp.model.SktmpCardInfoSO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.dao
 * - 파일명		: SktmpDao.java
 * - 작성일		: 2021. 07. 22.
 * - 작성자		: JinHong
 * - 설명		: SKT MP 연동 DAO
 * </pre>
 */
@Repository
public class SktmpDao extends MainAbstractDao {
    private static final String BASE_DAO_PACKAGE = "sktmp.";

    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 23.
     * - 작성자		: JinHong
     * - 설명		: SKTMP 연동 이력 페이징 조회
     * </pre>
     * @param so
     * @return
     */
    public List<SktmpLnkHistVO> pageSktmpLnkHist(SktmpLnkHistSO so){
        return selectListPage(BASE_DAO_PACKAGE + "pageSktmpLnkHist",so);
    }

    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 23.
     * - 작성자		: JinHong
     * - 설명		: SKTMP 연동 이력 단건 조회
     * </pre>
     * @param so
     * @return
     */
    public SktmpLnkHistVO getSktmpLnkHist(SktmpLnkHistSO so){
        return selectOne(BASE_DAO_PACKAGE + "getSktmpLnkHist",so);
    }

    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 08. 31.
     * - 작성자		: JinHong
     * - 설명		: SKTMP 연동 이력 리스트 조회
     * </pre>
     * @param so
     * @return
     */
    public List<SktmpLnkHistVO> listSktmpLnkHist(SktmpLnkHistSO so){
        return selectList(BASE_DAO_PACKAGE + "listSktmpLnkHist",so);
    }
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 23.
     * - 작성자		: JinHong
     * - 설명		: SKTMP 연동 이력 등록
     * </pre>
     * @param po
     * @return
     */
    public int insertSktmpLnkHist(SktmpLnkHistVO vo){
    	return insert(BASE_DAO_PACKAGE + "insertSktmpLnkHist" , vo);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 27.
     * - 작성자		: JinHong
     * - 설명		: SKT MP 연동 후 업데이트
     * </pre>
     * @param vo
     * @return
     */
    public int updateResSktmpLnkHist(SktmpLnkHistVO vo){
    	return update(BASE_DAO_PACKAGE + "updateResSktmpLnkHist" , vo);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 30.
     * - 작성자		: JinHong
     * - 설명		: SKT MP HIST 업데이트
     * </pre>
     * @param vo
     * @return
     */
    public int updateSktmpLnkHist(SktmpLnkHistVO vo){
    	return update(BASE_DAO_PACKAGE + "updateSktmpLnkHist" , vo);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 07. 23.
     * - 작성자		: JinHong
     * - 설명		: SKTMP 연동 이력 총합계
     * </pre>
     * @param so
     * @return
     */
    public SktmpLnkHistVO getSktmpPntHistTotal(SktmpLnkHistSO so){
        return selectOne(BASE_DAO_PACKAGE + "getSktmpPntHistTotal",so);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 08. 09.
     * - 작성자		: hjh
     * - 설명		: SKTMP 카드 정보 등록
     * </pre>
     * @param so
     * @return
     */
    public int insertSktmpCardInfo(SktmpCardInfoPO po){
        return insert(BASE_DAO_PACKAGE + "insertSktmpCardInfo", po);
    }
    
    /**
     * <pre>
     * - 프로젝트명	: gs-apet-11-business
     * - 파일명		: biz.interfaces.sktmp.dao
     * - 작성일		: 2021. 08. 09.
     * - 작성자		: hjh
     * - 설명		: SKTMP 카드 정보 변경
     * </pre>
     * @param so
     * @return
     */
    public int updateSktmpCardInfo(SktmpCardInfoPO po){
        return update(BASE_DAO_PACKAGE + "updateSktmpCardInfo", po);
    }

	public SktmpCardInfoVO getSktmpCardInfo(SktmpCardInfoSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getSktmpCardInfo", so);
	}
    
}
