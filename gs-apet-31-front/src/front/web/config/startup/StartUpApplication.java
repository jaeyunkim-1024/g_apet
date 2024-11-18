package front.web.config.startup;

import java.util.Properties;

import javax.annotation.PostConstruct;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import biz.common.service.CacheService;

@Slf4j
@Configuration
public class StartUpApplication {

	@Autowired
	private CacheService cacheService;

	@Autowired Properties webConfig;
	
	@PostConstruct
	public void contextInitialized(){
		log.debug("=====================================================");
		log.debug("= {}", "cache Start");
		log.debug("=====================================================");

		cacheService.listCodeCache();

		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		
		cacheService.listDisplayCategoryCache(stId);
		cacheService.initInterestTag();
		
		//cacheService.listExhibitionCache();
		//cacheService.listSeriesCache(dlgtBndNo);
	}

}
