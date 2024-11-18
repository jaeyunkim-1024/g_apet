package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.model.GoodsPO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsInquiryService.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 문의 서비스 Interface
* </pre>
*/
public interface GoodsInquiryService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 페이징 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsInquiryVO> pageGoodsInquiry(GoodsInquirySO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 상세 조회
	* </pre>
	* @param goodsIqrNo
	* @return
	* @throws Exception
	*/
	GoodsInquiryVO getGoodsInquiry(GoodsInquirySO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void insertGoodsInquiry(GoodsInquiryPO po, String deviceGb);

	
		/**
		* <pre>
		* - 프로젝트명	: gs-apet-11-business
		* - 파일명		: GoodsInquiryService.java
		* - 작성일		: 2021. 2. 18.
		* - 작성자		: pcm
		* - 설명		: 상품 문의 삭제
		* </pre>
		* @param po
		*/
	void deleteGoodsInquiry(GoodsInquiryPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsInquiryService.java
	* - 작성일	: 2016. 4. 8.
	* - 작성자	: jangjy
	* - 설명		: 마이페이지 - 상품문의 페이징 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsInquiryVO> pageMyGoodsInquiry(GoodsInquirySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 [BO]
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsInquiryVO> listGoodsInquiryGrid(GoodsInquirySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 전시상태 수정 [BO]
	 * </pre>
	 * @param po
	 */
	public void updateGoodsInquiryDisp(GoodsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 상세 조회 [BO]
	 * </pre>
	 * @param goodsIqrNo
	 * @return
	 */
	GoodsInquiryVO getGoodsInquiryDetail(Long goodsIqrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 저장 [BO]
	 * </pre>
	 * @param po
	 */
	void updateGoodsInquiry(GoodsInquiryPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 리스트 [BO]
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsInquiryVO> listGoodsReplyGrid(GoodsInquirySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryService.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 수정 [BO]
	 * </pre>
	 * @param po
	 */
	int updateGoodsReply(GoodsInquiryPO po);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsController.java
	* - 작성일		: 2021. 2. 16.
	* - 작성자		: pcm
	* - 설명		: 상품 qna 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	List<GoodsInquiryVO> getGoodsInquiryList(GoodsInquirySO so);

		
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2021. 2. 18.
	* - 작성자		: pcm
	* - 설명		: 상품 문의 수정
	* </pre>
	* @param po
	*/
	void updateGoodsQna(GoodsInquiryPO po, String deviceGb);

		
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2021. 2. 19.
	* - 작성자		: pcm
	* - 설명		: 상품 문의 조회(수정)
	* </pre>
	* @param so
	* @return
	*/
	GoodsInquiryVO getGoodsQna(GoodsInquirySO so);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsInquiryService.java
	* - 작성일		: 2021. 3. 22.
	* - 작성자		: pcm
	* - 설명		: 상품 문의 모바일 이미지 업로드
	* </pre>
	* @param po
	*/
	public void appInquiryImageUpdate(GoodsInquiryPO po, String deviceGb);

}