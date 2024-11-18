package biz.interfaces.cis.model.response.order;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderInquiryItemVO{
	
	private String ordrNo;            /** 주문번호			*/ 
	private int    sortNo;		      /** 주문순번			*/ 
	private int    skuNo;		      /** 단품번호			*/ 
	private String skuCd;		      /** 단품코드			*/ 
	private String skuNm;		      /** 단품이름			*/ 
	private String optTxt;		      /** 옵션내용			*/ 
	private String unitNm;		      /** 단위				*/ 
	private int    price;		      /** 가격				*/ 
	private int    ea;			      /** 수량				*/ 
	private int    ea04;		      /** 수량_출고완료		*/ 
	private int    ea05;		      /** 수량_배송완료		*/ 
	private int    ea99;		      /** 수량_주문취소		*/ 
	private String statCd;		      /** 상태코드			: 02:결제완료, 03:상품준비, 04:출고확정, 05:배송완료, 99:주문취소 */ 
	private String ownrCd;		      /** 화주 코드			*/ 
	private String wareCd;		      /** 물류센터 코드		*/ 
	private String drelTpCd;	      /** 출고 유형 코드		: SO1 : 온라인, SO2 : 오프라인 */ 
	private String dlvtTpCd;	      /** 배송 유형 코드		: 10 : 택배, 20 : 당일배송, 21 : 새벽배송, 30 : 자체배송, 40 : 퀵배송 */ 
	private String dlvfTpCd;	      /** 배송 운임 유형 코드	: 10 : 선불, 20 : 착불, 30 : 신용 */ 
	private String arrvCd;		      /** 도착지 코드			*/
	private String dlvGrpCd;	      /** 배송 권역 코드		*/
	private String dawnMallId;		  /** 새벽배송 배송센터코드 */
	private String dlvReqDd;	      /** 배송요청일			*/ 
	private String shopOrdrNo;	      /** 상점주문번호		*/ 
	private String shopSortNo;	      /** 상점주문순번		*/ 
	private String clltOrdrNo;	      /** 수집처주문번호		*/ 
	private String clltSortNo;	      /** 수집처주문순번		*/ 
	private String rtlrOrdrNo;	      /** 판매처주문번호		*/ 
	private String rtlrSortNo;	      /** 판매처주문순번		*/ 
	private String exchgYn;		      /** 교환주문여부		*/
	private String orgShopOrdrNo;     /** 원 주문 번호 		: 교환주문일 경우 원 주문의 상점 주문번호 */
	private String orgShopSortNo;     /** 원 주문 순번 		: 교환주문일 경우 원 주문의 상점 주문순번 */
	private String orgClltOrdrNo;     /** 원 주문 번호 		: 교환주문일 경우 원 주문의 수집처 주문번호 */
	private String orgClltSortNo;     /** 원 주문 순번 		: 교환주문일 경우 원 주문의 수집처 주문순번 */
	private String rmkTxt;		      /** 비고				*/ 
	private String clltCd;		      /** 수집처코드			*/ 
	private String clltCdNm;	      /** 수집처코드명		*/ 
	private String rtlrCd;		      /** 판매처코드			*/ 
	private String rtlrCdNm;	      /** 판매처코드명		*/ 
	private String ordrNm;		      /** 주문자명			*/ 
	private String ordrTelNo;	      /** 주문자전화번호		*/ 
	private String ordrCelNo;	      /** 주문자휴대전화		*/ 
	private String ordrEmail;	      /** 주문자이메일		*/ 
	private String recvNm;		      /** 수령자명			*/ 
	private String recvTelNo;	      /** 수령자전화번호		*/ 
	private String recvCelNo;	      /** 수령자휴대전화		*/ 
	private String recvZipcode;	      /** 수령자우편번호		*/ 
	private String recvAddr;	      /** 수령자주소			*/ 
	private String recvAddrDtl;	      /** 수령자주소상세		*/ 
	private int    dlvAmt;		      /** 배송비				*/ 
	private String gateNo;		      /** 공동현관 출입번호	*/ 
	private String ordrDd;		      /** 주문일자			*/ 
	private String ordrTm;		      /** 주문시간			*/ 
	
	/** exptList */
	private List<OrderInquiryExptVO> exptList;
	
	
	/*****************************/
	/** 필요에 의해 추가            */
	/*****************************/
	private int shopOrdrDtlSeq;			/** 주문상세순번 */
	private int shopOrdrCstrtSeq;		/** 주문구성순번 */
}
