package framework.common.dao;

import framework.admin.util.AdminSessionUtil;
import framework.batch.util.BatchSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;
import framework.common.util.StringUtil;
import framework.front.util.FrontSessionUtil;
import framework.interfaces.util.InterfaceSessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.cache.Cache;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.locks.Lock;

@Slf4j
public class MainAbstractDao {

	private static final String SUFFIX_COUNT_QUERY = "Count";

	@Autowired 
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate mainSqlSessionTemplate;

	@Resource(name="bulkSqlSessionTemplate")
	private SqlSessionTemplate bulkSqlSessionTemplate;

	@Autowired private Properties webConfig;

	/**
	 * <pre>페이징 select List</pre>
	 * 
	 * @param statement
	 * @param vo
	 * @return
	 */
	public <E> List<E> selectListPage(String statement, BaseSearchVO<?> vo) {
		log.info("##### {}", statement);
		
		// 현재 페이지 번호 초기화
		if (vo.getPage() == 0) {
			vo.setPage(1);
		}

		// 카운트 조회
		int total = countByParam(statement + SUFFIX_COUNT_QUERY, vo);

		vo.setTotalCount(total);

		vo.setLimit((vo.getPage() - 1) * vo.getRows() + vo.getStartOffset());
		vo.setOffset(vo.getRows());

		vo.setStartIndex(((vo.getPage() - 1) * vo.getRows()) + 1);
		vo.setEndIndex(((vo.getPage() - 1) * vo.getRows()) + vo.getRows());

		if (StringUtil.isNotBlank(vo.getSidx())) {
			vo.setSidx(StringUtil.toUnCamelCase(vo.getSidx()).toUpperCase());
		}

		return mainSqlSessionTemplate.selectList(statement, vo);
	}

	/**
	 * <pre>페이징에 필요한 카운트 쿼리 조회</pre>
	 * 
	 * @param statement
	 * @param baseSearchVO
	 * @return
	 */
	private int countByParam(String statement, BaseSearchVO<?> baseSearchVO) {
		Object resultObj = mainSqlSessionTemplate.selectOne(statement, baseSearchVO);
		if (resultObj instanceof Number) {
			Number number = (Number) resultObj;
			return number.intValue();
		} else {
			log.error("count by param error");
			throw new IllegalArgumentException(String.format(
					"Wrong resultClass type(%s) with queryId:%s, resultClass must be subclass of java.lang.Number",
					resultObj.getClass().getName(), statement));
		}
	}

