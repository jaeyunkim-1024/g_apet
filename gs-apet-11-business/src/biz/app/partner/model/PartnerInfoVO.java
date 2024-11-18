package biz.app.partner.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PartnerInfoVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 파트너 번호 */
	private Long mbrNo;
	
	/** 파트너 업체 번호 */
	private Long bizNo;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 파트너 명 */
	private String mbrNm;
	
	/** 파트너 업체 명 */
	private String bizNm;
	
	/** 이메일 */
	private String email;
	
	/** 파트너 업체 상태 코드 */
	private String statCd;
	
	/** 파트너 상태 코드 */
	private String mbrStatCd;
	
	/** 최종 로그인 일시 */
	private Timestamp lastLoginDtm;
	
	/** 제휴일 */
	private String ptnDate;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 우편번호 */
	private String postNoNew;
	
	/** 도로명 주소 */
	private String roadAddr;
	
	/** 도로명 상세 주소 */
	private String roadDtlAddr;
	
	/** 지번 주소 */
	private String prclAddr;
	
	/** 지번 상세 주소 */
	private String prclDtlAddr;
	
	/** 파트너 구분 코드 */
	private String mbrGbCd;
	
	
	/** 닉네임 */
	private String nickNm;
	
	/** 펫로그 소개 */
	private String petLogItrdc;
	
	/** 프로필 이미지 */
	private String prflImg;
	
	/** 수정자 IP */
	private String updrIp;
	
	/** 도로명 전체 주소 */
	private String roadAddrFull;
	
}