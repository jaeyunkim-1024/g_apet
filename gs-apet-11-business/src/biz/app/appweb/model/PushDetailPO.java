package biz.app.appweb.model;

import framework.common.constants.CommonConstants;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.appweb.model
 * - 파일명		: PushDetailPO.java
 * - 작성일		: 2021. 01. 28. 
 * - 작성자		: KKB
 * - 설 명		: push/문자 발송 상세 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class PushDetailPO extends NoticeSendCommonVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 이력 상세 번호 */
	private Long histDtlNo;
	
	/** 발송 정보(params in json) */
	private String sndInfo;
	
	/** 외부요청 상세 ID (MailId) */
	private String outsideReqDtlId;
	
	/** 라이브여부 */
	private String liveYn;
	
	/** 등록자 */
	public Long getSysRegrNo() {
		return (super.getSysRegrNo() == null )? CommonConstants.SYSTEM_USR_NO : super.getSysRegrNo();
	}
	/** 수정자 */
	public Long getSysUpdrNo() {
		return (super.getSysUpdrNo() == null )? CommonConstants.SYSTEM_USR_NO : super.getSysUpdrNo();
	}
	
}
