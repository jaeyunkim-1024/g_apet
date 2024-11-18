package biz.app.statistics.model;


import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderBestGoodsReportVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	private Long rank;
	/**	집계 일자Yyyymmdd	*/
	private String totalDt;  
	/**	사이트 id	*/
	private Long   stId;  
	/**	상품 아이디	*/
	private String goodsId;  
	/**	주문 수량	*/
	private Long   ordQty;  
	/**	주문 금액	*/
	private Long   ordAmt;  
	/**	취소 수량	*/
	private Long   cncQty;  
	/**	취소 금액	*/
	private Long   cncAmt;  
	/**	반품 수량	*/
	private Long   rtnQty;  
	/**	반품 금액	*/
	private Long   rtnAmt;  
	/**	집계 점수	*/
	private Long   totalScr;  
	 /**  상품 명             */
	private String goodsNm;  
	/**  업체 번호           */
	private Long   compNo;  
	/**  브랜드 번호         */
	private Long   bndNo;  
	/**  브랜드 명 국문      */
	private String bndNmKo;  
	/**  업체 명             */
	private String compNm;  
	/** 주문 매체 코드 */
	private String ordMdaCd	;

	/** 주문 금액 - 취소 금액 - 반품 금액 */
  	private long totAmt;
}