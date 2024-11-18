package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodGoodsPO;
import biz.app.contents.model.VodGoodsVO;
import biz.app.contents.model.VodPO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodTagPO;
import biz.app.contents.model.VodVO;
import biz.app.goods.model.GoodsBaseVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;


/**
 * <h3>Project : 11.business</h3>
 * <pre>영상 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class VodDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "vod.";

	/**
	 * <pre>영상 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public List<VodVO> pageVod(VodSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageVod", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: VodDao.java
	* - 작성일		: 2020. 12. 18.
	* - 작성자		: valueFactory
	* - 설명			: 영상 전시상태 일괄 수정
	* </pre>
	* @param VodPO
	* @return
	*/
	public int batchUpdateDisp(VodPO po) {
		return update(BASE_DAO_PACKAGE + "batchUpdateDisp", po );
	}

	/**
	 * <pre>영상 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public VodVO getVod(VodSO so) {
		return (VodVO) selectOne(BASE_DAO_PACKAGE + "getVod", so);
	}

	/**
	 * <pre>영상 상세 - 시리즈</pre>
	 * 
	 * @author valueFactory
	 * @param
	 * @return 
	 */
	public List<SeriesVO> getSeriesAll() {
		return selectList(BASE_DAO_PACKAGE + "getSeriesAll");
	}

	/**
	 * <pre>영상 상세 - 시즌</pre>
	 * 
	 * @author valueFactory
	 * @param Long srisNo
	 * @return 
	 */
	public List<SeriesVO> getSeasonBySrisNo(Long srisNo) {
		return selectList(BASE_DAO_PACKAGE + "getSeasonBySrisNo", srisNo);
	}

	/**
	 * <pre>영상 상세 - 연관 태그</pre>
	 * 
	 * @author valueFactory
	 * @param String vdId
	 * @return 
	 */
	public List<VodVO> getTagsByVdId(String vdId) {
		return selectList(BASE_DAO_PACKAGE + "getTagsByVdId", vdId);
	}

	/**
	 * <pre>영상 상세 - 연동 상품</pre>
	 * 
	 * @author valueFactory
	 * @param String vdId
	 * @return 
	 */
	public List<VodGoodsVO> getGoodsByVdId(String vdId) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsByVdId", vdId);
	}

	/**
	 * <pre>영상 기본 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po vodPo
	 * @return 
	 */
	public int updateVod(VodPO vodPo) {
		return update(BASE_DAO_PACKAGE + "updateVod", vodPo);
	}

	/**
	 * <pre>연관 태그 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param VodPO vodPo
	 * @return 
	 */
	public int deleteTagMap(VodPO vodPo) {
		return delete("vod.deleteTagMap", vodPo);
	}

	/**
	 * <pre>연관 태그 등록</pre>
	 * 
	 * @author valueFactory
	 * @param VodTagPO vodTagPo
	 * @return 
	 */
	public int insertTagsMap(VodTagPO vodTagPo) {
		return insert(BASE_DAO_PACKAGE + "insertTagsMap", vodTagPo);
	}

	/**
	 * <pre>연관 상품 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param VodPO vodPo
	 * @return 
	 */
	public int deleteGoodsMap(VodPO vodPo) {
		return delete("vod.deleteGoodsMap", vodPo);
	}

	/**
	 * <pre>연동 상품 등록</pre>
	 * 
	 * @author valueFactory
	 * @param VodGoodsPO vodGoodsPo
	 * @return 
	 */
	public int insertGoodsMap(VodGoodsPO vodGoodsPo) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsMap", vodGoodsPo);
	}

	/**
	 * <pre>영상 상세 - 관련 파일들</pre>
	 * 
	 * @author valueFactory
	 * @param Long flNo
	 * @return 
	 */
	public List<ApetAttachFileVO> getAttachFiles(Long flNo) {
		return selectList(BASE_DAO_PACKAGE + "getAttachFiles", flNo);
	}

	/**
	 * <pre>연동 상품</pre>
	 * 
	 * @author valueFactory
	 * @param VodSO so
	 * @return 
	 */
	public List<VodGoodsVO> listVodGoods(VodSO so) {
		return selectList(BASE_DAO_PACKAGE + "listVodGoods", so);
	}

	/**
	 * <pre>영상 기본 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po vodPo
	 * @return 
	 */
	public int insertVod(VodPO vodPo) {
		return insert(BASE_DAO_PACKAGE + "insertVod", vodPo);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: VodDao.java
	* - 작성일		: 2020. 12. 29.
	* - 작성자		: valueFactory
	* - 설명			: 첨부파일등록
	* </pre>
	* @param ApetAttachFilePO
	* @return
	*/
	public int insertApetAttachFile (ApetAttachFilePO po ) {
		po.setPhyPath(StringUtil.removeProtocol(po.getPhyPath()));
		return update(BASE_DAO_PACKAGE + "insertApetAttachFile", po );
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodDao.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 영상리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> foSesnVodList(VodSO so) {
		return selectList(BASE_DAO_PACKAGE + "foSesnVodList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodDao.java
	 * - 작성일        : 2021. 2. 15.
	 * - 작성자        : YKU
	 * - 설명          : 랜덤 시리즈
	 * </pre>
	 * @param so
	 * @return
	 */
	public VodVO srisRandom(VodSO so) {
		return selectOne(BASE_DAO_PACKAGE + "srisRandom", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : VodDao.java
	 * - 작성일        : 2021. 2. 15.
	 * - 작성자        : YKU
	 * - 설명          : 시리즈 관련 영상리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> srisRandomList(VodSO so) {
		return selectList(BASE_DAO_PACKAGE + "srisRandomList", so);
	}

	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: VodDao.java
	* - 작성일		: 2020. 12. 29.
	* - 작성자		: valueFactory
	* - 설명			: 첨부파일삭제
	* </pre>
	* @param ApetAttachFilePO
	* @return
	*/
	public int deleteApetAttachFile(ApetAttachFilePO flPo) {
		return delete(BASE_DAO_PACKAGE + "deleteApetAttachFile", flPo);
	}

	public int insertVodHist(VodVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertVodHist", vo);
	}

	public int insertApetAttachFileHist(ApetAttachFileVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetAttachFileHist", vo);
	}

	public int insertTagsMapHist(VodVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertTagsMapHist", vo);
	}

	public int insertGoodsMapHist(VodGoodsVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsMapHist", vo);
	}

	public List<VodVO> listGetTag(VodSO so) {
		return selectList(BASE_DAO_PACKAGE + "listGetTag", so);
	}

	public List<VodVO> excelDownVodList(VodSO so) {
		return selectList(BASE_DAO_PACKAGE + "pageVod", so);
	}
}
