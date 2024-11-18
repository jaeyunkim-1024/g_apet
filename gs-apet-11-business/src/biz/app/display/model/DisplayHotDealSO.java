package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayHotDealSO extends BaseSearchVO<DisplayHotDealSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 브랜드 번호 */
	private String bndId;
	
	/** 브랜드 한글명 */
	private String bndNmKo;

	/** 상품 번호 */
	private String goodsId;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 이미지 경로 */
	private String imgPath;
	
	/** Hotdeal 시작일 */
	private String saleStrtDtm;
	
	/** Hotdeal 종료일 */
	private Timestamp saleEndDtm;
	
	/** 혜택 적용방식 코드 */
	private String fvrCd;
	
	/** 혜택 값 */
	private Integer fvrVal;
	
	/** 남은시간 (초) */
	private Long remainTime;
	
	/** 판매수량 **/
	private Integer salesQty;
	
	/** 판매 금액 */
	private Long saleAmt;
	
	/** 할인 금액 **/
	private Long dcAmt;
	
	/** 원 판매 금액 */
	private Long orgSaleAmt;
	
	/** 핫딜 정액/정률 구분 */
	private String fvrAplMethCd;
	
	/** WISH 여부 */
	private String interestYn;
	
	/** Site ID */
	private Long stId;
	
	/** 회원번호  */
	private Long mbrNo;
	
	/** 웹모바일 구분  */
	private List<String> webMobileGbCds;
	private String webMobileGbCd;
	
	/** 품절 여부  */
	private String soldOutYn;
	
	/** 베스트 여부  */
	private String bestYn;
	
	/** new 여부  */
	private String newYn;
	
	/** 쿠폰 여부  */
	private String couponYn;
	
	/** 무료배송 여부  */
	private String freeDlvrYn;
	
	/** 사은품 여부  */
	private String freebieYn;
	
	/** new 전시 구좌 번호  */
	private Long dispCornNoNew;
	
	/** 베스트 전시 구좌 번호  */
	private Long dispCornNoBest;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
}