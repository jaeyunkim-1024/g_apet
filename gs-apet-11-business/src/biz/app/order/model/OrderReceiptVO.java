package biz.app.order.model;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.delivery.model.DeliveryDivVO;
import biz.app.receipt.model.CashReceiptVO;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.PetraUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderBaseVO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 영수증 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderReceiptVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 주문상세 갯수 */
	private Integer ordDtlCnt;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Long chnlId;

	/** 채널 명 */
	private String chnlNm;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 ID */
	private String ordrId;

	/** 주문자 이메일 */
	private String ordrEmail;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 IP */
	private String ordrIp;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;

	/** 외부 주문 번호 */
	private String outsideOrdNo;

	/** 주문 처리 결과 코드 */
	private String ordPrcsRstCd;

	/** 주문 처리 결과 메세지 */
	private String ordPrcsRstMsg;

	/** 데이터 상태 코드 */
	private String dataStatCd;

	/** 주 결제 수단 코드 */
	private String payMeansCd;

	/** 배송비 변경 가능 여부 */
	private String dlvraChgPsbYn;

	/** 주문 취소 여부 */
	private String ordCancelYn;

	/** 환불 은행 코드 */
	private String refundBankCd;

	/** 환불 계좌 번호 */
	private String refundAcctNo;

	/** 환불 예금주 명 */
	private String refundOoaNm;

	/** 반품 진행 중 여부 */
	private String allClaimIngRtnYn;


	/** 주문 상세 List VO */
	private List<OrderDetailVO> orderDetailListVO;













	/** 결제일 */
	private Timestamp rsvPayCpltDtm;

	/** 결제 금액 합계 */
	private Long payAmtTotal;

	/** 받는분명 */
	private String rsvAdrsNm;

	 /** 수령인 전화번호 */
	private String rsvTel;

	 /** 수령인 휴대폰 */
	private String rsvMobile;

	/** 수령인 도로명 주소 1 */
	private String rsvRoadAddr;

	/** 수령인 도로명 주소 2 */
	private String rsvRoadDtlAddr;


/////////////////////////////////////////////////////////////////



	/** 결제 취소 금액 합계 */
	private Long clmAmtTotal;


	/** 주문전체취소 */
	private String cancelAll;

	/** 거래 번호(결제) */
	private String dealNo;

	/** 승인 번호(결제) */
	private String cfmNo;

	/** 반품 가능 여부 */
	private String rtnPsbYn;

	/** 현금 영수증 번호 */
	private Long cashRctNo;
	
	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 주문 상세 계산서(현금영수증/세금계산서) List VO */
	private List<OrderDetailTaxVO> orderDetailTaxListVO;

	/** 주문 상세 (배송) List VO */
	private List<OrderDetailDivVO> orderDetailDivListVO;

	/** 주문 상세 (CS) List VO */
	private List<OrderDetailCsVO> orderDetailCsListVO;

	/** 사은품 목록 */
	private List<OrderFreebieVO> cartFreebieList;

	/** 배송 List VO */
	private List<DeliveryDivVO> deliveryDivListVO;

	/** 현금 영수증 VO */
	private CashReceiptVO cashReceiptVO;

	/** Derived Attribute */
	public boolean getCanChangeMyOrder() {

		return checkOrderDetailStatus(orderDetailListVO);
	}

	protected boolean checkOrderDetailStatus(List<? extends OrderDetailVO> orderDetailList) {
		Boolean yesICan = Boolean.TRUE;

		// 주문당시의 주문상세 갯수와 현재 조회한 주문상세의 갯수가 같은지 확인한다.
		if (this.getOrdDtlCnt() != orderDetailList.size()) {
			yesICan = Boolean.FALSE;

			// 페이징 숫자때문에 주문 상세를 일부만 읽었을 경우에 대비, ORDER_BASE.ORD_STAT_CD 가 접수 상태가 아니면
			if (StringUtils.equals(this.getOrdStatCd(), CommonConstants.ORD_STAT_10)) {
				// 주문접수상태에서 부분취소는 허용하지 않으므로 TRUE 로 판단한다.
				yesICan = Boolean.TRUE;
			}
		} else {
			// 주문당시의 주문상세 갯수와 현재 조회한 주문상세의 갯수가 같더라도 진행중인 클래임이 있는 경우를 확인한다.
			for (OrderDetailVO orderDetail : orderDetailList) {
				// 전체 주문상세정보의 주문상태가 접수(110), 완료(120)가 아니면 OOO 할 수 없음
				// 취소클래임이 발생한 상품이 있으면 OOO 할 수 없음
				if (!canICancelMyOrder(orderDetail) || doIHaveAClaimdOrder(orderDetail)) {
					yesICan = Boolean.FALSE;

					break;
				}
			}
		}

		return yesICan;
	}

	private boolean canICancelMyOrder(OrderDetailVO orderDetail) {
		return StringUtils.equals(CommonConstants.ORD_DTL_STAT_110, orderDetail.getOrdDtlStatCd())
				|| StringUtils.equals(CommonConstants.ORD_DTL_STAT_120, orderDetail.getOrdDtlStatCd());
	}

	private boolean doIHaveAClaimdOrder(OrderDetailVO orderDetail) {
		return orderDetail.getOrdQty().compareTo(orderDetail.getRmnOrdQty()) != 0 ? Boolean.TRUE : Boolean.FALSE;
	}

	public String getOrdNm() {
		if(StringUtil.isNotEmpty(this.ordNm) && org.apache.commons.lang3.StringUtils.endsWith(this.ordNm, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordNm, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordNm;
	}

	public String getOrdrTel() {
		if(StringUtil.isNotEmpty(this.ordrTel) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrTel, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrTel, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrTel;
	}

	public String getOrdrMobile() {
		if(StringUtil.isNotEmpty(this.ordrMobile) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrMobile, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrMobile, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrMobile;
	}
	
	public String getOrdrEmail() {
		if(StringUtil.isNotEmpty(this.ordrEmail) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrEmail, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrEmail, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrEmail;
	}

	public String getOrdrId() {
		if(StringUtil.isNotEmpty(this.ordrId) && org.apache.commons.lang3.StringUtils.endsWith(this.ordrId, "=")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			PetraUtil PetraUtil = (framework.common.util.PetraUtil) wContext.getBean("petraUtil");
			return PetraUtil.twoWayDecrypt(this.ordrId, CommonConstants.SYSTEM_USR_NO.toString(), RequestUtil.getClientIp());
		}
		return this.ordrId;
	}
}