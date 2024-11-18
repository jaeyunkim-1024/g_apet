package biz.app.adjustment.service;

import java.util.List;

import biz.app.adjustment.model.AdjustmentSO;
import biz.app.adjustment.model.AdjustmentVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app
* - 파일명		: AdjustmentService.java
* - 작성일		: 2016. 8. 31.
* - 작성자		: valueFactory
* - 설명			:
* </pre>
*/
public interface AdjustmentService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentService.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listCompAdjustmentDtl (AdjustmentSO adjustmentSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentService.java
	* - 작성일		: 2016. 8. 31.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listCompAdjustment (AdjustmentSO adjustmentSO );



	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentService.java
	* - 작성일		: 2016. 9. 3.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listPageAdjustment (AdjustmentSO adjustmentSO );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: AdjustmentService.java
	* - 작성일		: 2016. 9. 3.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param adjustmentSO
	* @return
	*/
	public List<AdjustmentVO> listPageAdjustmentDtl (AdjustmentSO adjustmentSO );

}
