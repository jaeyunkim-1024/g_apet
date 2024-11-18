package biz.app.display.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGroupBuyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 상품 번호 */
	private String goodsId;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 이미지 경로 */
	private String imgPath;
	
	/** 상품 대표이미지 순번 */
	private Integer imgSeq;
	
	/** 초기 구매 수량 */
	private Long strtOrdQty;
	
	/** 목표 수량 */
	private Long trgtQty;
	
	/** 최소 구매 수량 */
	private Long minOrdQty;
	
	/* 공동구매 종료 여부 */
	private String groupEndYn;
	
	/** 공동구매 시작일 */
	private String saleStrtDtm;
	
	/** 공동구매 종료일 */
	private Timestamp saleEndDtm;
	
	/** 남은시간 (초) */
	private Long remainTime;
	
	/** 판매수량 **/
	private Integer salesQty;
	
	/** 원 판매 금액 (공동구매 시작가) */
	private Long orgSaleAmt;
	
	/** 할인 적용된 최종 판매가 */
	private Long saleAmt;
	
	/** WISH 여부 */
	private String interestYn;
}