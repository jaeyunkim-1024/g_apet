package biz.app.system.model;

import java.sql.Timestamp;

import org.apache.commons.lang.StringUtils;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserBaseSO extends BaseSearchVO<UserBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사용자 번호 */
	private Long usrNo;
	
	/** 패스워드 */
	private String pswd;
	
	/** 사용자 명 */
	private String usrNm;

	/** 사용자 상태 코드 */
	private String usrStatCd;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 - 메시지보내기에서 업체명 검색할 때 사용함 */
	private String rcvCompNm;

	/** 하위 업체 번호 */
	private Long lowCompNo;

	/** 사용자 구분 코드 */
	private String usrGbCd;

	/** 사용자 구분 코드 : 배열 */
	private String[] arrUsrGbCd;
	
	/** 로그인 아이디 */
	private String loginId;

	/** 사용자 그룹 코드 */
	private String usrGrpCd;

	/** 등록일시 시작 */
	private Timestamp strtDtm;

	/** 등록일시 종료 */
	private Timestamp endDtm;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;

	/** 로그인한 사용자의 UsrGbCd 에 관게 없이 사용자 전체 검색하고 싶을 때 */
	private String searchAllUser;

	public String getSearchAllUser() {
		return StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, this.searchAllUser) ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N;
	}
	
	/** 접근권한 번호*/
	private Long authNo;
	
	/** 소속 부서 명 */
	private String dpNm;
	
	/** 최종로그인 유효일 */
	private Integer validDayForBatch;
}