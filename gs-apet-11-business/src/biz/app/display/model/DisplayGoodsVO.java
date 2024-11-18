package biz.app.display.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 상품 번호 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 대표 전시 여부 */
	private String dlgtDispYn;

	/** 쇼룸 전시 분류 번호 */
	private String srDispClsfNo;

	/** 쇼룸 전시 명 */
	private String dispClsfNm;

	/** 쇼룸 분류 번호 */
	private String showRoomGb;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 업체명 */
	private String compNm;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 제조사 */
	private String mmft;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 노출여부 */
	private String showYn;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 이미지 경로 **/
	private String imgPath;
	
	/** 반전 이미지 경로 */
	private String rvsImgPath;
	
	/** 이미지 순번 **/
	private Long imgSeq;
	
	/** 판매 금액 */
	private Long saleAmt;
	
	/** 할인 금액 **/
	private Long dcAmt;
	
	/** 판매 수량 상태값 **/
	private String soldOutYn;
	
	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;
	
	/** 홍보 문구 */
	private String prWds;

	/** 신상품 여부 **/
	private String newYn;
	
	/** 베스트 상품 여부 **/
	private String bestYn;

	/** 인기 순위 */
	private Long pplrtRank;

	/** 위시리스트 여부 **/
	private String interestYn;

	/** 추가 */
	/** 전시분류 path */
	private String ctgPath;
}