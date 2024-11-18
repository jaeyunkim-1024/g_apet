package front.web.view.bamboo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.bamboo.service.BambooService;
import front.web.config.tiles.TilesView;
import lombok.extern.slf4j.Slf4j;


@Controller
public class BambooController {
	
	@Autowired
	private BambooService bambooService;
	
	@RequestMapping(value="bamboo")
	public String getSelectBamboo(ModelMap map) {

		String bamboo = bambooService.getSelectBamboo();
		map.put("bamboo", bamboo);
		
		return TilesView.none(new String[]{"bamboo", "bambooView"});
	}

}
