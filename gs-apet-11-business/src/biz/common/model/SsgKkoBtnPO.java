package biz.common.model;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
 * - 파일명		: SsgKkoBtnPO.java
 * - 작성일		: 2021. 2. 2. 
 * - 작성자		: KSH
 * - 설 명		: KakaoButton Param Object
 * </pre>
 */
@Data
public class SsgKkoBtnPO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 버튼 타입 */
	private String btnType;

	/** 버튼명 */
	private String btnName;

	/** Pc Link Url */
	private String pcLinkUrl;

	/** Mobile Link Url */
	private String mobileLinkUrl;
	
	/** mobile ios 환경에서 버튼 클릭 시 실행할 application custom scheme */
	private String schemaIos;

	/** mobile android 환경에서 버튼 클릭 시 실행할 application custom scheme */
	private String schemaAndroid;

}