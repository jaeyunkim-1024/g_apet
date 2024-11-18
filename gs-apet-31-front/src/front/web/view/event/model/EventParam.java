package front.web.view.event.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.event.model
* - 파일명		: EventParam.java
* - 작성일		: 2016. 5. 20.
* - 작성자		: jdk
* - 설명		: 이벤트 상세 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class EventParam extends PopParam {
	
	private static final long serialVersionUID = 1L;
	
	private Integer eventGbCd;
	private Integer eventNo;

}
