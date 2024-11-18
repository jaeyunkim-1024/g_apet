package biz.app.company.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyDispTpGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 상품 번호 */
	private String goodsId;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 상품 명 */
	private String goodsNm;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 모델 명 */
	private String mdlNm;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 제조사 */
	private String mmft;

	/** 노출 여부 */
	private String showYn;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 명 영문 */
	private String bndNmEn;

	/** 판매 금액 */
	private Long saleAmt;

	/** 이미지 경로 */
	private String imgPath;
	/** 상품 대표이미지 순번 */
	private Integer imgSeq;
	/** 반전 이미지 경로 */
	private String rvsImgPath;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;
}