package biz.app.partner.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PartnerInfoSO extends BaseSearchVO<PartnerInfoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 기간 검색 조건 */
	private String dateOption;
	
	/** 기간 시작 날짜 */
	private String searchStDate;
	
	/** 기간 종료 날짜 */
	private String searchEnDate;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 파트너 명 */
	private String bizNm;
	
	/** 이메일 */
	private String email;
	
	/** 상태 */
	private String mbrStatCd;
	
	/** 파트너 구분 코드 */
	private String mbrGbCd;
	
	/** 파트너 번호 */
	private Long mbrNo;
	
	/** 마스킹 여부 */
	private String maskingYn;
	
	/** 업체 번호 */
	private Long compNo;
	
	private String nickNm;
	
}