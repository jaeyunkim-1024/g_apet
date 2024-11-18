package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsSO extends BaseSearchVO<GoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 접수 시작 일시 */
	private Timestamp ordAcptDtmStart;

	/** 주문 접수 종료 일시 */
	private Timestamp ordAcptDtmEnd;

	/** DPA 여부 */
	private String dpaYn;

	/** 주문번호 */
	private String ordNo;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 ID */
	private String ordrId;

	/** 상품 명 */
	private String goodsNm;

	/** 상품 아이디 */
	private String goodsId;

	/** 단품 번호 */
	private Integer itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 주문정보 */
	private String searchOrder;

	/** 주문정보값 */
	private String searchOrderValue;

	/** 상품정보 */
	private String searchGoods;

	/** 모바일여부  */
	private String ordMdaCd;

	/** 판매처 */
	private String pageGbCd;

	/** 업체 번호 */
	private Integer compNo;

	/** 업체 번호 */
	private Long compNm;

	/** 업체 상품 번호 */
	private String compGoodsId;

	/** 회원구분 */
	private String memberYn;

	/** 성별구분 */
	private String gdGb;

	/** BOM 코드 */
	private String[] bomCds;
	private String bomCdArea;

	/** BOM 명 */
	private String[] bomNms;
	private String bomNmArea;

	/** 상품정보값 */
	private String searchGoodsValue;

	/** 주문 상태 배열 */
	private String[] arrOrdDtlStatCd;
	
	/** 고시 아이디 */
	private String ntfId;
	
	/** 과세 구분 */
	private String taxGbNm;
	
	/** 배송 정책 번호 */
	private Long dlvrcPlcNo;
}