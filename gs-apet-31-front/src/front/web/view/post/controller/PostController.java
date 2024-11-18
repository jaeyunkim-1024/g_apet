package front.web.view.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewPopup;
import front.web.view.post.model.PostParam;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.post.controller
* - 파일명		: PostController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 우편번호 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("post")
public class PostController {

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PostController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: Daum 우편번호 검색 팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="popupDaumPost")
	public String popupDaumPost(ModelMap map, Session session, ViewBase view, PostParam param){

		view.setTitle(message.getMessage("front.web.view.post.popup.title"));
		
		map.put("view", view);
		map.put("param", param);
		
		return TilesView.popup(
				new String[]{ "common", "post", "popupDaumPost"}
				);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PostController.java
	 * - 작성일		: 2021. 1. 4.
	 * - 작성자		: LDS
	 * - 설명			: 행정안전부 우편번호 검색 팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="popupMoisPost")
	public String popupMoisPost(ModelMap map, Session session, ViewBase view, PostParam param){

		view.setTitle(message.getMessage("front.web.view.post.popup.title"));
		
		map.put("view", view);
		map.put("param", param);
		
		//return TilesView.popup(new String[]{ "common", "post", "popupDaumPost"});
		
		return "common/post/popupMoisPost";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: PostController.java
	 * - 작성일		: 2021. 1. 4.
	 * - 작성자		: LDS
	 * - 설명			: 행정안전부 우편번호 검색 팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="popupGsPostSearch")
	public String popupGsPostSearch(ModelMap map, Session session, ViewBase view, PostParam param){

		view.setTitle(message.getMessage("front.web.view.post.popup.title"));

		map.put("view", view);
		map.put("param", param);

		//return TilesView.popup(new String[]{ "common", "post", "popupDaumPost"});

		return "common/post/popupGsPostSearch";
	}

}