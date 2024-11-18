package biz.app.order.model;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderSO extends BaseSearchVO<OrderSO> {

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

	/** 주문 상세 상태 코드 : 배열 */
	private String[] arrOrdDtlStatCd;

	/** 클레임 상세 상태 코드 : 배열 */
	private String[] arrClmDtlStatCd;

	/** 검색 조건 : 주문정보 */
	private String searchKeyOrder;

	/** 검색 값 : 주문정보 */
	private String searchValueOrder;

	/** 검색 조건 : 상품정보 */
	private String searchKeyGoods;

	/** 검색 값 : 상품정보 */
	private String searchValueGoods;

	/** 업체 번호 */
	private Long compNo;

	/** 하위 업체 번호 */
	private Long lowCompNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 기존 펫츠비 회원 번호 */
	private Long migMemno;

	/** 가입 구분 코드 */
	private String joinPathCd;

	/** 회원  로그인 아이디 */
	private String loginId;

	/** 주문 번호 */
	private String ordNo;


	/** 주문자 이메일 */
	private String ordrEmail;

	/** 시작 일시 : Start */
	private Timestamp dtmStart;

	/** 종료 일시 : End */
	private Timestamp dtmEnd;

	/** 클레임상세상태 */
	private String clmDtlStatCd;

	/** 클레임 상세유형코드 */
	private String clmDtlTpCd;

	/** 배송비 번호 */
	private Long dlvrcNo;

	/** 배송지연기간 */
	private String dlvrDelayPrd;

	/** 현금영수증 번호 */
	private Long cashRctNo;

	/** 엑셀다운  */
	private Boolean  excelDownY = Boolean.FALSE;
	/** 페이징 여부 에 여 */
	private Boolean  pagingY = Boolean.TRUE;
	

	/** 주문삭제 여부 */
	private String ordrShowYn;

	/** 반품 가능 여부 */
	private String rtnPsbYn;
	
	/** 주문 접수 일시 : 위탁업체 주문건 알림 발송용 */
	private String ordAcptDtmCompSearch;

















	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;



	/** 주문 상세 번호 */
	private Integer ordDtlSeq;

	/** 단품 번호 */
	private Long itemNo;

	/** 클레임 접수 일시 : Start */
	private Timestamp clmAcptDtmStart;

	/** 클레임 접수 일시 : End */
	private Timestamp clmAcptDtmEnd;

	/** 결제 수단 코드 */
	private String payMeansCd;



	/** 페이지 구분 코드 */
	private String pageGbCd;










	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;







	/** 배송 번호 : 배열 */
	private Long[] arrDlvrNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;


	/** 단품 명 */
	private String itemNm;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 번호 */
	private Integer clmDtlSeq;



	/** 배송 번호 */
	private Long dlvrNo;



	/** 조립비 번호 */
	private Long asbcNo;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 클레임 사유 코드 */
	private String clmRsnCd;

	/** 메모 */
	private String memo;


	/** 회원 명 */
	private String mbrNm;

	/** 화면 구분 */
	private String viewGb;

	/** 택배사 코드 */
	private String hdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 상담 상태 코드 */
	private String cusStatCd;

	/** 상담 상태 코드 : Array */
	private String[] arrCusStatCd;

	/** 상담 카테고리1 코드 */
	private String cusCtg1Cd;

	/** 상담 카테고리2 코드 */
	private String cusCtg2Cd;

	/** 상담 카테고리3 코드 */
	private String cusCtg3Cd;

	/** 환불 상태 코드 */
	private String rfdStatCd;

	/** 현금 영수증 상태 코드 */
	private String cashRctStatCd;

	/** 발행 구분 코드 */
	private String isuGbCd;

	/** 세금 계산서 상태 코드 */
	private String taxIvcStatCd;

	/** 환불 상태 코드 */
	private String[] arrRfdStatCd;

	/** 현금 영수증 발급 유형 코드 */
	private String[] arrCrTpCd;

	/** 현금 영수증 상태 코드 */
	private String[] arrCashRctStatCd;

	/** 세금 계산서 상태 코드 */
	private String[] arrTaxIvcStatCd;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 클레임 상태 코드 : 배열 */
	private String[] arrClmStatCd;

	/** 상담 번호 */
	private Long cusNo;

	/** 상담 경로 코드 */
	private String cusPathCd;

	/** 문의자 명 */
	private String eqrrNm;

	/** 문의자 전화 */
	private String eqrrTel;

	/** 문의자 휴대폰 */
	private String eqrrMobile;

	/** 문의자 이메일 */
	private String eqrrEmail;

	/** 문의자 회원 번호 */
	private Long eqrrMbrNo;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;

	/** 파일 번호 */
	private Long flNo;

	/** 상담 접수 일시 */
	private Timestamp cusAcptDtm;

	/** 상담 취소 일시 */
	private Timestamp cusCncDtm;

	/** 상담 완료 일시 */
	private Timestamp cusCpltDtm;

	/** 상담 접수자 번호 */
	private Long cusAcptrNo;

	/** 상담 취소자 번호 */
	private Long cusCncrNo;

	/** 상담 완료자 번호 */
	private Long cusCpltrNo;

	/** 처리 번호 */
	private Long prcsNo;

	/** 처리 내용 */
	private String prcsContent;

	/** 상담 회신 코드 */
	private String cusRplCd;

	/** 회신 헤더 내용 */
	private String rplHdContent;

	/** 회신 내용 */
	private String rplContent;

	/** 회신 푸터 내용 */
	private String rplFtContent;

	/** 상담 처리 일시 */
	private Timestamp 	cusPrcsDtm;

	/** 상담 처리자 번호 */
	private Long cusPrcsrNo;

	/** 상담 접수 일시 : Start */
	private Timestamp cusAcptDtmStart;

	/** 상담 접수 일시 : End */
	private Timestamp cusAcptDtmEnd;

	/** 결제 조정 금액 */
	private Long payAdjustAmt;

	/** 총 카운트 */
	private Integer cntTotal;

	/** 성공 카운트 */
	private Integer cntSuccess;

	/** 실패 카운트 */
	private Integer cntFail;

	/** 결제금액 */
	private Long payAmt;

	/** 원 배송비 번호 */
	private Long orgDlvrcNo;

	/** 원 조립비 번호 */
	private Long orgAsbcNo;

	/** POS 주문 번호 */
	private String posOrdNo;

	/** POS 주문 상세 번호 */
	private Integer posOrdDtlNo;

	/** POS 주문 상세 번호 : 배열 */
	private Integer[] arrPosOrdDtlNo;

	private String filePath;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/** 기간별 검색 */
	private String period;

	/** 주문 취소/반품/교환 시 사용*/
	/**체크index*/
	private Integer[] selectCheck;
	private Integer[] selectChecked;
	/**사유코드*/
	private String[] arrClmRsnCd;
	/**주문금액*/
	private Long[] arrPayAmt;
	/**배송비번호*/
	private Long[] arrDlvrcNo;
	/**조립번호*/
	private Long[] arrAsbcNo;
	/**사유*/
	private String[] arrMemo;
	/**주문수량*/
	private Integer[] arrOrdQty;
	/** 배송비 */
	private Long[] arrRealDlvrAmt;
	/** 조립비 */
	private Long[] arrRealAsbAmt;

	/** 받는분명 */
	private String rsvAdrsNm;

	 /** 수령인 전화번호 */
	private String rsvTel;

	 /** 수령인 휴대폰 */
	private String rsvMobile;

	/** 수령인 주소 1 */
	private String rsvRoadAddr;

	/** 수령인 주소 2 */
	private String rsvRoadDtlAddr;

	/** 결제일 */
	private String rsvPayCpltDtm;

	/** 주문 취소 일시 */
	private Timestamp ordCncDtm;

	/** 시스템 수정자 번호. 쿠폰반환에서 사용 */
	private Long sysUpdrNo;

	private String bulkOrdInfo;

	/** 모바일 마이페이지 최근 주문 검색시 사용하는  기간 */
	private Long recentSearchPeriod;
	
	/** 메시지 타입 */
	private String msgType;

	/** Arr주문 번호 */
	private String[] arrOrdNo;
	/** Arr클레임 번호 */
	private String[] arrClmNo;
	/** 주문 상세 번호 : 배열 */
	private Integer[] arrOrdDtlSeq;
	/** 클레임 상세 번호 : 배열 */
	private Integer[] arrClmDtlSeq;
	

	private String maskingUnlock = CommonConstants.COMM_YN_N;
	
	/** 업체 유형 : 배열 */
	private String[] arrCompTpCd;
	
	/** 배송 처리 유형 : 배열 */
	private String[] arrDlvrPrcsTpCd;
}