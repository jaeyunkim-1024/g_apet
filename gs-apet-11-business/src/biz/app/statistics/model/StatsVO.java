package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Integer saleSumSeq; 			// 합계번호
	private Timestamp ordCpltDtm;			// 주문 완료 일시
	private String sumYear; 				// 집계연도 - 결제 완료일 기준
	private String sumMonth; 				// 집계 월 - 결제 완료일 기준
	private String sumWeek; 				// 집계 주 - 결제 완료일 기준
	private String sumDay; 					// 집계 일 - 결제 완료일 기준
	private String goodsId; 				// 상품 아이디
	private String goodsNm; 				// 상품명
	private String goodsBomCd; 				// BomCd
	private String goodsBomNm;
	private Integer itemNo; 				// 단품번호
	private String itemNm; 					// 단품명
	private String itemBomCd; 				// BomCd
	private String itemBomNm;
	private Integer bndNo; 					// 브랜드번호
	private String bndNm;
	private Integer seriesNo; 				// 시리즈번호
	private String seriesNm;
	private String pageGbCd; 				// 판매공간
	private String pageGbCdDtl1; 			// 01:A 02:B :03외부몰 04:쇼룸 05:마켓
	private String ordMdaCd; 				// 주문매체 - 01:Pc 02:Mobile
	private String ordMdaCdDtl1;			// 주문매체 상세 01:Pc 02: Mobile 03:Showroom 04:Market
	private Integer dispClsfNoDepth1; 		// 대분류
	private String dispClsfNmDepth1;
	private Integer dispClsfNoDepth2; 		// 중분류
	private String dispClsfNmDepth2;
	private Integer dispClsfNoDepth3; 		// 소분류
	private String dispClsfNmDepth3;
	private Integer dispClsfNoDepth4;		// 세분류
	private String dispClsfNmDepth4;
	private Integer ordQty; 				// 주문수량
	private Long saleAmt; 					// 판매금액
	private Long payAmt; 					// 결제금액
	private Long splAmt; 					// 공급금액
	private Long cms; 						// 수수료
	private Long costTot; 					// 원가합계
	private Long netProfitAmt; 				// 순이익금액
	private Long netProfitRate; 			// 순이익율
	private Integer compNo; 				// 업체번호
	private String compNm; 					// 업체명
	private String compTpCd; 				// 업체 유형 - 자사 입점 판매대행
	private String memberYn; 				// 회원여부
	private String orderArea; 				// 주문지역 - 서울부산대구인천광주대전울산세종경기강원충북충남전북전남경북경남제주기타
}