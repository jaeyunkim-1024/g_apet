package biz.app.search.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.search.model.SearchSO;
import biz.app.search.model.ShopDbGoodsVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class SearchDao extends MainAbstractDao {
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: SearchDao.java
	 * - 작성일	: 2021. 03. 19.
	 * - 작성자	: KKB
	 * - 설명	: 검색 상품의 추가적인 정보 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ShopDbGoodsVO> getListGoods(SearchSO so) {
		return selectList("search.listGoods", so);
	}	
}