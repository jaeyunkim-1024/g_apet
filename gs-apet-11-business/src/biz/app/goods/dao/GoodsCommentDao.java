package biz.app.goods.dao;

import java.util.List;

import biz.app.goods.model.*;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.deser.Deserializers.Base;

import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.petlog.model.PetLogGoodsSO;
import biz.app.petlog.model.PetLogGoodsVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsCommentDao.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 평가 DAO
* </pre>
*/
@Repository
public class GoodsCommentDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsComment.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품평가 목록 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> pageGoodsComment (GoodsCommentSO so){
		return this.selectListPage(BASE_DAO_PACKAGE + "pageGoodsComment", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품평가 목록 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> pageGoodsCommentAddBest (GoodsCommentSO so){
		return this.selectListPage(BASE_DAO_PACKAGE + "pageGoodsCommentAddBest", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 11.
	* - 작성자	: jangjy
	* - 설명		: 상품평가 데이터 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsCommentVO getGoodsCommentBase (GoodsCommentSO so){
		return this.selectOne(BASE_DAO_PACKAGE + "getGoodsCommentBase", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 4. 11.
	* - 작성자		: snw
	* - 설명		: 상품평가 전체 데이터 수 조회(종류별)
	* </pre>
	* @param so
	* @return
	*/
	public GoodsCommentCountVO getGoodsCommentCount(GoodsCommentSO so){
		return this.selectOne(BASE_DAO_PACKAGE + "getGoodsCommentCount", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 12.
	* - 작성자	: jangjy
	* - 설명		: 상품평 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsComment(GoodsCommentPO po){
		return insert(BASE_DAO_PACKAGE + "insertGoodsComment", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 5. 11.
	* - 작성자	: jangjy
	* - 설명		: 상품평 이미지 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsCommentImage(GoodsCommentImagePO po){
		return insert(BASE_DAO_PACKAGE + "insertGoodsCommentImage", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsComment(GoodsCommentPO po){
		return update(BASE_DAO_PACKAGE + "updateGoodsComment", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteGoodsComment(GoodsCommentPO po){
		return update(BASE_DAO_PACKAGE + "deleteGoodsComment", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 이미지 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteGoodsCommentImage(GoodsCommentImagePO po){
		return delete(BASE_DAO_PACKAGE + "deleteGoodsCommentImage", po);
	}

	public Long getMaxImageSequence (Long goodsEstmNo){
		return this.selectOne(BASE_DAO_PACKAGE + "getMaxImageSequence", goodsEstmNo);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDao.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: Front 마이페이지 - 작성한 상품평 리스트 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> pageAfterGoodsCommentList (GoodsCommentSO so){
		return this.selectListPage(BASE_DAO_PACKAGE + "pageAfterGoodsComment", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//-
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 리스트 조회 [BO]
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> pageGoodsCommentGrid (GoodsCommentSO so ) {
		return selectListPage("goodsComment.pageGoodsCommentGrid", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 상세 조회 [BO]
	* </pre>
	* @param goodsEstmNo
	* @return
	*/
	public GoodsCommentVO getGoodsComment (GoodsCommentDetailPO po ) {
		return (GoodsCommentVO)selectOne("goodsComment.getGoodsComment", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 이미지 리스트 조회
	* </pre>
	* @param goodsEstmNo
	* @return
	*/
	public List<GoodsCommentImageVO> listGoodsCommentImage (Long goodsEstmNo ) {
		return selectList("goodsComment.listGoodsCommentImage", goodsEstmNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 수정 [BO]
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsCommentBo (GoodsCommentPO po ) {
		return update("goodsComment.updateGoodsCommentBo", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 주문번호로 상품평수 조회
	* </pre>
	* @param po
	* @return
	*/
	public int getGoodsCommentCountByOrd (OrderDetailPO po ) {
		return selectOne("goodsComment.getGoodsCommentCountByOrd", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 22.
	* - 작성자		: pcm
	* - 설명		: 상품 평가 점수
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentScoreVO> getGoodsCommentScore(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsCommentScore", so);
	}
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 22.
	* - 작성자		: pcm
	* - 설명		: 상품평 평가 결과 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsEstmQstVO> getGoodsEstm(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsEstm", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 23.
	* - 작성자		: pcm
	* - 설명		: 상품 포토 후기
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentImageVO> getGoodsPhotoComment(GoodsCommentSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "getGoodsPhotoComment", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 작성에 필요한 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsBaseVO commentWriteInfo(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "commentWriteInfo", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품 평가 항목 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsEstmQstVO> goodsEstmQstList(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "goodsEstmQstList", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품 평가자 펫 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<PetBaseVO> petBaseList(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "petBaseList", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품 평가 답변 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsEstmRpl(GoodsEstmRplPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsEstmRpl", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 상품 링크 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsCommentLink(GoodsCommentPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsCommentLink", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 좋아요 여부 체크
	* </pre>
	* @param po
	* @return
	*/
	public int commentLikeCheck(GoodsCommentPO po) {
		return selectOne(BASE_DAO_PACKAGE + "commentLikeCheck", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 좋아요 취소
	* </pre>
	* @param po
	* @return
	*/
	public int delCommentLike(GoodsCommentPO po) {
		return delete(BASE_DAO_PACKAGE + "delCommentLike", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 좋아요 추가
	* </pre>
	* @param po
	* @return
	*/
	public int addCommentLike(GoodsCommentPO po) {
		return insert(BASE_DAO_PACKAGE + "addCommentLike", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 수정 데이터 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsCommentVO getGoodsComment(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsComment", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentDao.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 평가 답변 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsEstmRpl(GoodsEstmRplPO po) {
		return update(BASE_DAO_PACKAGE + "updateGoodsEstmRpl", po);
	}
	
	public List<GoodsEstmQstVO> getPageGoodsCommentEstmList(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "getPageGoodsCommentEstmList", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 2. 26.
	 * - 작성자        : YKU
	 * - 설명          : 펫로그 후기(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PetLogGoodsVO> petLogReview(PetLogGoodsSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "petLogReview", so);
	}

	public int searchReportGoodsComment(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "searchReportGoodsComment", so);
	}

	public int reportGoodsComment(GoodsCommentPO po) {
		return insert(BASE_DAO_PACKAGE + "reportGoodsComment", po);
	}

	public List<GoodsCommentVO> getMyGoodsComment(OrderDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "getMyGoodsComment", so);
	}

	public int pageGoodsCommentCount(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "pageGoodsCommentCount", so);
	}

	public int inheritCheck(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "inheritCheck", so);
	}

	public List<GoodsCommentImageVO> getGoodsPhotoCommentAll(GoodsCommentSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsPhotoCommentAll", so);
	}


	public int copyGoodsComment(GoodsBasePO po) {
		return insert(BASE_DAO_PACKAGE + "copyGoodsComment", po);
	}


	public int getDuplicateCommentCount(GoodsBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getDuplicateCommentCount", so);
	}

	public GoodsCommentPO getCommentDeleteInfo(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCommentDeleteInfo", so);
	}

	public GoodsCommentVO getPetLogGoodsComment(GoodsCommentSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getPetLogGoodsComment", so);
	}

}
