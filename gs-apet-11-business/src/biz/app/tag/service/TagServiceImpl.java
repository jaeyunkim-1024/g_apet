package biz.app.tag.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.tag.dao.TagDao;
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
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.service
* - 파일명     : TagServiceImpl.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Service("tagService")
@Transactional
public class TagServiceImpl implements TagService {

	@Autowired
	private TagDao tagDao;

	
	@Override
	@Transactional(readOnly=true)
	public TagBaseVO getTagDetail(String tagNo) {
		return tagDao.getTagDetail(tagNo);
	}
	
	@Override
	public List<TagBaseVO> pageTagBase (TagBaseSO so) {
		return tagDao.pageTagBase(so );
	}

	@Override
	public List<TagBaseVO> listTagBase(TagBaseSO so) {
		return Optional.ofNullable(tagDao.listTagBase(so)).orElseGet(()->new ArrayList<TagBaseVO>());
	}

	@Override
	public List<TagBaseVO> pageUnmatchedTagBase (TagBaseSO so) {
		return tagDao.pageUnmatchedTagBase(so );
	}
	
	@Override
	public String insertTagBase(TagBasePO po) {
		String tagNo = null;
		
		tagDao.insertTagBase(po );
		tagNo = po.getTagNo();
		
		String[] tagGrpNos = po.getTagGrpNos();
		if( tagGrpNos != null && tagGrpNos.length > 0) {
			for(String tagGrpNo : tagGrpNos) {
				po.setTagGrpNo(tagGrpNo);
				tagDao.insertTagGroupMap(po);
			}
		}		
		
		String[] rltTagNos = po.getRltTagNos();
		if( rltTagNos != null && rltTagNos.length > 0) {
			for(String rltTagNo : rltTagNos) {
				po.setRltTagNo(rltTagNo);
				tagDao.insertTagRelationMap(po );
			}
		}		
		
		String[] synTagNos = po.getSynTagNos();
		if( synTagNos != null && synTagNos.length > 0) {
			for(String synTagNo : synTagNos) {
				po.setSynTagNo(synTagNo);
				tagDao.insertTagSynonymMap(po );
			}
		}
		
		return tagNo;
		
	}
	
	
	@Override
	public String updateTagBase(TagBasePO po) {
		String tagNo = null;
		
		tagDao.updateTagBase(po );
		tagNo = po.getTagNo();
		
		String[] tagGrpNos = po.getTagGrpNos();
		//if( tagGrpNos != null && tagGrpNos.length > 0) {
			
			// 전체 삭제
			tagDao.deleteTagGroupMap(po);
			
			for(String tagGrpNo : tagGrpNos) {
				po.setTagGrpNo(tagGrpNo);
				tagDao.insertTagGroupMap(po);
			}
		//}		
		
		String[] rltTagNos = po.getRltTagNos();
		//if( rltTagNos != null && rltTagNos.length > 0) {
			
			// 전체 삭제
			tagDao.deleteTagRelationMap(po);			
			
			for(String rltTagNo : rltTagNos) {
				po.setRltTagNo(rltTagNo);
				tagDao.insertTagRelationMap(po );
			}
		//}		
		
		String[] synTagNos = po.getSynTagNos();
		//if( synTagNos != null && synTagNos.length > 0) {
			
			// 전체 삭제
			tagDao.deleteTagSynonymMap(po);			
			
			for(String synTagNo : synTagNos) {
				po.setSynTagNo(synTagNo);
				tagDao.insertTagSynonymMap(po );
			}
		//}
		
		return tagNo;
		
	}
	
