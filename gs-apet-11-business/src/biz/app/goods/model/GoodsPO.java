package biz.app.goods.model;

import java.io.Serializable;
import java.util.List;

import biz.app.attribute.model.AttributeSO;
import biz.app.display.model.DisplayGoodsPO;
import lombok.Data;

@Data
public class GoodsPO implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/** 상품 기본 정보 */
	private GoodsBasePO goodsBasePO;

	/** 상품 가격 정보 */
	private GoodsPricePO goodsPricePO;
	
	/** 상품 가격 정보 */
	private GoodsNaverEpInfoPO goodsNaverEpInfoPO;

	/** 상품 단품 옵션 정보 */
	private List<AttributeSO> attributeSOList;
	
	/** 단품 정보 */
	private List<ItemSO> itemSOList;
	
	/** 상품 세트 구성 정보 */
	private List<GoodsCstrtSetPO> goodsCstrtSetPOList;
	
	/** 상품 옵션 구성 정보 */
	private List<GoodsOptGrpPO> goodsOptGrpPOList;
	
	/** 상품 묶음 구성 정보 */
	private List<GoodsCstrtPakPO> goodsCstrtPakPOList;

	/** 공정위 품목군 */
	private List<GoodsNotifyPO> goodsNotifyPOList;

	/** 상품 구성품 */
	private List<GoodsCstrtInfoPO> goodsCstrtInfoPOList;

	/** 전시상품 */
	private List<DisplayGoodsPO> displayGoodsPOList;
	
	/** 필터 속성 매핑 리스트 */
	private List<FiltAttrMapPO> filtAttrMapPOList;
	
	/** 상품 아이콘 리스트 */
	private List<GoodsIconPO> goodsIconPOList;

	/** 상품 태그 리스트 */
	private List<GoodsTagMapPO> goodsTagMapPOList;

	/** 상품 이미지 */
	private List<GoodsImgPO> goodsImgPOList;

	/** 상품 상세설명 */
	private List<GoodsDescPO> goodsDescPOList;

	/** 상품Q&A */
	private List<GoodsInquiryPO> goodsInquiryPOList;

	/** 상품 주의사항 */
	private GoodsCautionPO goodsCautionPO;

	/** 상품 매핑 사이트 목록 */
	private List<StGoodsMapPO> stGoodsMapPOList;
	
	/** 단품 속성 삭제 대상 목록 */
	private List<AttributeSO> orgAttrDelete;
	
	/** 단품 삭제 대상 목록 */
	private List<ItemSO> orgItemDelete;
}