	public <T> T selectOne(String statement) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectOne(statement);
	}

	public <T> T selectOne(String statement, Object parameter) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectOne(statement, parameter);
	}

	public <K, V> Map<K, V> selectMap(String statement, String mapKey) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectMap(statement, mapKey);
	}

	public <K, V> Map<K, V> selectMap(String statement, Object parameter, String mapKey) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectMap(statement, parameter, mapKey);
	}

	public <K, V> Map<K, V> selectMap(String statement, Object parameter, String mapKey, RowBounds rowBounds) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectMap(statement, parameter, mapKey, rowBounds);
	}

	public <E> List<E> selectList(String statement) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectList(statement);
	}

	public <E> List<E> selectList(String statement, Object parameter) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectList(statement, parameter);
	}

	public <E> List<E> selectList(String statement, BaseSearchVO<?> vo) {
		log.info("##### {}", statement);
		if (StringUtil.isNotBlank(vo.getSidx())) {
			vo.setSidx(StringUtil.toUnCamelCase(vo.getSidx()).toUpperCase());
		}

		return mainSqlSessionTemplate.selectList(statement, vo);
	}

	public <E> List<E> selectList(String statement, Object parameter, RowBounds rowBounds) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.selectList(statement, parameter, rowBounds);
	}

	public void select(String statement, ResultHandler handler) {
		log.info("##### {}", statement);
		mainSqlSessionTemplate.select(statement, handler);
	}

	public void select(String statement, Object parameter, ResultHandler handler) {
		log.info("##### {}", statement);
		mainSqlSessionTemplate.select(statement, parameter, handler);
	}

	public void select(String statement, Object parameter, RowBounds rowBounds, ResultHandler handler) {
		log.info("##### {}", statement);
		mainSqlSessionTemplate.select(statement, parameter, rowBounds, handler);
	}

	public int insert(String statement) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.insert(statement);
	}

	public int insert(String statement, Object parameter) {
		log.info("##### {}", statement);
		if (parameter instanceof BaseSysVO) {
			BaseSysVO vo = (BaseSysVO) parameter;
			if ( vo.getSysRegrNo() == null || vo.getSysUpdrNo() == null) {
				if (CommonConstants.PROJECT_GB_ADMIN.equals(this.webConfig.getProperty("project.gb"))) {
					AdminSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_FRONT.equals(this.webConfig.getProperty("project.gb"))) {
					FrontSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_BATCH.equals(this.webConfig.getProperty("project.gb"))) {
					BatchSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_INTERFACE.equals(this.webConfig.getProperty("project.gb"))) {
					InterfaceSessionUtil.setSysInfo(parameter);
				}
			}
		}

		return mainSqlSessionTemplate.insert(statement, parameter);
	}

	public int update(String statement) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.update(statement);
	}

	public int update(String statement, Object parameter) {
		log.info("##### {}", statement);
		if (parameter instanceof BaseSysVO) {
			BaseSysVO vo = (BaseSysVO) parameter;
			if (vo.getSysRegrNo() == null || vo.getSysUpdrNo() == null) {
				if (CommonConstants.PROJECT_GB_ADMIN.equals(this.webConfig.getProperty("project.gb"))) {
					AdminSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_FRONT.equals(this.webConfig.getProperty("project.gb"))) {
					FrontSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_BATCH.equals(this.webConfig.getProperty("project.gb"))) {
					BatchSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_INTERFACE.equals(this.webConfig.getProperty("project.gb"))) {
					InterfaceSessionUtil.setSysInfo(parameter);
				}
			}
		}
		return mainSqlSessionTemplate.update(statement, parameter);
	}

	public int delete(String statement) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.delete(statement);
	}

	public int delete(String statement, Object parameter) {
		log.info("##### {}", statement);
		return mainSqlSessionTemplate.delete(statement, parameter);
	}

	public void cacheClear() {
		Configuration configuration = mainSqlSessionTemplate.getConfiguration();
		Collection<Cache> caches = configuration.getCaches();
		for (Cache cache : caches) {
			Lock w = cache.getReadWriteLock().writeLock();
			w.lock();
			try {
				cache.clear();
			} finally {
				w.unlock();
			}
		}
	}

	public int insert_batch(String statement,Object parameter){
		setSysInfo(parameter);
		return bulkSqlSessionTemplate.insert(statement , parameter);
	}
	public int delete_batch(String statement,Object parameter){
		setSysInfo(parameter);
		return bulkSqlSessionTemplate.delete(statement , parameter);
	}
	public int update_batch(String statement,Object parameter){
		setSysInfo(parameter);
		return bulkSqlSessionTemplate.update(statement , parameter);
	}

	private void setSysInfo(Object parameter){
		if (parameter instanceof BaseSysVO) {
			BaseSysVO vo = (BaseSysVO) parameter;
			if ( vo.getSysRegrNo() == null || vo.getSysUpdrNo() == null) {
				if (CommonConstants.PROJECT_GB_ADMIN.equals(this.webConfig.getProperty("project.gb"))) {
					AdminSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_FRONT.equals(this.webConfig.getProperty("project.gb"))) {
					FrontSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_BATCH.equals(this.webConfig.getProperty("project.gb"))) {
					BatchSessionUtil.setSysInfo(parameter);
				} else if (CommonConstants.PROJECT_GB_INTERFACE.equals(this.webConfig.getProperty("project.gb"))) {
					InterfaceSessionUtil.setSysInfo(parameter);
				}
			}
		}
	}

}
