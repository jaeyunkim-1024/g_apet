package biz.app.goods.model;

import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.Size;

import lombok.Data;
import org.hibernate.validator.constraints.NotEmpty;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GoodsCisPO {

	/** UID */
	private static final long serialVersionUID = 1L;
	/** API KEY */
	@NotEmpty // null, 빈 문자열(스페이스 포함X) 불가
	private String apiKey;
	/** 단품 코드 */
	@NotEmpty
	private String skuCd;
	/** 단품 명 */
	@NotEmpty
	@Size(min = 1, max = 200)
	private String skuNm;
	/** 단위 */
	@NotEmpty
	private String unitNm;
	/** 취급 상태 코드 */
	@NotEmpty
	private String trtmTpCd;
	/** 규격 */
	private String spcfNm;
	/** 발주 상태 코드 */
	@NotEmpty
	private String ordrStatCd;
	/** 매입사 코드 */
	@NotEmpty
	private String vndrCd;
	/** 화주 코드 */
	@NotEmpty
	private String ownrCd;
	/** 물류센터 코드 */
	@NotEmpty
	private String wareCd;
	/** 제조사 */
	@NotEmpty
	private String mnftNm;
	/** 원산지 */
	@NotEmpty
	private String orgnNm;
	/** 브랜드 */
	private String brndNm;
	/** 모델 */
	private String modlNm;

	/** 정보고시 분류코드 */
	@NotEmpty
	private String ntfcCd;

	/** 표준 코드 */
	private String strdCd;
	/** 상태 코드 */
	private String statCd;
	/** 대분류 코드 */
	private String cateCdL;
	/** 대분류 명 */
	private String cateNmL;
	/** 중분류 코드 */
	private String cateCdM;
	/** 중분류 명 */
	private String cateNmM;
	/** 판매가격 */
	private int price;
	/** 정상가격 */
	private int consumerPrice;
	/** 공급가격 */
	private int supplyPrice;
	/** 배송비 유형 */
	private String dlvChrgTpCd;
	/** 배송비 */
	private int dlvChrg;
	/** 과세 유형코드 */
	private String taxTpCd;
	/** 이미지 경로 */
	private String imgSrc;
	/** 상세 내용 */
	private String dtlTxt;


	/** 정보고시 분류 번호 리스트 */
	@NotEmpty
	private List<Ntfc> ntfcList;
	/** 옵션 번호 리스트 */
//	private List<Attrs> attrs;

	/* 속성값 필드 정의 */
	@Getter
	@Builder
	@AllArgsConstructor(access = AccessLevel.PROTECTED)
	static class Ntfc {
		@NotEmpty
		private Long ntfcNo = 0L;	/** 정보고시 번호 */
		@NotEmpty
		private String ntfcTxt;	/** 정보고시 내용 */
		protected Ntfc() {}
	}

	/* 정보고시 번호 필드 정의 */
	@Getter
	@Builder
	@AllArgsConstructor(access = AccessLevel.PROTECTED)
	static class Attrs {
		private Long attrNo = 0L;	/** 옵션번호 */
		private String attrNm;	/** 옵션명 */
		private String attrVal;	/** 옵션값 */
		protected Attrs() {}
	}

	@Getter
	@NoArgsConstructor(access = AccessLevel.PROTECTED)
	public static class FieldErrorInfo {
		private String field;
		private String value;
		private String reason;

		@Builder
		public FieldErrorInfo(String field, String value, String reason) {
			this.field = field;
			this.value = value;
			this.reason = reason;
		}
	}

	public GoodsCisPO sample(){
		List<Ntfc> ntfcList = new ArrayList<>();
		ntfcList.add(Ntfc.builder().ntfcNo(Long.parseLong("3503")).ntfcTxt("대한민국").build());
		List<Attrs> attrList = new ArrayList<>();
		attrList.add(Attrs.builder().attrNo(Long.parseLong("1")).attrNm("재료").attrVal("닭고기").build());

		GoodsCisPO po = new GoodsCisPO();
		po.setApiKey("2b908ba7970e7526d11bb8123a72f0f9");
		po.setSkuCd("13452");
		po.setSkuNm("네츄럴코어 에코10 유기농 독 베지테리언 95%");
		po.setTrtmTpCd("001");
		po.setUnitNm("EA");
		po.setSpcfNm("100 * 100");
		po.setOrdrStatCd("001");
		po.setVndrCd("VD000001");
		po.setOwnrCd("PB");
		po.setWareCd("WH01");
		po.setMnftNm("(주)펫츠비");
		po.setOrgnNm("대한민국");
		po.setBrndNm("네츄럴코어");
		po.setModlNm("네츄럴코어");
		po.setNtfcCd("i35");

		po.setStrdCd("13452");
		po.setStatCd("001");			// 상태 코드
		po.setCateCdL("000100010001");	// 대분류 코드
		po.setCateCdM("00010001");		// 중분류 코드
		po.setCateNmL("강아지");			// 대분류명
		po.setCateNmM("사료");			// 중분류명
		po.setPrice(18000);				// 판매 가격
		po.setConsumerPrice(20000);		// 정상 가격
		po.setSupplyPrice(10000);		// 공급 가격
		po.setDlvChrgTpCd("004");		// 배송비 유형
		po.setDlvChrg(3000);			// 배송비
		po.setTaxTpCd("001");			// 과세 유형코드
		po.setImgSrc("http://www.petsbe.com/data/goods/20/07/31/2502230/2774_detail_070.jpg");
		po.setDtlTxt("<img src=\"http://petsbe1.godohosting.com/img/product/100065_01.jpg\" alt=\"상품 상세 설명\" />");
		po.setNtfcList(ntfcList);
//		po.setAttrs(attrList);
		return po;
	}
}