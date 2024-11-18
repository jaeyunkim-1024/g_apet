package biz.app.appweb.model;

import java.sql.Timestamp;
import java.util.List;

import biz.common.model.PushTargetPO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: PushPO.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class PushPO extends NoticeSendCommonVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 발송 날짜 */
	private Timestamp sendReqDtm;
	
	/** 발송 날짜 (시) */
	private String sendReqDtmHr;
	
	/** 발송 날짜 (분) */
	private String sendReqDtmMn;
	
	/** 발송 날짜 (초) */
	private String sendReqDtmSec;
	
	/** 발송 날짜 추출 */
	public Timestamp getSendReqDtmTotal() {
		return getTimestampForInsert(this.sendReqDtm, this.sendReqDtmHr, this.sendReqDtmMn ,this.sendReqDtmSec);
	}
	
	/** 발송 날짜 설정 (yyyy-MM-dd HH:mm:ss) */
	private Timestamp getTimestampForInsert(Timestamp date, String HH, String mm, String ss) {
		Timestamp rtn = null;
		if(date != null) {
			String dateStr = DateUtil.getTimestampToString(date,"yyyyMMdd");
			dateStr =  !StringUtil.isBlank(HH) ? dateStr.concat(HH) : dateStr.concat("00");
			dateStr =  !StringUtil.isBlank(mm) ? dateStr.concat(mm) : dateStr.concat("00");
			dateStr =  !StringUtil.isBlank(ss) ? dateStr.concat(ss) : dateStr.concat("59");
			
			rtn = DateUtil.getTimestamp(dateStr, "yyyyMMddHHmmss");
		}
		
		return rtn;
	}
	
	/** 회원 번호 [배열] */
	private String[] mbrNos;
	
	/** OS 구분 설정 : APP 전체 구분 */
	private String appAllGb;
	
	/** APP 아이콘 값 */
	private String appIconVal;
	
	/** 파일 명 */
	private String fileName;
	
	/** 파일 경로 */
	private String filePath;
	
	/** target */
	private List<PushTargetPO> target;
	
	/** targetList */
	private String targetList;
	
	/** 정보성 구분(정보성, 광고성) */
	private String receiverSendInfo;
	
	/** 정보성 구분  코드 */
	private String infoTpCd;
	
	/** 등록자 */
	public Long getSysRegrNo() {
		return (super.getSysRegrNo() == null )? CommonConstants.SYSTEM_USR_NO : super.getSysRegrNo();
	}
	/** 수정자 */
	public Long getSysUpdrNo() {
		return (super.getSysUpdrNo() == null )? CommonConstants.SYSTEM_USR_NO : super.getSysUpdrNo();
	}
	
	/** 알림메시지 발송 구분(수동) */
	private String pushGb;
}
