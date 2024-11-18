package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.*;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.petlog.model.PetLogBaseSO;
import biz.app.petlog.model.PetLogGoodsSO;
import biz.app.petlog.model.PetLogGoodsVO;




/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsCommentService.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 평가 서비스 Interface
* </pre>
*/
public interface GoodsCommentService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품평가 페이징 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsCommentVO> pageGoodsComment(GoodsCommentSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품평가 페이징 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsCommentVO> pageGoodsCommentAddBest(GoodsCommentSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: GoodsCommentService.java
	 * - 작성일	: 2016. 4. 8.
	 * - 작성자	: jangjy
	 * - 설명		: Front 마이페이지 - 작성가능한 상품평 리스트 페이징 조회
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<OrderDetailVO> pageBeforeGoodsCommentList( OrderSO orderSO );

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: GoodsCommentService.java
	 * - 작성일	: 2016. 4. 14.
	 * - 작성자	: jangjy
	 * - 설명		: Front 마이페이지 - 작성한 상품평 리스트 페이징 조회
	 * </pre>
	 * @param orderSo
	 * @return
	 */
	public List<GoodsCommentVO> pageAfterGoodsCommentList( GoodsCommentSO so );

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: GoodsCommentService.java
	 * - 작성일	: 2016. 4. 11.
	 * - 작성자	: jangjy
	 * - 설명		: Front 마이페이지 - 상품평가 팝업 정보 조회
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public GoodsCommentVO getGoodsCommentBase(Long goodsEstmNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 4. 11.
	* - 작성자		: snw
	* - 설명		: Front[상품상세-상품평가]상품평가 전체 데이터 수 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsCommentCountVO getGoodsCommentCount(String goodsId);
	
	GoodsCommentCountVO getGoodsCommentCount(GoodsCommentSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentService.java
	* - 작성일	: 2016. 4. 12.
	* - 작성자	: jangjy
	* - 설명		: 상품평 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void insertGoodsComment(GoodsCommentPO gPo, OrderDetailPO oPo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentService.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 수정
	* </pre>
	* @param po
	* @throws Exception
	*/
	void updateGoodsComment(GoodsCommentPO po, String deviceGb);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentService.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 삭제
	* </pre>
	* @param po
	* @throws Exception
	*/
	void deleteGoodsComment(GoodsCommentPO po);


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 리스트 조회 [BO]
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> pageGoodsCommentGrid (GoodsCommentSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 상세 조회 [BO]
	* </pre>
	* @param GoodsCommentDetailPO po
	* @return
	*/
	public GoodsCommentVO getGoodsComment (GoodsCommentDetailPO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 이미지 리스트 조회
	* </pre>
	* @param goodsEstmNo
	* @return
	*/
	public List<GoodsCommentImageVO> listGoodsCommentImage (Long goodsEstmNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 삭제 [BO]
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsCommentBo (GoodsCommentPO po );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2016. 5. 11.
	* - 작성자		: valueFactory
	* - 설명			: 상품평 일괄 수정
	* </pre>
	* @param goodsCommentPOList
	* @return
	*/
	public int updateGoodsCommentBatch (List<GoodsCommentPO> goodsCommentPOList );

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 2. 22.
	* - 작성자		: pcm
	* - 설명		: 상품 만족도 점수
	* </pre>
	* @param so
	* @return
	*/
	public GoodsCommentVO getGoodsCommentScore(GoodsCommentSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 2. 23.
	* - 작성자		: pcm
	* - 설명		: 상품 포토 후기
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentImageVO> getGoodsPhotoComment(GoodsCommentSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 2. 24.
	* - 작성자		: pcm
	* - 설명		: 상품평 입력 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsBaseVO commentWriteInfo(GoodsCommentSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 2. 25.
	* - 작성자		: pcm
	* - 설명		: 상품평 등록
	* </pre>
	* @param po
	*/
	public void insertGoodsComment(GoodsCommentPO po, String deviceGb);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 좋아요 체크
	* </pre>
	* @param po
	*/
	public int likeComment(GoodsCommentPO po);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 2.
	* - 작성자		: pcm
	* - 설명		: 
	* </pre>
	* @param so
	* @return
	*/
	GoodsCommentVO getGoodsComment(GoodsCommentSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : GoodsCommentService.java
	 * - 작성일        : 2021. 3. 5.
	 * - 작성자        : YKU
	 * - 설명          :
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsEstmQstVO> getPageGoodsCommentEstmList(GoodsCommentSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 26.
	 * - 작성자        : YKU
	 * - 설명          : 펫로그 후기(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PetLogGoodsVO> petLogReview(PetLogGoodsSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 8.
	* - 작성자		: pcm
	* - 설명		: 상품평 신고
	* </pre>
	* @param po
	*/
	public void reportGoodsComment(GoodsCommentPO po);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: pcm
	* - 설명		: 나의 상품평 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentVO> getMyGoodsComment(OrderDetailSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 19.
	* - 작성자		: pcm
	* - 설명		: 상품에 대한 상품 후기 수
	* </pre>
	* @param commentSO
	* @return
	*/
	public int pageGoodsCommentCount(GoodsCommentSO commentSO);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 22.
	* - 작성자		: pcm
	* - 설명		: 모바일 상품 평가 이미지 업로드
	* </pre>
	* @param po
	*/
	void appCommentImageUpdate(GoodsCommentPO po, String deviceGb);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 25.
	* - 작성자		: pcm
	* - 설명		: 펫로그 후기 이어쓰기 여부 체크
	* </pre>
	* @param po
	*/
	public int inheritCheck(GoodsCommentSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 3. 30.
	* - 작성자		: pcm
	* - 설명		: 
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCommentImageVO> getGoodsPhotoCommentAll(GoodsCommentSO so);

	public int getDuplicateCommentCount(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 6. 9.
	* - 작성자		: pcm
	* - 설명		: 후기 삭제를 위한 데이터 조회
	* </pre>
	* @param gcSO
	* @return
	*/
	GoodsCommentPO getCommentDeleteInfo(GoodsCommentSO gcSO);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCommentService.java
	* - 작성일		: 2021. 7. 15.
	* - 작성자		: pcm
	* - 설명		: [BO] 펫로그 후기 상세 
	* </pre>
	* @param so
	* @return
	*/
	GoodsCommentVO getPetLogGoodsComment(GoodsCommentSO so);
	
}