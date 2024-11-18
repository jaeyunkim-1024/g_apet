package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.apache.commons.lang3.StringEscapeUtils;

import framework.common.model.BaseSysVO;
import framework.common.util.StringUtil;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberAddressVO extends BaseSysVO {

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

	private String dtlAddr;

	private String dtlPostNo;

	/** 배송요청사항여부 */
	private String dlvrDemandYn;

	/** 상품수령위치코드 */
	private String goodsRcvPstCd;

	/** 상품수령위치코드 명*/
	private String goodsRcvPstNm;
	
	/** 상품수령위치기타 */
	private String goodsRcvPstEtc;

	/** 공동현관출입방법코드 */
	private String pblGateEntMtdCd;

	/** 공동현관출입방법코드 */
	private String pblGateEntMtdNm;
	
	/** 공동현관비밀번호 */
	private String pblGatePswd;

	/** 배송요청사항 */
	private String dlvrDemand;
	//===============================================================
	// 회원 기본
	//===============================================================
	/** 이메일 */
	private String email;
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