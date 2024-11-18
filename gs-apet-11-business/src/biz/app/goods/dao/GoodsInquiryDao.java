package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.model.GoodsIqrImgPO;
import framework.common.dao.MainAbstractDao;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsInquiryDao.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 문의 DAO
* </pre>
*/
@Repository
public class GoodsInquiryDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsInquiry.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsInquiryVO> pageGoodsInquiry (GoodsInquirySO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageGoodsInquiry", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsInquiryVO getGoodsInquiry(GoodsInquirySO so){
		return selectOne(BASE_DAO_PACKAGE + "getGoodsInquiry", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryDao.java
	* - 작성일		: 2016. 4. 11.
	* - 작성자		: snw
	* - 설명		: 상품문의 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsInquiry(GoodsInquiryPO po){
		if(po.getEqrrMobile() != null) {po.setEqrrMobile(po.getEqrrMobile().replaceAll("-", ""));}
		return insert(BASE_DAO_PACKAGE + "insertGoodsInquiry", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsInquiryDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품문의 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteGoodsInquiry(GoodsInquiryPO po){
		return delete(BASE_DAO_PACKAGE + "deleteGoodsInquiry", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsInquiryDao.java
	* - 작성일	: 2016. 4. 8.
	* - 작성자	: jangjy
	* - 설명		: 마이페이지 - 상품문의 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsInquiryVO> pageMyGoodsInquiry (GoodsInquirySO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageMyGoodsInquiry", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 [BO]
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsInquiryVO> listGoodsInquiryGrid (GoodsInquirySO so){
		return selectListPage("goodsInquiry.listGoodsInquiryGrid", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 전시상태 수정 [BO]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateGoodsInquiryDisp(GoodsInquiryPO po) {
		return update("goodsInquiry.updateGoodsInquiryDisp", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 상세 조회 [BO]
	 * </pre>
	 * @param goodsIqrNo
	 * @return
	 */
	public GoodsInquiryVO getGoodsInquiryDetail(Long goodsIqrNo){
		return (GoodsInquiryVO) selectOne("goodsInquiry.getGoodsInquiryDetail", goodsIqrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 저장 [BO]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateGoodsInquiry(GoodsInquiryPO po) {
		return update("goodsInquiry.updateGoodsInquiry", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 리스트 [BO]
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsInquiryVO> listGoodsReplyGrid (GoodsInquirySO so){
		return selectList("goodsInquiry.listGoodsReplyGrid", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsInquiryDao.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 수정 [BO]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateGoodsReply(GoodsInquiryPO po) {
		return update("goodsInquiry.updateGoodsReply", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsController.java
	* - 작성일		: 2021. 2. 16.
	* - 작성자		: pcm
	* - 설명		: 상품 qna 리스트 조회 [FO]
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsInquiryVO> getGoodsInquiryList(GoodsInquirySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "getGoodsInquiryList", so);
	}

	
		/**
		* <pre>
		* - 프로젝트명	: gs-apet-11-business
		* - 파일명		: GoodsInquiryDao.java
		* - 작성일		: 2021. 2. 18.
		* - 작성자		: pcm
		* - 설명		: 상품 QnA 등록 [FO]
		* </pre>
		* @param po
		* @return
		*/
	public int insertGoodsQna(GoodsInquiryPO po) {
		return insert(BASE_DAO_PACKAGE + "isnertGoodsQna", po);
	}

	
		/**
		* <pre>
		* - 프로젝트명	: gs-apet-11-business
		* - 파일명		: GoodsInquiryDao.java
		* - 작성일		: 2021. 2. 18.
		* - 작성자		: pcm
		* - 설명		: 상품 QnA 이미지 등록 [FO]
		* </pre>
		* @return
		*/
	public int insertGoodsQnaImage(GoodsIqrImgPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsQnaImage", po);
	}

	
		/**
		* <pre>
		* - 프로젝트명	: gs-apet-11-business
		* - 파일명		: GoodsInquiryDao.java
		* - 작성일		: 2021. 2. 18.
		* - 작성자		: pcm
		* - 설명		: 상품 문의 수정
		* </pre>
		* @param po
		* @return
		*/
	public int updateGoodsQna(GoodsInquiryPO po) {
		return insert(BASE_DAO_PACKAGE + "updateGoodsQna", po);
	}

	
		/**
		* <pre>
		* - 프로젝트명	: gs-apet-11-business
		* - 파일명		: GoodsInquiryDao.java
		* - 작성일		: 2021. 2. 18.
		* - 작성자		: pcm
		* - 설명		: 상품 문의 이미지 삭제
		* </pre>
		* @param po
		* @return
		*/
	public int deleteGoodsQnaImg(GoodsInquiryPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsQnaImg", po);
	}

	public int getGoodsInquiryListCount(GoodsInquirySO qnaSO) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsInquiryListCount", qnaSO);
	}
}