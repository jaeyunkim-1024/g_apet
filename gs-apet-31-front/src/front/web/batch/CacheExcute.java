package front.web.batch;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import biz.common.service.CacheService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CacheExcute {

	@Autowired
	private CacheService cacheService;

	@Autowired
	private Properties webConfig;
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: DisplayExcute.java
	* - 작성일		: 2016. 6. 23.
	* - 작성자		: snw
	* - 설명		: 전시 카테고리 캐쉬 목록 리로드 
	* </pre>
	*/
	@Scheduled(cron = "0 0,10,20,30,40,50 * * * *")
	public void reloadDisplayCategory(){
		Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
		log.debug(">>>>>>>>>>>>카테고리 리로드");
		this.cacheService.listDisplayCategoryCacheRefresh(stId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: DisplayExcute.java
	* - 작성일		: 2016. 6. 23.
	* - 작성자		: snw
	* - 설명		: Header 기획전 캐쉬 목록 리로드
	* </pre>
	*/
	@Scheduled(cron = "0 0,10,20,30,40,50 * * * *")
	public void reloadExhibition(){
		//this.cacheService.listExhibitionCacheRefresh();
		log.info("reloadExhibition");
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: DisplayExcute.java
	* - 작성일		: 2016. 6. 23.
	* - 작성자		: snw
	* - 설명		: 공통코드 캐쉬 목록 리로드
	* </pre>
	*/
	@Scheduled(cron = "0 10 0,3,6,9,12,15,18,21 * * *")
	public void reloadCode(){
		this.cacheService.listCodeCacheRefresh();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CacheExcute.java
	* - 작성일		: 2016. 7. 26.
	* - 작성자		: snw
	* - 설명		: 시리즈 목록 조회
	* </pre>
	*/
	@Scheduled(cron = "0 20 0,3,6,9,12,15,18,21 * * *")
	public void reloadBrandSeries(){
		//Integer dlgtBndNo = Integer.valueOf(this.webConfig.getProperty("site.main.brand.no"));
		//this.cacheService.listSeriesCacheRefresh(dlgtBndNo);
		log.info("reloadBrandSeries");
	}
}
