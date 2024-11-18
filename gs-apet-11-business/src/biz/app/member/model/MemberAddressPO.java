package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberAddressPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 배송지 번호 */
	private Long mbrDlvraNo;

	/** 구분 명 */
	private String gbNm;

	/** 수취인 명 */
	private String adrsNm;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 기본 여부 */
	private String dftYn;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;
	
	/** 상품 수령 위치 코드 */ 
	private String goodsRcvPstCd;
	
	/** 상품 수령 위치 기타 */
	private String goodsRcvPstEtc;
	
	/** 공동 현관 출입 방법 코드 */	
	private String pblGateEntMtdCd;
	
	/** 공동 현관 비밀번호 */
	private String pblGatePswd;
	
	/** 배송 요청 사항 */ 
	private String dlvrDemand;
	
	/** 배송 요청 사항 여부*/
	private String dlvrDemandYn;

}