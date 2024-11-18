package biz.app.promotion.service;

import java.util.List;

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

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface ExhibitionService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 13.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 현황
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionMainVO> listExhibitionMainNc(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> pageExhibition(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 31.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public ExhibitionVO getExhibitionBase(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 31.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트와 기획전 매핑리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StStdInfoVO> getExhibitionStMap(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 1.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 등록 수량
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getExhbtThmCnt(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기회전 기본 등록
	 * </pre>
	 * @param po
	 */
	public void insertExhibitionBase(ExhibitionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: hongjun
	 * - 설명		: 기회전 기본 수정
	 * </pre>
	 * @param po
	 */
	public void updateExhibitionBase(ExhibitionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 12.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 기본정보 수정
	 * 					- 업체 기획전 기본 승인상태 가 반려일 경우 대기로 변경
	 * </pre>
	 * @param po
	 */
	public void updateExhibitionBaseStat30To10(ExhibitionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 12.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 상태 일괄 수정
	 * 					- 업체 기획전 상태 일괄 승인/거절, 기획전 전시상태 일괄 변경
	 * </pre>
	 * @param po
	 */
	public int updateExhibitionStateBatch(ExhibitionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> getExhibitionTheme(ExhibitionThemeSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> pageExhibitionTheme(ExhibitionThemeSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 등록
	 * </pre>
	 * @param po
	 */
	public void insertExhibitionTheme(ExhibitionThemePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 수정
	 * </pre>
	 * @param po
	 */
	public void updateExhibitionTheme(ExhibitionThemePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeGoodsVO> pageExhibitionThemeGoods(ExhibitionThemeSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 등록 및 저장
	 * </pre>
	 * @param po
	 */
	public int insertUpdateExhibitionThemeGoods(ExhibitionThemeGoodsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 수정
	 * </pre>
	 * @param po
	 */
	public void updateExhibitionThemeGoods(ExhibitionThemeGoodsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 6. 8.
	 * - 작성자		: hongjun
	 * - 설명		: 기획전 테마 상품 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteExhibitionThemeGoods(ExhibitionThemeGoodsPO po);


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 리스트 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> pageExhibitionFO(ExhibitionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 5. 30.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품상세 기획전
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> listExhibitionByGoods(GoodsBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 06. 12.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 상세 테마 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> listExhibitionTheme(ExhibitionSO so);


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ExhibitionService.java
	 * - 작성일		: 2017. 06. 15.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 기획전 상세 테마별 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeGoodsVO> pageExhbtThemeGoodsFO(ExhibitionThemeGoodsSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionService.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 매핑 저장
	 * </pre>
	 * @param po
	 */
	public void saveExhibitionTagMap(ExhibitionBasePO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionService.java
	 * - 작성일        : 2021. 1. 12.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 태그 매핑 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionVO> listExhibitionTagMap(ExhibitionSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionService.java
	 * - 작성일        : 2021. 3. 10.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 테마 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ExhibitionThemeVO> selectExhibitionTheme(ExhibitionThemeSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : ExhibitionService.java
	 * - 작성일        : 2021. 3. 11.
	 * - 작성자        : YKU
	 * - 설명          : 일반/특별 기획전
	 * </pre>
	 * @param so
	 * @param stId
	 * @param deviceGb
	 * @return
	 */
	List<ExhibitionVO> selectPageExhibitionFO(ExhibitionSO so, Long stId, String deviceGb);

	public List<ExhibitionVO> getThemeTitle(ExhibitionSO so);

	public int countThemeGoods(ExhibitionThemeGoodsSO gso);
}