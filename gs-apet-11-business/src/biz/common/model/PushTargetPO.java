package biz.common.model;

import java.io.Serializable;
import java.util.Map;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushTargetPO.java
* - 작성일		: 2021. 02. 02.
* - 작성자		: KKB
* - 설명		: Push에 사용되는 target po
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PushTargetPO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 수신대상 식별자 : ALL - 입력 필요 없음, CHANNEL - 채널명, USER - 사용자아이디 */
	private String to;
	
	/** 매개변수 */
	private Map<String, String> parameters;
	
	/** Push에 표현될 이미지 URL 링크 주소*/
	private String image;
	
	/** Push를 선택해서 앱 진입시 이동될 URL 주소*/
	private String landingUrl;
}