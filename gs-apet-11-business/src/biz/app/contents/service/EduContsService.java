package biz.app.contents.service;

import java.util.List;

import biz.app.contents.model.ApetContentsDetailPO;
import biz.app.contents.model.ApetContentsDetailSO;
import biz.app.contents.model.ApetContentsDetailVO;
import biz.app.contents.model.EduContsPO;
import biz.app.contents.model.EduContsSO;
import biz.app.contents.model.EduContsVO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.VodVO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.system.model.CodeDetailVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.contents.service
 * - 파일명		: EduContsService.java
 * - 작성자		: KKB
 * - 설명		: 교육용 컨텐츠 Service
 * </pre>
 */
public interface EduContsService {

	/**
	 * <pre>교육용 카테고리 목록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<CodeDetailVO>
	 */
	public List<CodeDetailVO> getEduCtgList(EduContsSO so);
	
	/**
	 * <pre>교육용 영상 목록 조회</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<EduContsVO>
	 */
	public List<EduContsVO> pageEduConts(EduContsSO so);
	
	/**
	 * <pre>교육용 컨텐츠 등록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsPO
	 * @return String result
	 */
	public String insertEduContents(EduContsPO po);
	
	/**
	 * <pre>교육용 영상 상세 조회</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return EduContsVO
	 */
	public EduContsVO getEduConts(EduContsSO so);
	
	/**
	 * <pre>교육용 컨텐츠 수정</pre>
	 * 
	 * @author KKB
	 * @param  EduContsPO
	 * @return String result
	 */
	public String updateEduContents(EduContsPO po);
	
	/**
	 * <pre>펫스쿨 영상 시청 이력 조회 </pre>
	 * 
	 * @author KWJ
	 * @param so
	 * @return
	 */
	public ApetContentsDetailVO getPetTvContsHistory(ApetContentsDetailSO so);
	
	/**
	 * <pre>펫스쿨 영상 찜보관 여부</pre>
	 * 
	 * @author KWJ
	 * @param so
	 * @return
	 */
	public VodVO getInterestYn(EduContsSO so);
	
	/**
	 * <pre>마이펫 등록 여부</pre>
	 * 
	 * @author KWJ
	 * @param so
	 * @return
	 */
	public String getMyPetYn(EduContsSO so);
	
	/**
	 * <pre>다음 교육 리스트</pre>
	 * 
	 * @author KWJ
	 * @param so
	 * @return
	 */
	public List<VodVO> getApetContentsList(EduContsSO so);
	
	/**
	 * <pre>펫스쿨 찜보관 저장</pre>
	 * 
	 * @author KWJ
	 * @param po
	 * @return
	 */
	public int saveContsInterest(ApetContentsDetailPO po, String deleteYn);
	
	/**
	 * <pre>펫스쿨 따라잡기 리스트</pre>
	 * 
	 * @author KWJ
	 * @param so
	 * @return
	 */
	public List<PetLogBaseVO> listPetSchoolCatch(PetLogMgmtSO so);
	
	/**
	 * <pre>펫스쿨 조회수 저장</pre>
	 * 
	 * @author KWJ
	 * @param po
	 * @return
	 */
	public int saveContsHit(EduContsPO po);
	
	/**
	 * <pre>펫스쿨 단축url 저장</pre>
	 * 
	 * @author KWJ
	 * @param po
	 * @return
	 */
	public int saveSrtUrl(EduContsPO po);
}