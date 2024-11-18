package biz.app.tag.service;

import java.util.List;

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


/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.service
* - 파일명     : TagService.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
public interface TagService {

	
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 17.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return TagBaseVO
	*/
	public TagBaseVO getTagDetail(String tagNo);
	
	
	public List<TagBaseVO> pageTagBase (TagBaseSO so );

	public List<TagBaseVO> listTagBase (TagBaseSO so );

	public List<TagBaseVO> pageUnmatchedTagBase (TagBaseSO so );
	
	public String insertTagBase(TagBasePO po);	
	
	public String updateTagBase(TagBasePO po);
	
	public void deleteTagBase(TagBasePO po);
	
	public List<TagBaseVO> listTagRelationMap(TagBaseSO so);
	
	public List<TagBaseVO> listTagSynonymMap(TagBaseSO so);
	
	public int updateTagBaseBatch (List<TagBasePO> tagBasePOList );
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return List<TagGroupTreeVO>
	*/
	public List<TagGroupTreeVO> listTagGroupTree();

	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return TagGroupVO
	*/
	public TagGroupVO getTagGroup(TagGroupSO so);

	public List<TagGroupVO> listTagGroupMap(TagBaseSO so);
	
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return void
	*/
	public void saveTagGroup(TagGroupPO po);

	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return void
	*/
	public void deleteTagGroup(TagGroupPO po);

	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 12. 16.
	* - 작성자     : ljy01
	* - 설명       :
	* </pre>
	* @param 
	* @return List<TagGroupVO>
	*/
	public List<TagGroupVO> listTagGroup(TagGroupSO so);

	
	public List<TagGroupVO> listDisplayTagGroup(TagGroupSO so);
	
	
	public List<TagTrendVO> pageTagTrend (TagTrendSO so );
	
	public String insertTagTrend(TagTrendPO po);
	
	public int updateTagTrendBatch (List<TagTrendPO> tagTrendPOList );

	public int deleteTagTrendBatch (List<TagTrendPO> tagTrendPOList );	
	
	public List<TagBaseVO> pageTagGoodsList (TagBaseSO so );
	
	public List<TagBaseVO> pageTagContentsList (TagBaseSO so );	
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2020. 01. 07.
	* - 작성자     : KKB
	* - 설명       : String에서 태그를 추출하여 등록 
	* </pre>
	* @param 
	* @return int
	*/
	public List<String> insertTagsWithString(String str);
	
	
	public int tagNmCheck(String tagNm);

	public List<TagBaseVO> listTagGoodsId(String goodsId);
	
	public List<TagBaseVO> unmatchedGrid(TagBaseSO so);
	
	public void deleteUnmatched(TagBasePO po);
	
	public List<TagBaseVO> pageUnmatched(TagBaseSO so);
	
	public TagBaseVO getTagInfo(TagBaseSO so);

	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2021. 03. 30.
	* - 작성자     : KSH
	* - 설명       : 태그 그룹 정렬순서 중복체크 
	* </pre>
	* @param TagGroupSO so
	* @return Long
	*/
	public int tagGrpSortSeqChk(TagGroupSO so);
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2021. 04. 13.
	* - 작성자     : kwj01
	* - 설명       :tag 신조어 관련영상팝업 그리드 리스트
	* </pre>
	* @param 
	* @return List<TagBaseVO>
	*/
	public List<TagBaseVO> pageUmTagContsLayer (TagBaseSO so );
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2021. 04. 13.
	* - 작성자     : kwj01
	* - 설명       :tag 신조어 관련Log팝업 그리드 리스트
	* </pre>
	* @param 
	* @return List<TagBaseVO>
	*/
	public List<TagBaseVO> pageUmTagLogLayer (TagBaseSO so );
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2021. 04. 13.
	* - 작성자     : kwj01
	* - 설명       :tag 신조어 관련상품팝업 그리드 리스트
	* </pre>
	* @param 
	* @return List<TagBaseVO>
	*/
	public List<TagBaseVO> pageUmTagGoodsLayer (TagBaseSO so );
	
	/**
	* <pre>
	* - 프로젝트명 : gs-apet-11-business
	* - 파일명     : TagService.java
	* - 작성일     : 2021. 04. 13.
	* - 작성자     : kwj01
	* - 설명       :tag 신조어 등장횟수팝업 그리드 리스트
	* </pre>
	* @param 
	* @return List<TagBaseVO>
	*/
	public List<TagBaseVO> pageUmTagTotalLayer (TagBaseSO so );
}