package front.web.config.view;

import java.util.LinkedHashMap;
import java.util.List;

import biz.app.display.model.DisplayBannerVO;
import biz.common.model.BankBookVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.view
* - 파일명		: ViewSub.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Front Web SubLayout View 정보
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@Deprecated
public class ViewGoods extends ViewBase {

	private static final long serialVersionUID = 1L;

	private String[]	navigation;
	private LinkedHashMap<Long,String> cateNavigation;

	
}