package biz.app.settlement.model;

import java.sql.Timestamp;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SettlementListSO extends BaseSearchVO<SettlementListSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;
	
	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 주문 접수 일시 : Start */
	private Timestamp ordAcptDtmStart;

	/** 주문 접수 일시 : End */
	private Timestamp ordAcptDtmEnd;

	/** 배송 지시 일시 : Start */
	private Timestamp dlvrCmdDtmStart;

	/** 배송 지시 일시 : End */
	private Timestamp dlvrCmdDtmEnd;
	
	/** 구매 확정 일시 : Start */
	private Timestamp purConfDtmStart;

	/** 구매 확정 일시 : End */
	private Timestamp purConfDtmEnd;

	/** 정산 완료 일시 : Start */
	private Timestamp ordCclCpltDtmStart;

	/** 정산 완료 일시 : End */
	private Timestamp ordCclCpltDtmEnd;
	
	/** 주문 상세 상태 코드 : 배열 */
	private String[] arrOrdDtlStatCd;
	
	/** 주문목록 정산 상태 코드 : 배열 */
	private String[] arrOrdListStatCd;

	/** 주문목록 정산 상태 코드 */
	private String ordListStatCd;
	
	/** 검색 조건 : 주문정보 */
	private String searchKeyOrder;

	/** 검색 값 : 주문정보 */
	private String searchValueOrder;

	/** 검색 조건 : 상품정보 */
	private String searchKeyGoods;
	
	/** 검색 조건 : 날짜정보 */
	private String searchKeyDate;

	/** 검색 값 : 상품정보 */
	private String searchValueGoods;
	
	/** 검색 값 : 엑셀 버튼 타입 */
	private String searchTypeExcel;

	/** 업체 번호 */
	private Long compNo;

	/** 하위 업체 번호 */
	private Long lowCompNo;

	/** 업체 번호 - 하위업체까지 같이 조회 */
	private Long compNoWithLowComp;

	/** 회원 번호 */
	private Long mbrNo;

	/** 주문 번호 */
	private String ordNo;

	/** 전체 하위업체 포함 플래그 */
	private String showAllLowCompany;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 인터페이스조회여부 2017/06/19 추가 */
	private String interfaceSearchYn; 
	
	/**결제수단코드 */
	private String payMeansCd;
	
	/**결제수단코드 : 배열 */
	private String[] arrPayMeansCd;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 주문취소제외여부 */
	private String exOrdCancelYn;
	
	/** 사전예약만 조회 여부 */
	private String preReserveYn;
	
	/** 송장번호 - 회원정보에서 사용 */
	private String invNo;
	
	/** 주문상세상태 - 회원정보에서 사용  */
	private String ordDtlStatCd;
	
	/** 쿠폰 사용여부 */
	private String useCoupon;
	
	/** 업체 유형 코드 배열 */
	private String[] arrCompTpCd;
	
	/** 배송 처리 유형 코드 배열 */
	private String[] arrDlvrPrcsTpCd;

	/**개인정보 마스킹처리*/
	private String maskingUnlock = CommonConstants.COMM_YN_N;
	
	/** 주문 번호 | 주문 상세 순번 배열 */
	private String[] ordDtlSeqs;
}
