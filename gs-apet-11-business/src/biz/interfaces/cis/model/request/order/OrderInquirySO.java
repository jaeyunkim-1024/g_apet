package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OrderInquirySO extends ApiRequest {

	/** 상점주문번호 */
	private String shopOrdrNo;
	
	/** 수집처주문번호 */
	private String clltOrdrNo;
	
	/** 판매처주문번호 */
	private String rtlrOrdrNo;
	
	/** 검색시작일자 */
	private String srcStaDd;		//상점/수집처/판매처 주문번호가 없을 경우 필수
	
	/** 검색종료일자 */
	private String srcEndDd;		//상점/수집처/판매처 주문번호가 없을 경우 필수
	
	/** 전체여부 */
	private String allYn="N";		//Y일 경우 외부수집주문 외 상점에서 CIS로 전송한 주문정보도 함께 조회

	//아래 항목은 상점/수집처/판매처 주문번호가 없을 경우만 적용
	/** 판매처코드 */
	private String rtlrCd;

	/** 판매처코드명 */
	private String rtlrCdNm;

	/** 단품코드 */
	private String skuCd;

	/** 주문일자 */
	private String ordrDd;

	/** 주문자휴대전화 */
	private String ordrCelNo;

	/** 수령자명 */
	private String recvNm;

	/** 수령자휴대전화 */
	private String recvCelNo;

	/** 송장 번호 */
	private String invcNo;

	/** 택배사 코드 */
	private String dlvCmpyCd;

	/** 상태코드 */
	private String statCd;	
}
