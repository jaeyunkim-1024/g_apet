package biz.app.tv.service;

import java.util.List;

import biz.app.tv.model.TvDetailGoodsVO;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailReplyVO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.model.TvWatchHistVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.tv.service
 * - 파일명		: TvDetailService.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 서비스 Interface
 * </pre>
 */
public interface TvDetailService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvWatchHistVO selectVdoWatchHist(TvDetailSO so);
	
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
	public int insertVdoWatchHist(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoDetailInfo(TvDetailSO so);
	
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
	public List<TvDetailVO> selectSimpleVdoDetailInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 태그 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoTagList(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 조회수 증가
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateVdoHits(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectVdoReplyList(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 연관상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailGoodsVO> selectVdoGoodsList(TvDetailSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: 
	 * - 설명			: 펫샵 상세 > 관련영상 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailGoodsVO> listGoodsContentsByGoodsId(String goodsId);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시리즈 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSrisList(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSrisInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSrisInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 마지막(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoLastSrisInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 첫번째(등록순) 시리즈 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoFirstSrisInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 시즌 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectVdoSesnList(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 이전 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoPrevSesnInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 다음 시즌 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TvDetailVO selectVdoNextSesnInfo(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 시청이력 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveVdoViewHist(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요, 찜 저장/해제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveVdoLikeDibs(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 좋아요 건수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public int selectLikeCount(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 영상 공유 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertVdoShare(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 03. 29.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 단축URL 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateVdoShortUrl(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 목록조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailVO> selectRecentVdoList(TvDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteRecentVdo(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 08. 26.
	 * - 작성자		: LDS
	 * - 설명			: 펫TV 상세 > 로그인한 회원의 좋아요, 찜 여부 확인
	 * </pre>
	 * @param po
	 * @return
	 */
	public String selectVdoMbrLikeMarkCheck(TvDetailPO po);
	
}
