package biz.app.contents.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesPO;
import biz.app.contents.model.SeriesSO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>시리즈 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class SeriesDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "series.";
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 16.
	 * - 작성자		: valueFactory
	 * - 설명			: series 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> pageSeries(SeriesSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageSeries", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 전시상태 일괄 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeriesStat (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "updateSeriesStat", po );
	}
		
		
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeries (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "updateSeries", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeries (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeries", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 history 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeriesHist (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeriesHist", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 tag history 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeriesTagHist (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeriesTagHist", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 첨부파일 history 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeriesFileHist (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeriesFileHist", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 3. 10.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 history 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeasonHist (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeasonHist", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: valueFactory
	 * - 설명			: season 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> pageSeason(SeriesSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageSeason", so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: valueFactory
	 * - 설명			: season 상세 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public SeriesVO getSeasonDetail(SeriesSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getSeasonDetail", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 28.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeason (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "updateSeason", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 28.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertSeason (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "insertSeason", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 28.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 전시상태 일괄 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeasonStat (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "updateSeasonStat", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: season 번호 채번
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public Long getSeasonNo(SeriesSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getSeasonNo", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 29.
	* - 작성자		: valueFactory
	* - 설명			: 첨부파일등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int insertApetAttachFile (ApetAttachFilePO po ) {
		return update(BASE_DAO_PACKAGE + "insertApetAttachFile", po );
	}
		
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 29.
	 * - 작성자		: valueFactory
	 * - 설명			: 첨부파일조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<ApetAttachFileVO> getAttachFiles(SeriesSO so) {
		return selectList(BASE_DAO_PACKAGE + "getAttachFiles", so);
	}

	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 31.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 태그 등록
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeriesTagMap (SeriesPO po ) {
		return update(BASE_DAO_PACKAGE + "updateSeriesTagMap", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2020. 12. 31.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 태그 삭제
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int deleteSeriesTagMap(SeriesPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteSeriesTagMap", po );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명			: 태그조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> getSeriesTagMap(SeriesSO so) {
		return selectList(BASE_DAO_PACKAGE + "getSeriesTagMap", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesDao.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SeriesVO foGetSeries(SeriesSO so) {
		return selectOne(BASE_DAO_PACKAGE + "foGetSeries", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesDao.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foGetSeason(SeriesSO so) {
		return selectList(BASE_DAO_PACKAGE + "foGetSeason", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesDao.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foSeriesList(SeriesSO so){
		return selectList(BASE_DAO_PACKAGE + "foSeriesList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesDao.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foSeasonList(SeriesSO so){
		return selectList(BASE_DAO_PACKAGE + "foSeasonList", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 05. 13.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 삭제
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int deleteSeries (SeriesPO po ) {
		return delete(BASE_DAO_PACKAGE + "deleteSeries", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 05. 13.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 삭제
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int deleteSeason (SeriesPO po ) {
		return delete(BASE_DAO_PACKAGE + "deleteSeason", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: SeriesDao.java
	* - 작성일		: 2021. 06. 04.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 정렬순서(가나다 순) 저장
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeriesSeqSort() {
		return update(BASE_DAO_PACKAGE + "updateSeriesSeqSort");
	}

}
