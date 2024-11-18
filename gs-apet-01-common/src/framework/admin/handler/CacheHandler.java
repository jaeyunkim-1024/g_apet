package framework.admin.handler;

import java.util.List;

import javax.annotation.PostConstruct;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

public class CacheHandler {

	private CacheManager cacheManager;

	private Ehcache cache;

	private String cacheName;

	@SuppressWarnings("unused")
	public boolean put(String key, Object value) {
		Element element = new Element(key, value);
		try {
			cache.put(element);
		} catch (Exception ex) {
			throw new CustomException(ExceptionConstants.ERROR_CACHE);
		}
		return true;
	}

	public Element getElement(String key) {
		return cache.get(key);
	}

	public Object getValue(String key) {
		Element element = cache.get(key);
		if (element == null) {
			return null;
		}
		return element.getObjectValue();
	}

	public boolean replace(String key, Object value) {
		Element element = new Element(key, value);
		cache.replace(element);
		return true;
	}

	public Ehcache getCache() {
		return cache;
	}

	/**
	 * 의존성 주입 완료 후 cacheName으로 cache 객체 조회해서 참조
	 */
	@SuppressWarnings("unused")
	@PostConstruct
	public void setCache() {
		try {
			cache = cacheManager.getEhcache(cacheName);
		} catch (Exception ex) {
			throw new CustomException(ExceptionConstants.ERROR_CACHE);
		}
	}

	public void setCacheManager(CacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	public void setCacheName(String cacheName) {
		this.cacheName = cacheName;
	}
	
	public void initCache(String prefix) {
		List keyList = cache.getKeys();
		for(Object key:keyList) {
			if(key.toString().startsWith(prefix)) {
				cache.remove(key);	
			}
		}
		
	}
}
