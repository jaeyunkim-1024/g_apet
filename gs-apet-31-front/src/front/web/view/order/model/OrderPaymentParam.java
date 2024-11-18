package front.web.view.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

import org.apache.commons.lang3.StringEscapeUtils;

import framework.common.model.PopParam;
import framework.common.util.StringUtil;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.order.model
* - 파일명		: OrderParam.java
* - 작성일		: 2017. 6. 2.
* - 작성자		: Administrator
* - 설명			: 주문 결제 페이지 재조회용 
* </pre>
*/
@Data
public class OrderPaymentParam implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 도서산간지역 여부 */
	private String localPostYn;
	
	/** 주문자 명 */
	private String ordNm;
	
	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 이메일 */
	private String ordrEmail;
	
	/** 배송지 선택 값 */
	private String orderDeliverySel;
	
	/** 수취인 명 */
	private String	adrsNm;
	
	/** 전화 */
	private String	adrsTel;
	
	/** 휴대폰 */
	private String	adrsMobile;
	
	/** 우편번호 구 */
	private String	postNoOld;
	
	/** 지번 주소 */
	private String	prclAddr;
	
	/** 지번 상세 주소 */
	private String 	prclDtlAddr;
	
	/** 우편번호 신 */
	private String 	postNoNew;
	
	/** 도로명 주소 */
	private String	roadAddr;
	
	/** 도로명 상세 주소 */
	private String	roadDtlAddr;
	
	/** 배송 메모 */
	private String	dlvrMemo;

	/** 배송요청사항여부 */
	private String dlvrDemandYn;

	/** 상품수령위치코드 */
	private String goodsRcvPstCd;

	/** 상품수령위치명 */
	private String goodsRcvPstNm;

	/** 상품수령위치기타 */
	private String goodsRcvPstEtc;

	/** 공동현관출입방법코드 */
	private String pblGateEntMtdCd;

	/** 공동현관출입방법명 */
	private String pblGateEntMtdNm;

	/** 공동현관비밀번호 */
	private String pblGatePswd;

	/** 배송요청사항 */
	private String dlvrDemand;

	/** 회원 배송지 번호 */
	private Integer mbrDlvraNo;

	/** 배송지 명 */
	private String gbNm;

	/** 입금예정일자(시간?) */
	private String dpstSchdDt;

	/** 기본결제수단 저장여부 */
	private String defaultPayMethodSaveYn;
	
	/** App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다. */
	private String callParam;
	
	public String getEscapedGbNm() {
		return (StringUtil.isNotBlank(gbNm))?StringEscapeUtils.unescapeHtml4(gbNm):"";
	}
	public String getEscapedAdrsNm() {
		return (StringUtil.isNotBlank(adrsNm))?StringEscapeUtils.unescapeHtml4(adrsNm):"";
	}
	public String getEscapedRoadDtlAddr() {
		return (StringUtil.isNotBlank(roadDtlAddr))?StringEscapeUtils.unescapeHtml4(roadDtlAddr):"";
	}	
	
	public String getEscapedGoodsRcvPstEtc() {
		return (StringUtil.isNotBlank(goodsRcvPstEtc))?StringEscapeUtils.unescapeHtml4(goodsRcvPstEtc):"";
	}
	public String getEscapedPblGatePswd() {
		return (StringUtil.isNotBlank(pblGatePswd))?StringEscapeUtils.unescapeHtml4(pblGatePswd):"";
	}
	public String getEscapedDlvrDemand() {
		return (StringUtil.isNotBlank(dlvrDemand))?StringEscapeUtils.unescapeHtml4(dlvrDemand):"";
	}
}