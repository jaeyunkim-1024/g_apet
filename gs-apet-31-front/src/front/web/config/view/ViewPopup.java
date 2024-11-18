package front.web.config.view;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.view
* - 파일명		: ViewPopup.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Front Web PopupLayout View 정보
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
@Deprecated
public class ViewPopup extends ViewBase{

	private static final long serialVersionUID = 1L;

	private String 	title;	
}