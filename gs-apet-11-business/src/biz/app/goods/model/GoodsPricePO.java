package biz.app.goods.model;

import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import framework.admin.jsonparser.CustomTimestampDeserializer;
import framework.admin.jsonparser.CustomTimestampSerializer;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsPricePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 가격 번호 */
	private Long goodsPrcNo;

	/** 원가 금액 */
	private Long costAmt;

	private String goodsAmtTpCd;

	private Long orgSaleAmt;

	/** 판매 금액 */
	private Long saleAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 구성 유형 - ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음 */
	private String goodsCstrtTpCd;

	/** 유통기한일자 */
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date expDt = null;

	/** 예약구매수량 */
	private Integer rsvBuyQty;

	/** 판매 시작 일시 */
	@JsonSerialize(using = CustomTimestampSerializer.class)
	@JsonDeserialize(using = CustomTimestampDeserializer.class)
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	@JsonSerialize(using = CustomTimestampSerializer.class)
	@JsonDeserialize(using = CustomTimestampDeserializer.class)
	private Timestamp saleEndDtm;

	/** 수수료 율 */
	private Double cmsRate;

	/** 혜택 적용 방식 코드 */
	private String fvrAplMethCd;

	/** 혜택 값 */
	private Double fvrVal;

	private Timestamp sysDatetime;

	private String[] goodsIds;

	/** 삭제여부 */
	private String delYn;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** valid 체크 여부 */
	private boolean isValidCheck;

	/** CIS 전송 여부 */
	private String cisYn;
	
	/** CIS 번호 */
	private Integer cisNo;
}