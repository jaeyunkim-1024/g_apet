package biz.app.estimate.service;

import java.util.List;

import biz.app.estimate.model.EstimateSO;
import biz.app.estimate.model.EstimateVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.estimate.service
* - 파일명		: EstimateService.java
* - 작성일		: 2017. 5. 12.
* - 작성자		: Administrator
* - 설명			: 견적서 서비스 Interface
* </pre>
*/
public interface EstimateService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EstimateService.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 견적서 목록조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EstimateVO> pageEstimate(EstimateSO so );
	
}
