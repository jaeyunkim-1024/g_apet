package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.ApetContentsDetailPO;
import biz.app.contents.model.ApetContentsDetailSO;
import biz.app.contents.model.ApetContentsDetailVO;
import biz.app.contents.model.EduContsPO;
import biz.app.contents.model.EduContsSO;
import biz.app.contents.model.EduContsVO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodGoodsPO;
import biz.app.contents.model.VodPO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodTagPO;
import biz.app.contents.model.VodVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.system.model.CodeDetailVO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>교육 영상 DAO</pre>
 * 
 * @author KKB
 */
@Repository
public class EduContsDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "eduConts.";

	/**
	 * <pre>교육용 카테고리 목록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<EduContsVO>
	 */
	public List<EduContsVO> getEduCtgList(EduContsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getEduCategoryList", so);
	}

	/**
	 * <pre>교육 영상 목록 조회</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<EduContsVO>
	 */
	public List<EduContsVO> pageEduConts(EduContsSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageEduConts", so);
	}
	
	/**
	 * <pre>교육 영상 상세 조회</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return EduContsVO
	 */
	public EduContsVO getEduConts(EduContsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getEduConts", so);
	}
	
	/**
	 * <pre>교육 시청 이력 조회</pre>
	 * 
	 * @author KWJ
	 * @param  ApetContentsDetailSO
	 * @return ApetContentsDetailVO
	 */
	public ApetContentsDetailVO getApetContentsWatchHist(ApetContentsDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getApetContentsWatchHist", so);
	}
	
	/**
	 * <pre>펫스쿨 영상 찜보관 여부</pre>
	 * 
	 * @author KWJ
	 * @param  ApetContentsDetailSO
	 * @return String
	 */
	public VodVO getInterestYn(EduContsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getInterestYn", so);
	}
	
	/**
	 * <pre>마이펫 등록 여부</pre>
	 * 
	 * @author KWJ
	 * @param  ApetContentsDetailSO
	 * @return String
	 */
	public String getMyPetYn(EduContsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMyPetYn", so);
	}
	
	/**
	 * <pre>다음 교육 리스트</pre>
	 * 
	 * @author KWJ
	 * @param  EduContsSO
	 * @return List<ApetContentsDetailVO>
	 */
	public List<VodVO> getApetContentsList(EduContsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getApetContentsList", so);
	}
	
	/**
	 * <pre>펫스쿨 찜보관 저장</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsDetailPO
	 * @return int
	 */
	public int saveContsInterest(ApetContentsDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "saveContsInterest", po);
	}
	
	/**
	 * <pre>펫스쿨 찜보관 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsDetailPO
	 * @return int
	 */
	public int deleteContsInterest(ApetContentsDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "deleteContsInterest", po);
	}
	
	/**
	 * <pre>펫스쿨 따라잡기 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param PetLogMgmtSO
	 * @return List<PetLogBaseVO>
	 */
	public List<PetLogBaseVO> listPetSchoolCatch(PetLogMgmtSO so) {
		return selectList("petLogMgmt.listPetSchoolCatch", so);
	}
	
	/**
	 * <pre>펫스쿨 조회수 저장</pre>
	 * 
	 * @author valueFactory
	 * @param EduContsPO
	 * @return int
	 */
	public int saveContsHit(EduContsPO po) {
		return update(BASE_DAO_PACKAGE + "saveContsHit", po);
	}
	
	/**
	 * <pre>펫스쿨 단축url 저장</pre>
	 * 
	 * @author valueFactory
	 * @param EduContsPO
	 * @return int
	 */
	public int saveSrtUrl(EduContsPO po) {
		return update(BASE_DAO_PACKAGE + "saveSrtUrl", po);
	}
}
