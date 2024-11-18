package biz.app.member.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberBizInfoVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 회사 번호 */
	private Long bizNo;
	
	/** 회사 아이디 */
	private String bizId;
	
	/** 회사 명 */
	private String bizNm;
	
	/** 우편 번호 구 */
	private String postNoOld;
	
	/** 우편 번호 신 */
	private String postNoNew;
	
	/** 도로 주소 */
	private String roadAddr;
	
	/** 도로 상세 주소 */
	private String roadDtlAddr;
	
	/** 지번 주소 */
	private String prclAddr;
	
	/** 지번 상세 주소 */
	private String prclDtlAddr;
	
	/** 이메일 */
	private String email;
	
	/** 제휴일 */
	private String ptnDate;
	
	/** 상태 */
	private String statCd;
	
	/** 대표자 명 */
	private String ceoNm;
	
	/** 사업자 등록 번호 */
	private String bizLicNo;
	
	/** 사업자 등록증 경로 */
	private String bizLicImgPath;
	
	/** 업태 */
	private String bizCdts;
	
	/** 업종 */
	private String bizTp;
	
	/** 대표 번호 */
	private String dlgtNo;
	
	/** 출고지 우편번호 구 */
	private String relPostNoOld;
	
	/** 출고지 우편번호 신 */
	private String relPostNoNew;
	
	/** 출고지 도로 주소 */
	private String relRoadAddr;
	
	/** 출고지 도로 상세 주소 */
	private String relRoadDtlAddr;
	
	/** 출고지 지번 주소 */
	private String relPrclAddr;
	
	/** 출고지 지번 상세 주소 */
	private String relPrclDtlAddr;
	
	/** 교환/반품 우편번호 구 */
	private String rePostNoOld;
	
	/** 교환/반품 우편번호 신 */
	private String rePostNoNew;
	
	/** 교환/반품 도로 주소 */
	private String reRoadAddr;
	
	/** 교환/반품 도로 상세 주소 */
	private String reRoadDtlAddr;
	
	/** 교환/반품 지번 주소 */
	private String rePrclAddr;
	
	/** 교환/반품 지번 상세 주소 */
	private String rePrclDtlAddr;
	
	/** 담당 부서 */
	private String chrgPart;
	
	/** 담당자 이름 */
	private String chrgNm;
	
	/** 담당자 전화번호 */
	private String chrgTel;
	
	/** 담당자 휴대폰 */
	private String chrgMobile;
	
	/** 담당자 이메일 */
	private String chrgEmail;
	
	/** 은행 코드 */
	private String bankCd;
	
	/** 계좌 번호 */
	private String acctNo;
	
	/** 예금주 */
	private String ooaNm;
	
	/** 메모 */
	private String memo;
}