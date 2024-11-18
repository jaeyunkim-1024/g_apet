package biz.app.tag.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerVO;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.model.TagGroupPO;
import biz.app.tag.model.TagGroupSO;
import biz.app.tag.model.TagGroupTreeVO;
import biz.app.tag.model.TagGroupVO;
import biz.app.tag.model.TagTrendPO;
import biz.app.tag.model.TagTrendSO;
import biz.app.tag.model.TagTrendVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.dao
* - 파일명     : TagDao.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Repository
public class TagDao extends MainAbstractDao {

	public static final String BASE_DAO_PACKAGE = "tag.";

	
	public List<TagBaseVO> pageTagBase (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageTagBase", so );
	}
	
	public List<TagBaseVO> pageUnmatchedTagBase (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageUnmatchedTagBase", so );
	}
	
	public TagBaseVO getTagDetail(String tagNo) {
		return (TagBaseVO) selectOne(BASE_DAO_PACKAGE + "getTagDetail", tagNo);
	}
	
	
	public List<TagGroupTreeVO> listTagGroupTree() {
		return selectList(BASE_DAO_PACKAGE + "listTagGroupTree");
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public TagGroupVO getTagGroup(TagGroupSO so) {
		return (TagGroupVO) selectOne(BASE_DAO_PACKAGE + "getTagGroup", so);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagDao.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return int
	*/
	public int getCheckTagGroup(TagGroupSO so) {
		return (int) selectOne(BASE_DAO_PACKAGE + "getCheckTagGroup", so);
	}
	

	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagDao.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return int
	*/
	public int insertTagGroup(TagGroupPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagGroup", po);
	}

	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagDao.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return int
	*/
	public int updateTagGroup(TagGroupPO po) {
		return update(BASE_DAO_PACKAGE + "updateTagGroup", po);
	}

	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagDao.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return int
	*/
	public int deleteTagGroup(TagGroupPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagGroup", po);
	}

	
	public List<TagGroupVO> listTagGroup(TagGroupSO so) {
		return selectList(BASE_DAO_PACKAGE + "listTagGroup", so);
	}

	public List<TagGroupVO> listDisplayTagGroup(TagGroupSO so) {
		return selectList(BASE_DAO_PACKAGE + "listDisplayTagGroup", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
//	public CodeDetailVO getCodeDetail(CodeDetailSO so) {
//		return (CodeDetailVO) selectOne("code.getCodeDetail", so);
//	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTagBase(TagBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateTagBase(TagBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateTagBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteTagBase(TagBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagBase", po);
	}
	
	public List<TagGroupVO> listTagGroupMap(TagBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listTagGroupMap", so);
	}
	
	
	public int insertTagGroupMap(TagBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagGroupMap", po);
	}
	
	public int deleteTagGroupMap(TagBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagGroupMap", po);
	}	
	
	public List<TagBaseVO> listTagRelationMap (TagBaseSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listTagRelationMap", so );
	}	
	
	public int insertTagRelationMap(TagBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagRelationMap", po);
	}
	
	public int deleteTagRelationMap(TagBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagRelationMap", po);
	}
	
	public List<TagBaseVO> listTagSynonymMap (TagBaseSO so ) {
		return selectList(BASE_DAO_PACKAGE + "listTagSynonymMap", so );
	}	
	
	public int insertTagSynonymMap(TagBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagSynonymMap", po);
	}
	
	public int deleteTagSynonymMap(TagBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagSynonymMap", po);
	}
	
	public List<TagTrendVO> pageTagTrend (TagTrendSO so ) {
		return selectListPage ("tag.pageTagTrend", so );
	}
	
	public int insertTagTrend(TagTrendPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagTrend", po);
	}
	
	
	public int insertTagTrendMap(TagTrendPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTagTrendMap", po);
	}
	
	public int updateTagTrend(TagTrendPO po) {
		return update(BASE_DAO_PACKAGE + "updateTagTrend", po);
	}
	
	public int deleteTagTrend(TagTrendPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagTrend", po);
	}
	
	public int deleteTagTrendMap(TagTrendPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTagTrendMap", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PetLogDao.java
	 * - 작성일		: 2020. 12. 16.
	 * - 작성자		: valueFactory
	 * - 설명			: 펫로그 관련 태그 조회
	 * </pre>
	 * @author valueFactory
	 * @param so PetlogSO
	 * @return
	 */
	public List<TagBaseVO> listTagBase(TagBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listTagBase", so);
	}
		
	public List<TagBaseVO> pageTagGoodsList (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageTagGoodsList", so );
	}
	
	public List<TagBaseVO> pageTagContentsList (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageTagContentsList", so );
	}
	
	public int tagNmCheck(String tagNm) {
		return selectOne(BASE_DAO_PACKAGE + "tagNmCheck", tagNm);
	}
	
	public TagBaseVO getTagInfo(TagBaseSO so) {
		return (TagBaseVO) selectOne(BASE_DAO_PACKAGE + "getTagInfo", so);
	}
	public List<TagBaseVO> listTagGoodsId(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listTagGoodsId", goodsId);
	}
	
	/**
	 * <pre>
	 * - Method 명	: unmatchedGrid
	 * - 작성일		: 2020.04.07.
	 * - 작성자		: CJA
	 * - 설명		: 태그 금지어 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> unmatchedGrid(TagBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "unmatchedGrid", so);
	}
	
	public int deleteUnmatched(TagBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteUnmatched", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 금지어 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> pageUnmatched(TagBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageUnmatched", so);
	}

	public int tagGrpSortSeqChk(TagGroupSO so) {
		return selectOne(BASE_DAO_PACKAGE + "tagGrpSortSeqChk", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageUmTagContsLayer
	 * - 작성일		: 2021. 04. 13
	 * - 작성자		: kwj01
	 * - 설명		: tag 신조어 관련영상팝업 그리드 리스트
	 * </pre>
	 * @param so
	 * @return List<TagBaseVO>
	 */
	public List<TagBaseVO> pageUmTagContsLayer (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageUmTagContsLayer", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageUmTagLogLayer
	 * - 작성일		: 2021. 04. 13
	 * - 작성자		: kwj01
	 * - 설명		: tag 신조어 관련Log팝업 그리드 리스트
	 * </pre>
	 * @param so
	 * @return List<TagBaseVO>
	 */
	public List<TagBaseVO> pageUmTagLogLayer (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageUmTagLogLayer", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageUmTagGoodsLayer
	 * - 작성일		: 2021. 04. 13
	 * - 작성자		: kwj01
	 * - 설명		: tag 신조어 관련상품팝업 그리드 리스트
	 * </pre>
	 * @param so
	 * @return List<TagBaseVO>
	 */
	public List<TagBaseVO> pageUmTagGoodsLayer (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageUmTagGoodsLayer", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageUmTagTotalLayer
	 * - 작성일		: 2021. 04. 13
	 * - 작성자		: kwj01
	 * - 설명		: tag 신조어 등장횟수팝업 그리드 리스트
	 * </pre>
	 * @param so
	 * @return List<TagBaseVO>
	 */
	public List<TagBaseVO> pageUmTagTotalLayer (TagBaseSO so ) {
		return selectListPage (BASE_DAO_PACKAGE + "pageUmTagTotalLayer", so );
	}
}
