package biz.common.model;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushMessageDevicePO.java
* - 작성일		: 2021. 02. 02.
* - 작성자		: KKB
* - 설명		: Push에 사용되는  Message po
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PushMessagePO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 메시지 내용*/
	private String content;
	
	/** custom  */
	private Map<String, String> custom;
	
	/** option */
	private Map<String, String> option;
	
	/** i18n */
//	private  Map<String,Map<String, String>> i18n[];

}