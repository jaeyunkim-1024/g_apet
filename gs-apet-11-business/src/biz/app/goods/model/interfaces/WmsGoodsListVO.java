package biz.app.goods.model.interfaces;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 51.interface
* - 패키지명		: biz.app.goods.model.interfaces
* - 파일명		: WmsGoodsVO.java
* - 작성일		: 2017. 8. 29.
* - 작성자		: hjkio
* - 설명			: 상품 기본
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WmsGoodsListVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** rownum */
	private Long rowNum;

	/** 업체 번호 */
	private Long compNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 브랜드 번호 */
	private Long brandNo;

	/** 재고 관리 여부 */
	private String stockMngYn;

	/** 판매 시작 일시 */
	private String saleStartDate;

	/** 판매 종료 일시 */
	private String saleEndDate;

	/** 상품 상태 */
	private String goodsStatCd;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 공급가 금액 */
	private Long supplyAmt;

	/** 판매 금액 */
	private Long saleAmt;

	private Long siteId;

	private String goodsStyleCd;

	private Integer categoryNo;

	private String mainDisplayYn;

	private Long itemNo;

	private String itemNm;

	private String barCode;

	private Long attributeNo;

	private String attributeValue;

	/** 사이트 상품 맵 리스트 */
	private List<StGoodsMapVO> siteGoodsMap;

	/** 전시 상품 맵 리스트 */
	private List<DisplayGoodsVO> displayGoodsMap;

	/** 단품 리스트 */
	private List<ItemVO> items;

}
