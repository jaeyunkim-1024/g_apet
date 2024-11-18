package biz.app.tv.service;

import java.util.List;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.tv.dao.TvDetailDao;
import biz.app.tv.model.TvDetailGoodsVO;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailReplyVO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.model.TvWatchHistVO;
import biz.common.service.BizService;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.tv.service
 * - 파일명		: TvDetailServiceImpl.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class TvDetailServiceImpl implements TvDetailService {
	
	@Autowired
	private TvDetailDao tvDetailDao;
	
	@Autowired
	private BizService bizService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvWatchHistVO selectVdoWatchHist(TvDetailSO so) {
		return tvDetailDao.selectVdoWatchHist(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoWatchHist(TvDetailPO po) {
		return tvDetailDao.insertVdoWatchHist(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoDetailInfo(TvDetailSO so) {
		TvDetailVO vo = tvDetailDao.selectVdoDetailInfo(so);
		vo.setTtl(StringEscapeUtils.unescapeHtml(vo.getTtl()));
		return vo;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 단순상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectSimpleVdoDetailInfo(TvDetailSO so) {
		return tvDetailDao.selectSimpleVdoDetailInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 태그 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoTagList(TvDetailSO so) {
		return tvDetailDao.selectVdoTagList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 조회수 증가
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateVdoHits(TvDetailSO so) {
		return tvDetailDao.updateVdoHits(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectVdoReplyList(TvDetailSO so) {
		return tvDetailDao.selectVdoReplyList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 연관상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailGoodsVO> selectVdoGoodsList(TvDetailSO so) {
		return tvDetailDao.selectVdoGoodsList(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: 
	 * - 설명		: 펫샵 상세 > 관련영상 목록 조회
	 * </pre>
	 * @return
	 */
	@Override
	public List<TvDetailGoodsVO> listGoodsContentsByGoodsId(String goodsId) {
		return tvDetailDao.listGoodsContentsByGoodsId(goodsId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시리즈 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSrisList(TvDetailSO so) {
		return tvDetailDao.selectVdoSrisList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSrisInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoPrevSrisInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSrisInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoNextSrisInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 마지막(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoLastSrisInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoLastSrisInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 첫번째(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoFirstSrisInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoFirstSrisInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시즌 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSesnList(TvDetailSO so) {
		return tvDetailDao.selectVdoSesnList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSesnInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoPrevSesnInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSesnInfo(TvDetailSO so) {
		return tvDetailDao.selectVdoNextSesnInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveVdoViewHist(TvDetailPO po) {
		return tvDetailDao.saveVdoViewHist(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요, 찜 저장/해제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveVdoLikeDibs(TvDetailPO po) {
		int rs = 0;
		
		/*TvDetailSO so = new TvDetailSO();
		so.setVdId(po.getVdId());
		so.setMbrNo(po.getMbrNo());*/
		
		String chkYn = tvDetailDao.selectVdoLikeDibsCheck(po);
		if("N".equals(chkYn)) {
			int result = tvDetailDao.insertVdoLikeDibs(po);
			
			if(result != 1) {
				rs = 0;
			}else {
				rs = 1;
			}
		}else {
			tvDetailDao.deleteVdoLikeDibs(po);
			
			rs = 2;
		}
		
		return rs;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요 건수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public int selectLikeCount(TvDetailPO po) {
		return tvDetailDao.selectLikeCount(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 공유 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoShare(TvDetailPO po) {
		return tvDetailDao.insertVdoShare(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 단축URL 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateVdoShortUrl(TvDetailPO po) {
		return tvDetailDao.updateVdoShortUrl(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 목록조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectRecentVdoList(TvDetailSO so) {
		return tvDetailDao.selectRecentVdoList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteRecentVdo(TvDetailPO po) {
		return tvDetailDao.deleteRecentVdo(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailServiceImpl.java
	 * - 작성일		: 2021. 08. 26.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 로그인한 회원의 좋아요, 찜 여부 확인
	 * </pre>
	 * @param po
	 * @return
	 */
	public String selectVdoMbrLikeMarkCheck(TvDetailPO po) {
		return tvDetailDao.selectVdoMbrLikeMarkCheck(po);
	}

}