	@Override
	public void deleteTagBase(TagBasePO po) {

		int result = tagDao.deleteTagBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	
	
	@Override
	public int updateTagBaseBatch (List<TagBasePO> tagBasePOList) {
		int updateCnt = 0;
		if(tagBasePOList != null && !tagBasePOList.isEmpty()) {
			for(TagBasePO po : tagBasePOList ) {
				
				tagDao.updateTagBase(po );
				updateCnt ++;
			}
		}

		return updateCnt;
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public List<TagBaseVO> listTagRelationMap(TagBaseSO so) {
		return tagDao.listTagRelationMap(so);
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public List<TagBaseVO> listTagSynonymMap(TagBaseSO so) {
		return tagDao.listTagSynonymMap(so);
	}
		
	
	@Override
	@Transactional(readOnly=true)
	public List<TagGroupTreeVO> listTagGroupTree() {
		List<TagGroupTreeVO> result = new ArrayList<>();

		TagGroupTreeVO vo = new TagGroupTreeVO();
		vo.setId(String.valueOf(AdminConstants.MENU_DEFAULT_NO));
		vo.setText("Back Office");
		vo.setParent("#");
		result.add(vo);
		result.addAll(tagDao.listTagGroupTree());

		return result;
	}

	@Override
	@Transactional(readOnly=true)
	public TagGroupVO getTagGroup(TagGroupSO so) {
		return tagDao.getTagGroup(so);
	}

	
	@Override
	@Transactional(readOnly=true)
	public List<TagGroupVO> listTagGroupMap(TagBaseSO so) {
		return tagDao.listTagGroupMap(so);
	}
	
	
	@Override
	public void saveTagGroup(TagGroupPO po) {
		TagGroupSO so = new TagGroupSO();
		so.setTagGrpNo(po.getTagGrpNo());

		TagGroupVO vo = getTagGroup(so);

		int result = 0;
		if(vo != null) {
			result = tagDao.updateTagGroup(po);
		} else {
			result = tagDao.insertTagGroup(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	@Override
	public void deleteTagGroup(TagGroupPO po) {
		TagGroupSO so = new TagGroupSO();
		so.setUpGrpNo(po.getTagGrpNo());

		int cnt = tagDao.getCheckTagGroup(so);
		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_UP_TAG_FAIL);
		}

		int result = tagDao.deleteTagGroup(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<TagGroupVO> listTagGroup(TagGroupSO so) {
		return tagDao.listTagGroup(so);
	}
	
	
	@Override
	@Transactional(readOnly=true)
	public List<TagGroupVO> listDisplayTagGroup(TagGroupSO so) {
		return tagDao.listDisplayTagGroup(so);
	}
	
	
	@Override
	public List<TagTrendVO> pageTagTrend (TagTrendSO so) {
		List<TagTrendVO> list = tagDao.pageTagTrend(so);
		for(TagTrendVO vo : list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}
		return list;
	}
	
	
	@Override
	public String insertTagTrend(TagTrendPO po) {
		String trdNo = null;
		
		tagDao.insertTagTrend(po );
		trdNo = po.getTrdNo();
		
		String[] tagNos = po.getTagNos();
		if( tagNos != null && tagNos.length > 0) {
			for(String tagNo : tagNos) {
				po.setTagNo(tagNo);
				tagDao.insertTagTrendMap(po);
			}
		}		
		
		return trdNo;		
	}
	
	@Override
	public int updateTagTrendBatch (List<TagTrendPO> tagTrendPOList) {
		int updateCnt = 0;
		if(tagTrendPOList != null && !tagTrendPOList.isEmpty()) {
			for(TagTrendPO po : tagTrendPOList ) {
				
				tagDao.updateTagTrend(po );
				updateCnt ++;
			}
		}
		return updateCnt;
	}
	
	
	@Override
	public int deleteTagTrendBatch (List<TagTrendPO> tagTrendPOList) {
		int deleteCnt = 0;
		if(tagTrendPOList != null && !tagTrendPOList.isEmpty()) {
			for(TagTrendPO po : tagTrendPOList ) {
				tagDao.deleteTagTrendMap(po );
				
				tagDao.deleteTagTrend(po );
				deleteCnt ++;
			}
		}
		return deleteCnt;
	}
	
	
	@Override
	public List<TagBaseVO> pageTagGoodsList (TagBaseSO so) {
		return tagDao.pageTagGoodsList(so );
	}
	
	@Override
	public List<TagBaseVO> pageTagContentsList (TagBaseSO so) {
		return tagDao.pageTagContentsList(so );
	}

	@Override
	public List<String> insertTagsWithString(String str) {
		List<String> tags = StringUtil.getTags(str);
		List<String> tagNos = new ArrayList<>();
		for (String tag : tags) {
			TagBasePO tbpo = new TagBasePO();
			tbpo.setTagNm(tag);
			tbpo.setSrcCd("M");
			tbpo.setStatCd("U");
			String thisTagNo = this.insertTagBase(tbpo);
			tagNos.add(thisTagNo);
		}
		return tagNos;
	}
	
	@Override
	public int tagNmCheck(String tagNm) {
		return tagDao.tagNmCheck(tagNm);
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<TagBaseVO> listTagGoodsId(String goodsId) {
		return tagDao.listTagGoodsId(goodsId);
	}

	@Override
	public List<TagBaseVO> unmatchedGrid(TagBaseSO so) {
		return tagDao.unmatchedGrid(so);
	}

	@Override
	public void deleteUnmatched(TagBasePO po) {
		int result = tagDao.deleteUnmatched(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public List<TagBaseVO> pageUnmatched(TagBaseSO so) {
		List<TagBaseVO> list = tagDao.pageUnmatched(so);
		
		return list;
	}
	
	public TagBaseVO getTagInfo(TagBaseSO so) {
		return tagDao.getTagInfo(so);
	}

	@Override
	public int tagGrpSortSeqChk(TagGroupSO so) {
		return tagDao.tagGrpSortSeqChk(so);
	}
	
	@Override
	public List<TagBaseVO> pageUmTagContsLayer (TagBaseSO so) {
		List<TagBaseVO> list = tagDao.pageUmTagContsLayer(so );
		for(TagBaseVO vo: list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}
		return list;
	}
	
	@Override
	public List<TagBaseVO> pageUmTagLogLayer (TagBaseSO so) {
		List<TagBaseVO> list = tagDao.pageUmTagLogLayer(so );
		for(TagBaseVO vo: list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}
		return list;
	}
	
	@Override
	public List<TagBaseVO> pageUmTagGoodsLayer (TagBaseSO so) {
		List<TagBaseVO> list = tagDao.pageUmTagGoodsLayer(so );
		for(TagBaseVO vo: list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}
		return list;
	}
	
	@Override
	public List<TagBaseVO> pageUmTagTotalLayer (TagBaseSO so) {
		List<TagBaseVO> list = tagDao.pageUmTagTotalLayer(so );
		for(TagBaseVO vo: list) {
			vo.setSysRegrNm(MaskingUtil.getName(vo.getSysRegrNm()));
		}
		return list;
	}
	
}