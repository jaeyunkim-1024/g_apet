package biz.common.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: TokenDeviceVO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: Token Device VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TokenDeviceVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;
	
	/** 디바이스 타입 */
	private String deviceType;
	
	/** 야간 광고성 메시지 수신동의 시간 */
	private String deviceToken;

}