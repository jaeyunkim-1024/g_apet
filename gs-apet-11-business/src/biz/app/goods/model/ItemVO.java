package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 웹 재고 수량 */
	private Integer webStkQty;

	/** 실 웹 재고 수량 */
	private Integer realWebStkQty;

	/** 판매 여부 */
	private String saleYn;

	/** 추가 판매 금액 */
	private Long addSaleAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 상태 코드 */
	private String itemStatCd;

	/** 노출 순서 */
	private Long showSeq;

	/** 업체 단품 아이디 */
	private String compItemId;
	
	/** 사은품 가능 여부 */
	private String frbPsbYn;

	/** 주문 제작 여부 */
	private String ordmkiYn;



	/** 추가분 */
	private String goodsNm;
	private String goodsStatCd;
	private String mdlNm;
	private Long compNo;
	private String compNm;
	private Long bndNo;
	private String bndNmKo;

	private String mmft;
	private Timestamp saleStrtDtm;
	private Timestamp saleEndDtm;
	private String showYn;
	private String goodsTpCd;
	private String bigo;
	private String cstrtGoodsId;
	private String imgPath;
	private Long saleAmt;

	private Long attr1No;
	private String attr1Nm;
	private Long attr1ValNo;
	private String attr1Val;
	private Long attr2No;
	private String attr2Nm;
	private Long attr2ValNo;
	private String attr2Val;
	private Long attr3No;
	private String attr3Nm;
	private Long attr3ValNo;
	private String attr3Val;
	private Long attr4No;
	private String attr4Nm;
	private Long attr4ValNo;
	private String attr4Val;
	private Long attr5No;
	private String attr5Nm;
	private Long attr5ValNo;
	private String attr5Val;

	private Long itemListId;

	private String attrValJson;


	/** 지방 배송 여부 */
	private String prvcDlvrYn;

	/** 배송 금액 */
	private Long dlvrAmt;

	/** 반품 배송비 */
	private Long rtnDlvrc;

	/** 교환 배송비 */
	private Long excDlvrc;

	/** 배송비 안내 */
	private String dlvrAmtNm;

	/** 속성값 목록 interface 사용. 2017.06.27 추가*/
	private List<ItemAttributeValueVO> itemAttributeValueVO;

}