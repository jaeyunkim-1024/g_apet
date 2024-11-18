package batch.config.startup;

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

	@PostConstruct
	public void contextInitialized(){
		log.debug("=====================================================");
		log.debug("= {}", "cache Start");
		log.debug("=====================================================");

		cacheService.listCodeCache();
		cacheService.initInterestTag();
	}

}
