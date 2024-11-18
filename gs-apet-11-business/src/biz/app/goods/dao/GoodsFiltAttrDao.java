package biz.app.goods.dao;

import biz.app.goods.model.GoodsFiltAttrPO;
import biz.app.goods.model.GoodsFiltAttrSO;
import biz.app.goods.model.GoodsFiltAttrVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GoodsFiltAttrDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "goodsFiltAttr.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltAttrDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 속성 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertFiltAttr(GoodsFiltAttrPO po){
		return insert(BASE_DAO_PACKAGE + "filtAttrInsert", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltAttrDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 속성 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateFiltAttr(GoodsFiltAttrPO po){
		return update(BASE_DAO_PACKAGE + "filtAttrUpdate", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltAttrDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 속성 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteFiltAttr(GoodsFiltAttrPO po){
		return delete(BASE_DAO_PACKAGE + "filtAttrDelete", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltAttrDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 속성 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltAttrVO> getFiltAttrList(GoodsFiltAttrSO so){
		return selectList(BASE_DAO_PACKAGE + "getFiltAttrList", so );
	}
	public GoodsFiltAttrVO getFiltAttrInfo(GoodsFiltAttrSO so){
		return selectOne(BASE_DAO_PACKAGE + "getFiltAttrInfo", so );
	}

}
