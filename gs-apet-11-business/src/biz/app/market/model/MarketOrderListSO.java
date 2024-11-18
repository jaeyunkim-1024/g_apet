package biz.app.market.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.market.model
* - 파일명		: MarketOrderListSO.java
* - 작성일		: 2017. 9. 21.
* - 작성자		: kimdp
* - 설명			: 오픈마켓 주문 목록 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MarketOrderListSO extends BaseSearchVO<MarketOrderListSO> {
	
	/** 회원 번호 */
	private Long mbrNo;	
	
	/** 주문자 명 */
	private String ordNm;
	
	/** 주문 번호 */
	private String ordNo;	
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 오픈마켓 주문 수집 일시 : Start */
	private Timestamp marketOrdDtmStart;

	/** 오픈마켓 주문 수집 일시 : End */
	private Timestamp marketOrdDtmEnd;	
	
	/** 검색 조건 : 오픈마켓 수집 마켓명 */
	private String marketCollectNm;
	
	/** 검색 조건 : 오픈마켓 수집 마켓별 셀러아이디 */
	private String marketCollectSellerId;	
	
	/** 검색 조건 : 오픈마켓 주문 검색 일시타입 */
	private String searchDtmType;	
	
	/** 오픈마켓 주문 검색 일시 : Start */
	private Timestamp ordAcptDtmStart;

	/** 오픈마켓 주문 검색 일시 : End */
	private Timestamp ordAcptDtmEnd;
	
	/** 검색 조건 : 오픈마켓 검색 마켓명 */
	private String searchMarketNm;
	
	/** 검색 조건 : 오픈마켓 검색 마켓별 셀러아이디 */
	private String searchMarketSellerId;	
	
	/** 검색 조건 : 주문정보 */
	private String searchKeyOrder;

	/** 검색 값 : 주문정보 */
	private String searchValueOrder;
	
	/** 오픈마켓 주문 상태 코드 : 배열 */
	private String[] arrOrdStatCd;	
}
