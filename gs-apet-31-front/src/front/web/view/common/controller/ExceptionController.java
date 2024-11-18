package front.web.view.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import framework.common.constants.ExceptionConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 31.front.web
 * - 패키지명		: front.web.view.common.controller
 * - 파일명			: ExceptionController.java
 * - 작성일			: 2021. 3. 15. 
 * - 작성자			: KSH
 * - 설 명			: Class level @RequestMapping 은 정의하지 않음.
 * 							내부 Forwarding 목적
 * </pre>
 */
@Slf4j
@Controller
public class ExceptionController {
	
	@Autowired
	private MessageSourceAccessor message;

	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "error/500/", method = { RequestMethod.GET, RequestMethod.POST })
	public String error(ModelMap map, ViewBase view, Session session) {
		map.put("session", session);
		map.put("view", view);
		map.put("exMsg", "잠시 문제가 생겨 페이지를 표시하지 못했습니다. <br>잠시 후 다시 접속해주세요.");
		map.put("exMessage", message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_SERVER_ERROR));
		return FrontWebConstants.EXCEPTION_VIEW_NAME;
	}

	@ResponseStatus(HttpStatus.NOT_FOUND)
	@RequestMapping(value = "error/404/", method = { RequestMethod.GET, RequestMethod.POST })
	public String notFound(ModelMap map, ViewBase view, Session session, HttpServletRequest request) {
		map.put("session", session);
		map.put("view", view);
		map.put("exMessage", message.getMessage(FrontWebConstants.EXCEPTION_MESSAGE_COMMON + ExceptionConstants.ERROR_NOT_FOUND));
		return TilesView.layout("common/exception", new String[]{ "error404"});
	}

	@ResponseStatus(HttpStatus.FORBIDDEN)
	@RequestMapping(value = "error/403/", method = { RequestMethod.GET, RequestMethod.POST })
	public String forbidden(ModelMap map, ViewBase view, Session session, HttpServletRequest request) {
		map.put("session", session);
		map.put("view", view);
		return FrontWebConstants.FORBIDDEN_VIEW_NAME;
	}

}
