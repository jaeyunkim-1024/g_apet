package biz.app.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.ApetContentsGoodsMapVO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayHotDealVO;
import biz.app.goods.model.*;
import biz.app.goods.model.interfaces.WmsGoodsListSO;
import biz.app.goods.model.interfaces.WmsGoodsListVO;
import biz.app.member.model.MemberGradeVO;
import biz.app.petlog.model.PetLogGoodsVO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.st.model.StStdInfoVO;
import framework.common.util.image.ImageType;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsService.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
public interface GoodsService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AttributeService.java
	* - 작성일		: 2017. 2. 6.
	* - 작성자		: snw
	* - 설명			: 상품의 속성 및 속성값 목록 조회
	* </pre>
	* @param so
	* @param validItem	단품으로 구성된 속성만 조회할 경우 true
	* @return
	*/
	List<GoodsAttributeVO> listGoodsAttribute(String goodsId, Boolean validItem);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 2. 6.
	* - 작성자		: snw
	* - 설명			: 상품 상세 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsBaseVO getGoodsBase(String goodsId);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2021. 2. 9.
	 * - 작성자		: YJS01
	 * - 설명		: 상품정보 총개수 조회(관련영상, 후기, Q&A)
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	GoodsTotalCountVO getGoodsTotalCount(String goodsId);


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.company.service
	* - 파일명      : CompanyService.java
	* - 작성일      : 2017. 6. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      :상품 배송비정책 일괄 변경
	* </pre>
	 * @param goodsBase
	 * @return
	 */
	int updateGoodsDlvrcPlcNoBatch( GoodsBaseSO goodsBase);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2020. 12. 31.
	* - 작성자 	: valfac
	* - 설명 		: 상품 등록/수정 데이터 GoodsPO로 세팅 
	* </pre>
	*
	* @param goodsBaseStr
	* @param goodsPriceStr
	* @param attributeStr
	* @param itemStr
	* @param goodsNotyfyStr
	* @param goodsCstrtInfoStr
	* @param displayGoodsPOStr
	* @param filtAttrMapPOStr
	* @param goodsIconPOStr
	* @param goodsTagMapPOStr
	* @param goodsImgStr
	* @param goodsCautionStr
	* @param stGoodsMapStr
	* @param goodsDescPO
	* @param optGrpStr
	* @param goodsNaverEpInfoStr
	* @return
	*/
	GoodsPO setDataToGoodsPO(String goodsBaseStr, String goodsPriceStr, String attributeStr, String itemStr, String goodsNotyfyStr, String goodsCstrtInfoStr
			, String displayGoodsPOStr, String filtAttrMapPOStr, String goodsIconPOStr, String goodsTagMapPOStr, String goodsImgStr, String goodsCautionStr, String stGoodsMapStr, GoodsDescPO goodsDescPO, String optGrpStr, String goodsNaverEpInfoStr);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2021. 3. 17.
	* - 작성자 	: valfac
	* - 설명 		: 대표 상품 정보 조회
	* </pre>
	*
	* @param goodsId
	* @param goodsCstrtTpCd
	* @return
	*/
	GoodsBaseVO getDlgtSubGoodsInfo(String goodsId, String goodsCstrtTpCd);









	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//



	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2016. 4. 28.
	* - 작성자	: jangjy
	* - 설명		: 상품 가격 집계 조회
	* </pre>
	* @param goodsId
	* @return
	* @throws Exception
	*/
	GoodsPriceTotalVO getGoodsPriceTotal(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: shkim
	* - 설명		: 배송비 정책 조회
	* </pre>
	* @param dlvrcPlcNo
	* @return
	* @throws Exception
	*/
	DeliveryChargePolicyVO getGoodsDeliveryChargePolicy(Long dlvrcPlcNo, ItemVO item);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: shkim
	* - 설명		: 상품 flag(신상품 여부, 쿠폰적용 여부, 무료배송 여부 등) 노출여부 확인
	* </pre>
	* @param goods
	* @param itemList
	* @throws Exception
	*/
	void checkDispFlag(GoodsBaseVO goods, List<ItemVO> itemList);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: xerowiz@naver.com
	* - 설명		: 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsBaseVO> listGoods(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: wyjeong
	* - 설명		: BEST 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsListVO> pageBestGoods(GoodsListSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: shkim
	* - 설명		: 상품 상세 정보 조회
	* </pre>
	* @param goodsId
	* @return
	* @throws Exception
	*/
	GoodsBaseVO getGoodsDetailFO(GoodsBaseSO mso);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: Administrator
	* - 설명		: 단품 속성 조회
	* </pre>
	* @param attr
	* @return
	*/
	List<AttributeVO> getItemList(AttributePO attr);
	List<AttributeVO> listGoodsItemsAttr(String goodsId, String useYn, String svcGbCd);

	/* 옵션선택 속성 조회
	 * @see biz.app.goods.service.GoodsService#listGoodsItemsAttrSel(biz.app.goods.model.AttributeSO)
	 */
	List<AttributeValueVO> listGoodsItemsAttrSel(AttributePO attr);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: shkim
	* - 설명		: 단품, 배송비, 조립비 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	ItemVO getGoodsItem(ItemSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 17.
	* - 작성자		: shkim
	* - 설명		: 상품상세 - 선택된 옵션으로 단품정보 조회
	* </pre>
	* @param so
	* @return
	*/
	ItemVO checkGoodsOption(ItemSO so);
	List<ItemVO> listGoodsItems(ItemSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 19.
	* - 작성자		: Administrator
	* - 설명		: 상품상세 이미지 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	Map<String, Object> getGoodsImg(String goodsId, String imgTpCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 27.
	* - 작성자		: shkim
	* - 설명		: 상품 사은품 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	List<GoodsBaseVO> listGoodsPromotionFreebie(String goodsId);

	List<GoodsBaseVO> listSubGoods(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 16.
	* - 작성자		: snw
	* - 설명		: 상품의 대표카테고리 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	Long getDlgtDispClsfNo(GoodsBaseSO mso);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 16.
	* - 작성자		: snw
	* - 설명		: 핫딜 상품 - 판매건수, 남은 시간 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	DisplayHotDealVO getHotDealInfo(GoodsBaseSO so);


	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 등록
	* </pre>
	* @return
	*/
	GoodsBaseVO insertGoods (GoodsPO goodsPO, String attributeStr );

	GoodsBaseVO insertGoods (GoodsPO goodsPO, String attributeStr, boolean cisYn );

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsService.java
	 * - 작성일	: 2021. 1. 7.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 기본 정보 등록
	 * </pre>
	 *
	 * @param goodsBasePO
	 * @return
	 */
	GoodsBasePO insertGoodsBase(GoodsBasePO goodsBasePO);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsService.java
	 * - 작성일	: 2021. 1. 7.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 사이트 매핑 등록
	 * </pre>
	 *
	 * @param goodsBasePO
	 * @param goodsPricePO
	 * @param stGoodsListParam
	 */
	void insertStGoodsMap(GoodsBasePO goodsBasePO, GoodsPricePO goodsPricePO, List<StGoodsMapPO> stGoodsListParam );
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 품목 정보 코드 조회
	* </pre>
	* @return
	*/
	List<NotifyInfoVO> listNotifyInfo ();


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 품목 아이템 조회
	* </pre>
	* @param so
	* @return
	*/
	List<NotifyItemVO> listNotifyItem (NotifyItemSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: tigerfive
	* - 설명			: 상품 품목 아이템 조회 (API용)
	* </pre>
	* @param so
	* @return
	*/
	List<biz.app.goods.model.interfaces.NotifyItemVO> listNotifyItemInterface (biz.app.goods.model.interfaces.NotifyItemSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 25.
	* - 작성자		: valueFactory
	* - 설명			: 업체 배송정책 조회 [상품 등록시 사용]
	* </pre>
	* @param compNo
	* @return
	*/
	List<DeliveryChargePolicyVO> listCompDlvrcPlc (Long compNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 25.
	* - 작성자		: valueFactory
	* - 설명			: 업체 수수료 정책 조회 [상품 등록시 사용]
	* </pre>
	* @param compNo
	* @return
	*/
//	CompanyCclVO getCompCcl (Long compNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: valueFactory
	* - 설명			: 상품 리스트 조회
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	List<GoodsBaseVO> pageGoodsBase (GoodsBaseSO goodsBaseSO );
	List getGoodsBaseList (GoodsBaseSO goodsBaseSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 간단 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsBaseVO getGoodsSimpleInfo (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 기본정보 조회 [BO]
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsBaseVO getGoodsDetail (String goodsId );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 전시 카테고리 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	List<DisplayGoodsVO> listGoodsDispCtg (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 상세 설명 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsDescVO getGoodsDescAll (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 상품 구성품 조회
	* </pre>
	* @param goodsCstrtInfoSO
	* @return
	*/
	List<GoodsCstrtInfoVO> listGoodsCstrtInfo (GoodsCstrtInfoSO goodsCstrtInfoSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	List<GoodsImgVO> listGoodsImg (String goodsId );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2016. 5. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 이미지 조회
	 * </pre>
	 * @param goodsImgSO
	 * @return
	 */
	List<GoodsImgVO> listGoodsImg (GoodsImgSO goodsImgSO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 정보 수정 / 등록
	* </pre>
	* @param so
	*/
	void updateGoodsPrice (GoodsPriceSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 10. 10.
	* - 작성자		: hjko
	* - 설명			: 상품 수정
	* </pre>
	* @param goodsPO
	* @return
	*/
	GoodsBaseVO updateGoods (GoodsPO goodsPO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 수정
	* </pre>
	* @param goodsPO
	* @return
	*/
	//String updateGoodsBackup (GoodsPO goodsPO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 13.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 수정
	* </pre>
	* @param po
	* @return
	*/
	int updateGoodsImg (GoodsImgPO po );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 13.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 삭제
	* </pre>
	* @param po
	* @return
	*/
	int deleteGoodsImg (GoodsImgPO po );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 상품 복사
	* </pre>
	* @param goodsPO
	* @return
	*/
	String copyGoods (GoodsBaseSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2021. 3. 2.
	* - 작성자		: valueFactory
	* - 설명			: 후기 복사
	* </pre>
	* @param goodsPO
	* @return
	*/
	int copyGoodsComment (GoodsBaseSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 19.
	* - 작성자		: joeunok
	* - 설명		: 구성 상품 리스트 등록
	* </pre>
	 * @param goodsBasePO
	* @param goodsPO
	* @return
	*/
	String insertGoodsSet(GoodsPO goodsPO);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 19.
	* - 작성자		: joeunok
	* - 설명		: 구성 상품 리스트 수정
	* </pre>
	 * @param goodsBasePO
	* @param goodsPO
	* @return
	*/
	String updateGoodsCstrtInfo(GoodsPO goodsPO);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 5. 27.
	* - 작성자		: joeunok
	* - 설명		: 상품 삭제
	* </pre>
	 * @param goodsBasePO
	* @param goodsPO
	* @return
	*/
	void deleteSetGoods(GoodsPO goodsPO);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		:
	* - 설명		: 상품의 판매종료처리
	* </pre>
	*/
	void updateBatchGoodsSaleEndSoldout();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 상품 가격 배치
	* </pre>
	 * @return 
	*/
	Integer batchGoodsPriceTotal();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 상품 인기순위 배치
	* </pre>
	*/
	void batchGoodsPopularity();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 10.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이력 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	List<GoodsBaseHistVO> listGoodsBaseHist (GoodsBaseHistSO goodsBaseHistSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 17.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 이력 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	List<GoodsPriceVO> listGoodsPriceHistory (String goodsId );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 28.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 조회
	* </pre>
	* @param so
	* @return
	*/
	GoodsImgVO getGoodsImage (GoodsImgSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 통계 배치
	* </pre>
	* @param po
	* @return
	*/
	int insertDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 6. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 통계 순위 수정
	* </pre>
	* @param po
	* @return
	*/
	int updateDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 7. 22.
	* - 작성자		: yhkim
	* - 설명		: 상품 위시리스트 여부 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsBaseVO getInterestYn(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2016. 7. 27.
	* - 작성자	: jangjy
	* - 설명		: 조립설명서 목록
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	List<GoodsBaseVO> pageAssembleList (GoodsBaseSO goodsBaseSO );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 상품 조회 수 증가
	* </pre>
	* @param goodsId
	*/
	void updateGoodsHits(String goodsId);

	int getWebStkQty(ItemPO itemPO);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 8. 16.
	* - 작성자		: hjko
	* - 설명		: 구성상품상세 메인이미지 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	GoodsImgVO getGoodsMainImg(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9 07.
	* - 작성자		: hjko
	* - 설명			: 세일중인 상품 리스트 조회
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	List<GoodsBaseVO> pageSaleGoodsBase (GoodsBaseSO goodsBaseSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  다음 상품 가격 조회
	* </pre>
	* @param GoodsPriceSO
	* @return
	*/
	List<GoodsPriceVO> getNextPrice (GoodsPriceSO gpso);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  세일 상품 가격  수정
	* </pre>
	* @param List<GoodsPricePO>
	* @return
	*/
	int updateSalePeriod(List<GoodsPricePO> poList);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  세일 상품 가격 적용종료일시 수정
	* </pre>
	* @param List<GoodsPricePO>
	* @return
	*/
	int updateSalePriceEndDtm(GoodsPricePO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			:  상품 가격 적용시작일시 수정
	* </pre>
	* @param poList
	* @return
	*/
	int updateNextSalePriceStrtDtm(GoodsPricePO po);


	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 6.
	* - 작성자		: hjko
	* - 설명		: 사이트 상품 매핑테이블에 있는 사이트 목록 조회
	* </pre>
	* @param so
	* @return
	 */
	//List<StGoodsMapVO> listStStdInfoGoods(StGoodsMapSO so );
	List<StGoodsMapVO> listStStdInfoGoods(StGoodsMapSO so );

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 10.
	* - 작성자		: hjko
	* - 설명		: 사이트상품매핑테이블에서 해당 상품을 조회하여 삭제
	* </pre>
	* @param k
	 */
	Integer deleteStGoodsMap(StGoodsMapSO so);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 1. 18.
	* - 작성자		: hjko
	* - 설명		: 상품상세에서 업체에 해당하는 전시카테고리 조회
	* </pre>
	* @param so
	* @return
	 */
	List<DisplayCategoryVO> listCompDispMapGoods(GoodsBaseSO so);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param compNo
	* @return
	 */
	List<CompanyBrandVO> listCompanyBrand(Long compNo);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param stId
	* @return
	 */
	List<StGoodsMapVO>listStGoodsStyle(StGoodsMapSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: les
	* - 설명		: 상품 적립금율 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	Long getStStdAvmnRateById(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: les
	* - 설명		: 연관 상품 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsBaseVO> listCstrtGoods(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2017. 2. 01.
	* - 작성자		: les
	* - 설명			: 상품과 관련된 다운로드 가능 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	List<CouponBaseVO> listDownCoupon (GoodsBaseSO so );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 3. 22.
	* - 작성자		: hg.jeong
	* - 설명		: 상세검색용 파라메터 세팅
	* </pre>
	* @param so
	* @return
	*/
	void setDetailSearchParam(GoodsBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2017. 5. 8.
	* - 작성자		: hongjun
	* - 설명			: 단품번호 별 속성 조회
	* </pre>
	* @param itemNo
	* @return
	*/
	List<ItemAttributeValueVO> getItemAttrValueList(Long itemNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 4. 25.
	* - 작성자		: valueFactory
	* - 설명			: 이미지 리사이징..
	* </pre>
	* @param imgPath
	* @return
	*/
	boolean goodsImgResize (String imgPath );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 등록
	* </pre>
	* @param po
	* @return
	*/
	int insertGoodsImg (GoodsImgPO po );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	int insertGoodsImgChgHist (GoodsImgChgHistPO po );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsServiceImpl.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 프로모션 적용가격 조회
	* </pre>
	* @param po
	* @return
	*/
	List<GoodsPriceVO> getGoodsPromotionPrice(GoodsBaseSO so);


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.goods.service
	* - 파일명      : GoodsService.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :StGoodsMap 수정
	* </pre>
	 */
	int updateStGoodsMap (List<StGoodsMapPO> stGoodsMapPOList );


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsListVO> pageGoodsFO(GoodsListSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: 상품 목록 조회 - 비정형 전시코너 번호 기준
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsListVO> pageGoodsByDispClsfCornNo(GoodsListSO so);


	List<StStdInfoVO> listCompCmsRate(StGoodsMapSO so );


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 셀러, 스토어, 디자이너 상단 BEST 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsListVO> listBestGoodsByComp(GoodsListSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 08. 25.
	 * - 작성자		: hjko
	 * - 설명		:  interface 상품 목록 조회(wms용)
	 * </pre>
	 * @param so
	 * @return
	 */
	List<WmsGoodsListVO> pageGoodsListInterface(WmsGoodsListSO so);


	int getGoodsListInterfacetotalCount(WmsGoodsListSO so);
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.company.service
	* - 파일명      : CompanyService.java
	* - 작성일		: 2017. 8. 21.
	* - 작성자      : hongjun
	* - 설명      : 공동구매  수정
	* </pre>
	 * @param po
	 * @return
	 */
	Integer updateGoodsPrice(StGoodsMapPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	List<GoodsBaseVO> pageGoodsBaseBO(GoodsBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
     * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사은품 수정
	 * </pre>
	 * @return
	 */
	String updateGiftGoods(GoodsPO goodsPO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 이미지 업로드
	 * </pre>
	 * @param goodsId
	 * @param imgSeq
	 * @param imgType
	 * @param imgPath
	 * @param rvsYn
	 * @return
	 */
	String goodsImgUpload(String goodsId, Integer imgSeq, ImageType imgType, String imgPath, boolean rvsYn);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2021. 2. 8.
	* - 작성자 	: valfac
	* - 설명 		: 상품 콘텐츠 매핑 리스트
	* </pre>
	*
	* @param so
	* @return
	*/
	List<ApetContentsGoodsMapVO> listApetContentsGoodsMap(ApetContentsGoodsMapSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsService.java
	* - 작성일	: 2021. 2. 9.
	* - 작성자 	: valfac
	* - 설명 		: 상품 수정 가능 카운트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	GoodsBaseVO checkPossibleCnt(String goodsId);

	MemberGradeVO getMemberGradeInfo(Long mbrNo);
	
	List<GoodsBaseVO> getGoodsRelatedWithTv(GoodsRelatedSO so) throws Exception;
	List<GoodsBaseVO> getGoodsRelatedWithPetLog(GoodsRelatedSO so) throws Exception;
	List<GoodsBaseVO> getGoodsRelatedWithSearch(GoodsRelatedSO so) throws Exception;
	List<GoodsBaseVO> getGoodsRelatedInGoods(GoodsRelatedSO so) throws Exception;

	int getGoodsRelatedWithTvCount(GoodsRelatedSO so) throws Exception;
	int getGoodsRelatedWithPetLogCount(GoodsRelatedSO so) throws Exception;

	GoodsImgVO getGoodsRelatedWithTvThumb(GoodsRelatedSO so) throws Exception;
	GoodsImgVO getGoodsRelatedWithPetLogThumb(GoodsRelatedSO so) throws Exception;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsService.java
	 * - 작성일	: 2021. 3. 4.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 팝업 카테고리 선택
	 * </pre>
	 *
	 * @param dispClsfNo
	 * @return HashMap
	 */
	HashMap getGoodsDisplayCategory(long dispClsfNo);


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsService.java
	 * - 작성일	: 2021. 3. 10.
	 * - 작성자 	: cyhvf01
	 * - 설명 		: 상품 연관율 구하기
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	double getGoodsRecommendRate(GoodsRelatedSO so) throws Exception;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsService.java
	* - 작성일		: 2021. 3. 15.
	* - 작성자		: pcm
	* - 설명		: 상품 상세 텝 메뉴 카운트
	* </pre>
	* @param goodsBaseVO
	* @return
	*/
	GoodsTotalCountVO getGoodsTotalCount(GoodsBaseVO goodsBaseVO);

	List<GoodsBaseVO> getSgrGoodsList(GoodsBaseSO so);
	
	void petLogCmtDelete(PetLogGoodsVO vo);
}