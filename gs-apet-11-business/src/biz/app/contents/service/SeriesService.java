package biz.app.contents.service;

import java.util.List;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesPO;
import biz.app.contents.model.SeriesSO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: SeriesService.java
 * - 작성자		: valueFactory
 * - 설명		: 시리즈 Service
 * </pre>
 */
public interface SeriesService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: SeriesService.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> pageSeries(SeriesSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SeriesService.java
	* - 작성일		: 2020. 12. 22.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 전시상태 일괄 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeriesStat(List<SeriesPO> seriesPOList);
		
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SeriesService.java
	* - 작성일		: 2020. 12. 22.
	* - 작성자		: valueFactory
	* - 설명			: 시리즈 등록/수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeries(SeriesPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: SeriesService.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> pageSeason(SeriesSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: SeriesService.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 상세 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public SeriesVO getSeasonDetail(SeriesSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SeriesService.java
	* - 작성일		: 2020. 12. 28.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 등록/수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeason(SeriesPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SeriesService.java
	* - 작성일		: 2020. 12. 28.
	* - 작성자		: valueFactory
	* - 설명			: 시즌 전시상태 일괄 수정
	* </pre>
	* @param SeriesPO
	* @return
	*/
	public int updateSeasonStat(List<SeriesPO> seriesPOList);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: SeriesService.java
	 * - 작성일		: 2020. 12. 29.
	 * - 작성자		: valueFactory
	 * - 설명			: 첨부파일조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<ApetAttachFileVO> getAttachFiles(SeriesSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
 	 * - 파일명		: SeriesService.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 태그 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> getSeriesTagMap(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SeriesVO foGetSeries(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 1. 27.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 상세조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foGetSeason(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시리즈 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foSeriesList(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 1. 28.
	 * - 작성자        : YKU
	 * - 설명          : FO시즌 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> foSeasonList(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 05. 13.
	 * - 작성자        : kwj
	 * - 설명          : 시리즈 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteSeries(List<SeriesPO> seriesPOList);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : SeriesService.java
	 * - 작성일        : 2021. 05. 13.
	 * - 작성자        : kwj
	 * - 설명          : 시즌 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteSeason(List<SeriesPO> seriesPOList);
}