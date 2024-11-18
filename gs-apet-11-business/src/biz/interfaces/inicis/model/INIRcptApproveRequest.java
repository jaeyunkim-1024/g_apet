package biz.interfaces.inicis.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.model
* - 파일명		: INIRcptApproveRequest.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: INIpay 현금영수증 요청 Object
* </pre>
*/
@Data
public class INIRcptApproveRequest {

	/** 상점 아이디 */
	private String 	strId;
	
	/** 상품 명 */
	private String goodsName;

	/** 총 결제 금액 */
	private Long		crPrice;
	
	/** 공급가액 */
	private Long		supPrice;
	
	/** 부가세 */
	private Long		tax;
	
	/** 봉사료 */
	private Long		srvcPrice;
	
	/** 현금영수증 발행 번호 */
	private String	regNum;
	
	/** 현금영수증 발행용도 : INIPayConstants.CSHR_TYPE 참조 */
	private String	useopt;
	
	/** 구매자 성명 */
	private String	buyername;
	
	/** 구매자 이메일 주소 */
	private String	buyeremail;
	
	/** 구매자 전화번호 */
	private String	buyertel;
	
	
}
