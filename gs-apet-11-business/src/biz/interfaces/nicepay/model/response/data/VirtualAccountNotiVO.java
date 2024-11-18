package biz.interfaces.nicepay.model.response.data;

import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class VirtualAccountNotiVO extends ResponseCommonVO{
	private static final long serialVersionUID = 1L;
	
	private String Amt; // 12 상품금액 (예시: 1000)
	private String AuthCode; // 30 승인번호
	private String AuthDate; // 12 입금일시 (예시: 170821195328)
	private String BuyerAuthNum; // 15 구매자 식별번호
	private String BuyerEmail; // 60 구매자 e-mail (예시: it@nicepay.co.kr)
	private String FnCd; // 3 은행코드 (예시: 004)
	private String FnName; // 20 은행명 (예시: 국민은행)
	private String GoodsName; // 40 상품명 (예시: 곰인형)
	private String MallUserID; // 20 회원사고객 ID
	private String MID; // 10 상점 ID (예시: nicepay00m)
	private String MOID; // 40 주문번호
	private String name; // 30 구매자명 (예시: 홍길동)
	private String PayMethod; // 4 지불수단 (예시: VBANK)
	private String RcptAuthCode; // 30 현금영수증 승인번호 (예시: 533061234)
	private String RcptTID; // 30 현금영수증 TID (예시: nicepay00m04011709110011161234)
	private String RcptType; // 1 현금영수증 구분 (예시: 1)
	private String ReceitType; // 1 현금영수증 타입 (미발행: 0 / 소득공제: 1 / 지출증빙: 2)
	// private String ResultCode; // 4 결과 코드 (예시: 4110)
	// private String ResultMsg; // 100 결과 메시지 (예시: 승인)
	private String StateCd; // 1 거래 상태 (승인: 0, 전취소: 1, 후취소: 2)
	private String TID; // 30 거래 ID (예시: nicepay00m03011708211953289333)
	private String VbankInputName; // 20 가상계좌 예금주명 (예시: 홍길동)
	private String VbankName; // 20 가상계좌 은행명 (예시: 국민은행)
	private String VbankNum; // 20 가상계좌 번호 (예시: 12349012131234)
	private String MallReserved; // 500 가맹점 여분필드, 500byte 초과 문자열 삭제 주의
	private String MallReserved1; // 10 사업자번호
	private String MallReserved2; // 가맹점번호 (현재 사용되지 않는 필드이며, 응답값은 없습니다.)
	private String MallReserved3; //
	private String MallReserved4; //
	private String MallReserved5; //
	private String MallReserved6; //

}
