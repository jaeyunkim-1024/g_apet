package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCisVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 호출 아이디 */
	private String callId;
	/** 결과 코드 */
	private String resCd;
	/** 결과 메시지 */
	private String resMsg;
	/** 단품 번호 */
	private Long skuNo;
	/** 단품코드(상점별 고유상품코드) */
	private String skuCd;
	/** 단품명 */
	private String skuNm;
	/** 상태코드(판매중, 중지, 품절, 종료) */
	private String statCd;
	/** 취급상태 코드 */
	private String trtmTpCd;
	/** 단위 */
	private String unitNm;
	/** 규격(100*100) */
	private String spcfNm;
	/** 발주 상태 코드 */
	private String ordrStatCd;
	/** 메입사 코드 */
	private String vndrCd;
	/** 화주 코드(PB) */
	private String ownrCd;
	/** 물류센터 코드 */
	private String wareCd;
	/** 제조사(펫츠비) */
	private String mnftNm;
	/** 원산지 */
	private String orgnNm;
	/** 브랜드 */
	private String brndNm;
	/** 모델 */
	private String modlNm;
	/** 정보고시 분류 코드 */
	private String ntfcCd;
	/** 정보고시 분류 리스트 */
	private List<Ntfc> ntfcList;
	/** 옵션 리스트 */
	private List<Attrs> attrs;
	/** 재고(int) */
	private String stock;
	/** 재고 가용(int) */
	private String stockAbl;
	/** 재고 불량(int) */
	private String stockBlk;
	/** 유통기한(YMD) */
	private String expDdYmd;

	/* 속성값 필드 정의 */
	@Getter @Setter
	@Builder
	@AllArgsConstructor(access = AccessLevel.PROTECTED)
	static class Ntfc {
		private Long ntfcNo;
		private String ntfcTxt;
		protected Ntfc() {}
	}

	/* 정보고시 번호 필드 정의 */
	@Getter @Setter
	@Builder
	@AllArgsConstructor(access = AccessLevel.PROTECTED)
	static class Attrs {
		private Long attrNo;
		private String attrNm;
		private String attrVal;
		protected Attrs() {}
	}

	/* 단품 상품 CIS Response 데이터 정의. */
	@Getter @Setter
	@Builder
	@AllArgsConstructor(access = AccessLevel.PROTECTED)
	public static class GoodsCisRes {
		/** 단품 번호 */
		private Long skuNo;
		/** 단품코드(상점별 고유상품코드) */
		private String skuCd;
		/** 호출 아이디 */
		private String callId;
		/** 결과 코드 */
		private String resCd;
		/** 결과 메시지 */
		private String resMsg;
		protected GoodsCisRes() {}
	}
}