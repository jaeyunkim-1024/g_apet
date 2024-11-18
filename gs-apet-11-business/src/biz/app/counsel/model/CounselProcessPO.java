package biz.app.counsel.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CounselProcessPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 처리 번호 */
	private Long prcsNo;

	/** 상담 번호 */
	private Long cusNo;
	
	/** 상담자 번호 */
	private Long eqrrMbrNo;
	
	/** 알림 수신 여부 */
	private String pstAgrYn;
	
	/** 정보성 수신 동의 여부 */
	private String infoRcvYn;

	/** 처리 내용 */
	private String prcsContent;

	/** 상담 회신 코드 */
	private String cusRplCd;

	/** 회신 헤더 내용 */
	private String rplHdContent;

	/** 회신 내용 */
	private String rplContent;

	/** 회신 푸터 내용 */
	private String rplFtContent;

	/** 파일 번호 */
	private Long flNo;

	/** 상담 처리 일시 */
	private Timestamp cusPrcsDtm;

	/** 상담 처리자 번호 */
	private Long cusPrcsrNo;

	/** 상담 처리자 이름 */
	private String cusPrcsrNm;
	
	/** 저장 여부 */
	private String insertYn;
	
	/** 전달내용 */
	private String passContent;
	
}