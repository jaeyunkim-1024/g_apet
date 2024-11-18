package biz.app.promotion.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsBaseSO;
import biz.app.promotion.model.ExhibitionBasePO;
import biz.app.promotion.model.ExhibitionBaseVO;
import biz.app.promotion.model.ExhibitionMainVO;
import biz.app.promotion.model.ExhibitionSO;
import biz.app.promotion.model.ExhibitionThemeGoodsPO;
import biz.app.promotion.model.ExhibitionThemeGoodsSO;
import biz.app.promotion.model.ExhibitionThemeGoodsVO;
import biz.app.promotion.model.ExhibitionThemePO;
import biz.app.promotion.model.ExhibitionThemeSO;
import biz.app.promotion.model.ExhibitionThemeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.dao
* - 파일명		: ExhibitionDao.java
* - 작성일		: 2017. 5. 30.
* - 작성자		: honjung
* - 설명		:
* </pre>
*/
@Repository
public class ExhibitionDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "exhibition.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 13.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 현황
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionMainVO> listExhibitionMainNc(ExhibitionSO so) {
		return selectList(BASE_DAO_PACKAGE + "listExhibitionMainNc", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> pageExhibition(ExhibitionSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhibition", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 31.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public ExhibitionVO getExhibitionBase(ExhibitionSO so) {
		return (ExhibitionVO) selectOne(BASE_DAO_PACKAGE + "getExhibitionBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 31.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트와 기획전 매핑리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StStdInfoVO> getExhibitionStMap(ExhibitionSO so) {
		return selectList(BASE_DAO_PACKAGE + "getExhibitionStMap", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 1.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 등록 수량
	 * </pre>
	 * @param po
	 */
	public int getExhbtThmCnt(ExhibitionSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getExhbtThmCnt", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본정보 등록
	 * </pre>
	 * @param po
	 */
	public int insertExhibitionBase(ExhibitionBasePO po) {
		return update(BASE_DAO_PACKAGE + "insertExhibitionBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본정보 수정
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionBase(ExhibitionBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateExhibitionBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 12.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본정보 수정
	 * 					- 업체 기획전 기본 승인상태 가 반려일 경우 대기로 변경
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionBaseStat30To10(ExhibitionBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateExhibitionBaseStat30To10", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 12.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 상태 일괄 수정
	 * 					- 업체 기획전 상태 일괄 승인/거절, 기획전 전시상태 일괄 변경
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionStateBatch(ExhibitionBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateExhibitionStateBatch", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트와 기획전 매핑 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertStExhibitionMap(ExhibitionBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertStExhibitionMap", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트와 기획전 매핑 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteStExhibitionMap(ExhibitionBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteStExhibitionMap", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 라스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> getExhibitionTheme(ExhibitionThemeSO so) {
		return selectList(BASE_DAO_PACKAGE + "getExhibitionTheme", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> pageExhibitionTheme(ExhibitionThemeSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhibitionTheme", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마정보 등록
	 * </pre>
	 * @param po
	 */
	public int insertExhibitionTheme(ExhibitionThemePO po) {
		return update(BASE_DAO_PACKAGE + "insertExhibitionTheme", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마정보 수정
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionTheme(ExhibitionThemePO po) {
		return update(BASE_DAO_PACKAGE + "updateExhibitionTheme", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeGoodsVO> pageExhibitionThemeGoods(ExhibitionThemeSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhibitionThemeGoods", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 정보 등록 및 저장
	 * </pre>
	 * @param po
	 */
	public int insertUpdateExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		return update(BASE_DAO_PACKAGE + "insertUpdateExhibitionThemeGoods", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 정보 수정
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		return update(BASE_DAO_PACKAGE + "updateExhibitionThemeGoods", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 정보 삭제
	 * </pre>
	 * @param po
	 */
	public int deleteExhibitionThemeGoods(ExhibitionThemeGoodsPO po) {
		return update(BASE_DAO_PACKAGE + "deleteExhibitionThemeGoods", po);
	}





	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 06. 12.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 리스트 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> pageExhibitionFO(ExhibitionSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhibitionFO", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 06. 12.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품상세 기획전
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> listExhibitionByGoods(GoodsBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listExhibitionByGoods", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 06. 12.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 상세 테마 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> listExhibitionTheme(ExhibitionSO so) {
		return selectList(BASE_DAO_PACKAGE + "listExhibitionTheme", so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionDao.java
	 * - 작성일		: 2017. 06. 15.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 상세 테마별 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeGoodsVO> pageExhbtThemeGoodsFO(ExhibitionThemeGoodsSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhbtThemeGoodsFO", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionDao.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 매핑 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveExhibitionTagMap(ExhibitionBasePO po) {
		return insert(BASE_DAO_PACKAGE + "saveExhibitionTagMap", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionDao.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 매핑 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> listExhibitionTagMap(ExhibitionSO so) {
		return selectList(BASE_DAO_PACKAGE + "listExhibitionTagMap", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionDao.java
	 * - 작성일        : 2021. 1. 13.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 매핑 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteExhibitionTagMap(ExhibitionBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteExhibitionTagMap", po);
		
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionDao.java
	 * - 작성일        : 2021. 3. 10.
	 * - 작성자        : YKU
	 * - 설명          :
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> selectExhibitionTheme(ExhibitionThemeSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectExhibitionTheme", so);
	}

	public List<ExhibitionVO> getThemeTitle(ExhibitionSO so) {
		return selectList(BASE_DAO_PACKAGE + "getThemeTitle", so);
	}

	public int countThemeGoods(ExhibitionThemeGoodsSO gso) {
		return selectOne(BASE_DAO_PACKAGE + "countThemeGoods", gso);
	}
}
