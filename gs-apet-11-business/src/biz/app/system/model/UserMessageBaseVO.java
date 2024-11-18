package biz.app.system.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserMessageBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 수신자 번호 */
	private Long usrNo;
	/** 수신자 명 */
	private String usrNm;
	
	/** 발신자 번호 */
	private Long sndrNo;
	/** 발신자 명 */
	private String sndrNm;
	/** 제목 */
	private String ttl;
	/** 내용 */
	private String content;
	
	/** 파일번호 */
	private Long flNo;
	
	/** 쪽지 번호 */
	private Long noteNo;	
	/** 수신 여부 */
	private String rcvYn;	
	/** 수신 일시 */
	private Timestamp rcvDtm;	
	/** 삭제 여부 */
	private String delYn;
	
	
	 
	
	
}