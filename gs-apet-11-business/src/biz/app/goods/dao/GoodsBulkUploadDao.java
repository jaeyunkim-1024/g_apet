package biz.app.goods.dao;

import java.util.HashMap;
import java.util.List;

import biz.app.st.model.StStdInfoVO;
import org.springframework.stereotype.Repository;

import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsBulkUploadPO;
import biz.app.goods.model.GoodsBulkUploadSO;
import biz.app.goods.model.GoodsImgPrcsListPO;
import biz.app.goods.model.GoodsImgPrcsListVO;
import biz.app.goods.model.NotifyItemVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsBulkUploadDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsBulkUpload.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StDao.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 사이트 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public StStdInfoVO getStStdInfo (GoodsBulkUploadPO po) {
		return (StStdInfoVO)selectOne(BASE_DAO_PACKAGE + "selectStStdInfo", po );
	}

	/**
	 * <pre> 사이트 업체 매핑 리스트
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StDao.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 사이트명 조회
	 * @param COMP_NM
	 * @return
	 */
	public List<StStdInfoVO> getStStdInfoByCompNm(GoodsBulkUploadPO po) {
		return selectList(BASE_DAO_PACKAGE + "selectStStdInfoByNm", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 상품 업체 번호 검사
	* </pre>
	* @param compNo
	* @return
	*/
	public int checkGoodsCompNo (Long compNo ) {
		return (Integer)selectOne("goodsBulkUpload.checkGoodsCompNo", compNo );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 업체명 검사
	 * </pre>
	 * @param compNo
	 * @return
	 */
	public int checkGoodsCompNm (String compNm ) {
		return (Integer)selectOne("goodsBulkUpload.checkGoodsCompNm", compNm );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 업체 상품번호 검사
	* </pre>
	* @param compGoodsId
	* @return
	*/

	public String checkCompGoodsId (GoodsBulkUploadPO po ) {
		return (String)selectOne("goodsBulkUpload.checkCompGoodsId", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 번호 검사
	* </pre>
	* @param so
	* @return
	*/
	public int checkBndNo (GoodsBulkUploadPO po ) {
		return (Integer)selectOne("goodsBulkUpload.checkBndNo", po );
	}
	public Long checkBndNm (GoodsBulkUploadPO po ) {
		return (Long)selectOne("goodsBulkUpload.checkBndNm", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 과세 구분명 검사
	 * </pre>
	 * @param so
	 * @return
	 */
	public int checkTaxGbNm(GoodsBulkUploadPO po) {
		return (Integer) selectOne("goodsBulkUpload.checkTaxGbNm", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 업체 배송정책 번호 검사
	* </pre>
	* @param so
	* @return
	*/
	public int checkDlvrcPlcNo (DeliveryChargePolicyPO so ) {
		return (Integer)selectOne("goodsBulkUpload.checkDlvrcPlcNo", so );
	}





	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 고시 정보 조회
	* </pre>
	* @param ntfId
	* @return
	*/
	public List<NotifyItemVO> checkNtfId (String ntfId ) {
		return selectList("goodsBulkUpload.checkNtfId", ntfId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 24.
	* - 작성자		: valueFactory
	* - 설명			: 상품정보 일괄 수정
	* </pre>
	* @param goodsBulkUploadPO
	* @return
	*/
	public int updateBulkGoods (GoodsBulkUploadPO goodsBulkUploadPO ) {
		return update("goodsBulkUpload.updateBulkGoods", goodsBulkUploadPO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 25.
	* - 작성자		: valueFactory
	* - 설명			: 공정위 품목군 입력항목 조회
	* </pre>
	* @return
	*/
	public List<NotifyItemVO> listNotifyItem (GoodsBulkUploadSO so ) {
		return selectList("goodsBulkUpload.listNotifyItem", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 25.
	* - 작성자		: valueFactory
	* - 설명			: 상품 번호 체크
	* </pre>
	* @param goodsId
	* @return
	*/
	public int checkGoodsId (String goodsId ) {
		return (Integer)selectOne("goodsBulkUpload.checkGoodsId", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 25.
	* - 작성자		: valueFactory
	* - 설명			: 공정위 품목군 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateBulkNtfId (GoodsBulkUploadPO po ) {
		return update("goodsBulkUpload.updateBulkNtfId", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 26.
	* - 작성자		: valueFactory
	* - 설명			: 상품 재고 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO checkGoodsBase (String goodsId ) {
		return (GoodsBaseVO)selectOne("goodsBulkUpload.checkGoodsBase", goodsId );
	}



	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2016. 5. 26.
	* - 작성자		: valueFactory
	* - 설명			: 단품 재고 정보 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateBulkStock (GoodsBulkUploadPO po ) {
		return update("goodsBulkUpload.updateBulkStock", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: honjun
	* - 설명			: 상품 이미지 처리 내역 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsImgPrcsList (GoodsBulkUploadPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsImgPrcsList", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: honjun
	* - 설명			: 상품 이미지 처리 내역 조회
	* </pre>
	* @return
	*/
	public List<GoodsImgPrcsListVO> getGoodsImgPrcsList () {
		return selectList(BASE_DAO_PACKAGE + "getGoodsImgPrcsList");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadDao.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: honjun
	* - 설명			: 상품 이미지 처리 내역 수정
	* </pre>
	* @return
	*/
	public int updateGoodsImgPrcsList(GoodsImgPrcsListPO po) {
		return update(BASE_DAO_PACKAGE + "updateGoodsImgPrcsList", po);
	}

	public Long getAttributeByNm(String attrNm) {
		return selectOne(BASE_DAO_PACKAGE + "selectAttributeByNm", attrNm);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 3. 4.
	 * - 작성자		: valfac
	 * - 설명		: 상품 카테고리 검사
	 * </pre>
	 * @param compNo
	 * @return
	 */
	public HashMap checkGoodsDisplayByNm (int dispLvl, Long upDispClsfNo, String dispClsfNm) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("dispLvl", dispLvl);
		params.put("upDispClsfNo", upDispClsfNo);
		params.put("dispClsfNm", dispClsfNm);
		return (HashMap)selectOne("goodsBulkUpload.checkGoodsDisplayByNm", params );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 8. 3.
	 * - 작성자		: valfac
	 * - 설명		:  매입업체명 검사
	 * </pre>
	 * @param phsCompNm
	 * @return
	 */
	
	public int checkGoodsPhsCompNm(String phsCompNm) {
		return (Integer)selectOne("goodsBulkUpload.checkGoodsPhsCompNm", phsCompNm );
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 8. 3.
	 * - 작성자		: valfac
	 * - 설명		:  업체타입코드 검사
	 * </pre>
	 * @param compNo
	 * @return
	 */
	public int  checkGoodsCompTpCd(long compNo) {
		
		return(Integer)selectOne("goodsBulkUpload.checkGoodsCompTpCd",compNo);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadDao.java
	 * - 작성일		: 2021. 8. 3.
	 * - 작성자		: valfac
	 * - 설명		:  매입업체코드 조회
	 * </pre>
	 * @param phsCompNm
	 * @return
	 */
	public long getGoodsPhsCompNo(String phsCompNm) {
		
		return (Long)selectOne("goodsBulkUpload.getGoodsPhsCompNo",phsCompNm);
	}
}
