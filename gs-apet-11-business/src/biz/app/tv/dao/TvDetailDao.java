package biz.app.tv.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.tv.model.TvDetailGoodsVO;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailReplyVO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.model.TvWatchHistVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.tv.dao
 * - 파일명		: TvDetailDao.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 DAO
 * </pre>
 */
@Repository
public class TvDetailDao extends MainAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "tvDetail.";
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvWatchHistVO selectVdoWatchHist(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoWatchHist", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoWatchHist(TvDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertVdoWatchHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoDetailInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoDetailInfo", so);
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
		return selectList(BASE_DAO_PACKAGE + "selectSimpleVdoDetailInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 태그 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoTagList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectVdoTagList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 조회수 증가
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateVdoHits(TvDetailSO so) {
		return update(BASE_DAO_PACKAGE + "updateVdoHits", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectVdoReplyList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectVdoReplyList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 연관상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailGoodsVO> selectVdoGoodsList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectVdoGoodsList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: 
	 * - 설명			: 펫샵 상세 > 관련영상 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailGoodsVO> listGoodsContentsByGoodsId(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsContentsByGoodsId", goodsId);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시리즈 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSrisList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectVdoSrisList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSrisInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoPrevSrisInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSrisInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoNextSrisInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 마지막(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoLastSrisInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoLastSrisInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 첫번째(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoFirstSrisInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoFirstSrisInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시리즈 & 시즌 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSesnList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectVdoSesnList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSesnInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoPrevSesnInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSesnInfo(TvDetailSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoNextSesnInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 저장
	 * </pre>
	 * @param so
	 * @return
	 */
	public int saveVdoViewHist(TvDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "saveVdoViewHist", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요, 찜 저장여부 확인
	 * </pre>
	 * @param po
	 * @return
	 */
	public String selectVdoLikeDibsCheck(TvDetailPO po) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoLikeDibsCheck", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요, 찜 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoLikeDibs(TvDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertVdoLikeDibs", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요, 찜 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteVdoLikeDibs(TvDetailPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteVdoLikeDibs", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요 건수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public int selectLikeCount(TvDetailPO po) {
		return selectOne(BASE_DAO_PACKAGE + "selectLikeCount", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 공유 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoShare(TvDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertVdoShare", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 단축URL 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateVdoShortUrl(TvDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "updateVdoShortUrl", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 목록조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectRecentVdoList(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectRecentVdoList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteRecentVdo(TvDetailPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteRecentVdo", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 08. 26.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 로그인한 회원의 좋아요, 찜 여부 확인
	 * </pre>
	 * @param po
	 * @return
	 */
	public String selectVdoMbrLikeMarkCheck(TvDetailPO po) {
		return selectOne(BASE_DAO_PACKAGE + "selectVdoMbrLikeMarkCheck", po);
	}
	
}
