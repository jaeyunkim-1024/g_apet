package biz.app.goods.service;


import biz.app.goods.dao.GoodsCommentDetailDao;
import biz.app.goods.model.GoodsCommentDetailPO;

import biz.app.goods.model.GoodsCommentDetailPetlogVO;
import biz.app.goods.model.GoodsCommentDetailReplyPO;
import biz.app.goods.model.GoodsCommentDetailReplyVO;
import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.service
* - 파일명		: GoodsCommentDetailServiceImpl.java
* - 작성일		: 2020.01.05
* - 작성자		: yjs01
* - 설명		: 상품 후기 상세 서비스
* </pre>
*/
@Slf4j
@Service("goodsCommentDetailService")
public class GoodsCommentDetailServiceImpl implements GoodsCommentDetailService {

	@Autowired
	private GoodsCommentDetailDao goodsCommentDetailDao;
	@Autowired
	private BizService bizService;

	@Override
	public long updateGoodsCommentDetail(GoodsCommentDetailPO po) {
		goodsCommentDetailDao.updateGoodsCommentDetail(po);
		return goodsCommentDetailDao.updateGoodsCommentLinkDetail(po);
	}

	@Override
	public long updateGoodsCommentBestDetail(GoodsCommentDetailPO po) {
		return goodsCommentDetailDao.updateGoodsCommentBestDetail(po);
	}

	@Override
	public List<CodeDetailVO> getGoodsCommentEstmScoreList() {
		return goodsCommentDetailDao.getGoodsCommentEstmScoreList();
	}

	@Override
	public List<GoodsCommentDetailReplyVO> getGoodsCommentEstmReplyList(Long goodsEstmNo) {
		return goodsCommentDetailDao.getGoodsCommentEstmReplyList(goodsEstmNo);
	}

	@Override
	public List<GoodsCommentDetailReplyVO> getGoodsCommentRptpRsnInfoList(Long goodsEstmNo) {
		List<GoodsCommentDetailReplyVO> list = goodsCommentDetailDao.getGoodsCommentRptpRsnInfoList(goodsEstmNo);
		if (CollectionUtils.isNotEmpty(list)) {
			for(int i=0; i<list.size(); i++) {
				// 로그인 아이디 복호화/마스킹
				String loginId = bizService.twoWayDecrypt(list.get(i).getLoginId());
				if (StringUtil.isNotEmpty(loginId)) {
					list.get(i).setLoginId(MaskingUtil.getId(loginId));
				}
			}
		}
		return list;
	}

	@Override
	public List<GoodsCommentDetailReplyVO> getPetLogGoodsCommentRptpRsnInfoList(Long goodsEstmNo) {
		List<GoodsCommentDetailReplyVO> list = goodsCommentDetailDao.getPetLogGoodsCommentRptpRsnInfoList(goodsEstmNo);
		if (CollectionUtils.isNotEmpty(list)) {
			for(int i=0; i<list.size(); i++) {
				// 로그인 아이디 복호화/마스킹
				String loginId = bizService.twoWayDecrypt(list.get(i).getLoginId());
				if (StringUtil.isNotEmpty(loginId)) {
					list.get(i).setLoginId(MaskingUtil.getId(loginId));
				}
			}
		}
		return list;
	}
	@Override
	public GoodsCommentDetailPetlogVO getGoodsCommentPetlogInfo(String petLogNo) {
		return goodsCommentDetailDao.getGoodsCommentPetlogInfo(petLogNo);
	}

	/**
	 * 펫 로그 이미지 및 영상 처리 함수.
	 * @param imageVOList
	 * @param goodsEstmNo
	 * @param rownum
	 * @param imgPath
	 * @param vdYn
	 */
	@Override
	public void getPetlogInfoImage(List<GoodsCommentImageVO> imageVOList, Long goodsEstmNo, int rownum, String imgPath, String vdYn) {
		log.info("{}, imgPath is {}", rownum, (imgPath.trim().length() > 0));
		if(imgPath != null && imgPath.trim().length() > 0) {
			GoodsCommentImageVO imageVo = new GoodsCommentImageVO();
			imageVo.setGoodsEstmNo(goodsEstmNo);
			imageVo.setImgPath(imgPath);
			imageVo.setRownum(rownum);
			imageVo.setVdYn(vdYn);
			imageVOList.add(imageVo);
		}
	}

}