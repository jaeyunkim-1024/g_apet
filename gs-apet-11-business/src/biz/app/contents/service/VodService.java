package biz.app.contents.service;

import java.util.List;

import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodGoodsVO;
import biz.app.contents.model.VodPO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.goods.model.GoodsBaseVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: VodService.java
 * - 작성자		: valueFactory
 * - 설명		: 컨텐츠 Service
 * </pre>
 */
public interface VodService {

	/**
	 * <pre>영상 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public List<VodVO> pageVod(VodSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: VodService.java
	* - 작성일		: 2020. 12. 18.
	* - 작성자		: valueFactory
	* - 설명			: 영상 전시상태 일괄 수정
	* </pre>
	* @param vodPO
	* @return
	*/
	public int batchUpdateDisp(List<VodPO> vodPOList);

	/**
	 * <pre>영상 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public VodVO getVod(VodSO so);

	/**
	 * <pre>영상 상세 - 시리즈</pre>
	 * 
	 * @author valueFactory
	 * @param
	 * @return 
	 */
	public List<SeriesVO> getSeriesAll();

	/**
	 * <pre>영상 상세 - 시즌</pre>
	 * 
	 * @author valueFactory
	 * @param Long srisNo
	 * @return 
	 */
	public List<SeriesVO> getSeasonBySrisNo(Long srisNo);

	/**
	 * <pre>영상 상세 - 연관 태그</pre>
	 * 
	 * @author valueFactory
	 * @param String vdId
	 * @return 
	 */
	public List<VodVO> getTagsByVdId(String vdId);

	/**
	 * <pre>영상 상세 - 연동 상품</pre>
	 * 
	 * @author valueFactory
	 * @param String vdId
	 * @return 
	 */
	public List<VodGoodsVO> getGoodsByVdId(String vdId);

	/**
	 * <pre>영상 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po vodPO
	 * @return 
	 */
	public void updateVod(VodPO vodPo);

	/**
	 * <pre>연동 상품</pre>
	 * 
	 * @author valueFactory
	 * @param so vodSO
	 * @return 
	 */
	public List<VodGoodsVO> listVodGoods(VodSO so);

	/**
	 * <pre>영상 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po vodPO
	 * @return 
	 */
	public void insertVod(VodPO vodPo);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodService.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 영상목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> foSesnVodList(VodSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodService.java
	 * - 작성일        : 2021. 2. 4.
	 * - 작성자        : YKU
	 * - 설명          : 랜덤으로 시리즈 하나 가져오기
	 * </pre>
	 * @param so
	 * @return
	 */
	public VodVO srisRandom(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodService.java
	 * - 작성일        : 2021. 2. 4.
	 * - 작성자        : YKU
	 * - 설명          : 시리즈 리스트 가져오기
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> srisRandomList(VodSO so);
	
	public List<VodVO> listGetTag(VodSO so);

	/**
	 * 영상 엑셀다운로드
	 * @param so
	 * @return
	 */
	public List<VodVO> excelDownVodList(VodSO so);
}