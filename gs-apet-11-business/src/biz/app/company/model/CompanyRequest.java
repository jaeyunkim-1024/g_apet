package biz.app.company.model;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class CompanyRequest extends ApiRequest {

	/** 거래처 코드 */
	private String prntCd;
	
	/** 거래처 이름 */
	private String prntNm;
	
	/** 거래처 유형 */
	private String prntTpCd;
	
	/** 상태 코드 */
	private String statCd;
	
	/** 화주 코드 */
	private String ownrCd;
	
	/** 대표자 이름 */
	private String ceoNm;
	
	/** 사업자 번호 */
	private String bizNo;
	
	/** 우편번호 */
	private String zipcode;
	
	/** 주소 */
	private String addr;
	
	/** 상세 주소 */
	private String addrDtl;
	
	/** 전화번호 */
	private String telNo;
	
	/** 팩스번호 */
	private String faxNo;
	
	/** 담당자 이름 */
	private String chrgNm;
	
	/** 담당자 전화번호 */
	private String chrgTelNo;
	
	/** 담당자 휴대전화 */
	private String chrgCelNo;
	
	/** 담당자 이메일 */
	private String chrgEmail;
	
	/** 거래 상태 */
	private String trdStatCd;
	
	/** 업태 */
	private String bsnCdt;
	
	/** 종목 */
	private String bsnItm;
	
	/** 결제조건 */
	private String stlCdtCd;
	
	/** 입고리드타임 */
	private String incmReadTm;

}
