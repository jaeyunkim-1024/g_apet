package biz.app.st.service;

import java.util.List;

 
import biz.app.st.model.StPolicyPO;
import biz.app.st.model.StPolicySO;
import biz.app.st.model.StPolicyVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.st.service
* - 파일명		: StService.java
* - 작성일		: 2017. 1. 2.
* - 작성자		: hongjun
* - 설명		: 사이트 서비스 Interface
* </pre>
*/
public interface StService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 2. 24.
	* - 작성자		: snw
	* - 설명			: 사이트 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	List<StStdInfoVO> listStStdInfo(StStdInfoSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 등록
	* </pre>
	* @param po
	* @return
	*/
	public Long insertSt (StStdInfoPO stStdInfoPO);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 조회 [BO]
	* </pre>
	* @param bndNo
	* @return
	*/
	public StStdInfoVO getStStdInfo (Long stId);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: stService.java
	* - 작성일		: 2017. 1. 2.
	* - 작성자		: hongjun
	* - 설명			: 사이트 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<StStdInfoVO> pageStStdInfo (StStdInfoSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 3.
	* - 작성자		: hongjun
	* - 설명			: 사이트 수정
	* </pre>
	* @param stStdInfoPO
	* @param orgLogoImgPath
	* @return
	*/
	public Long updateSt (StStdInfoPO stStdInfoPO, String orgLogoImgPath);

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: hjko
	* - 설명		:  조건으로 사이트 목록 조회 
	* </pre>
	* @param so
	* @return
	 */
	public List<StStdInfoVO> getStList(StStdInfoSO so);
	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StService.java
	* - 작성일      : 2017. 4. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 시스템 관리 > 사이트 관리 > 사이트 목록   > 사이트 상세 > 사이트 정책 목록
	* </pre>
	 */
	public List<StPolicyVO> listStPolicy(StPolicySO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StService.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 등록 팝업 
	* </pre>
	 */
	public StPolicyVO getStPolicy(StPolicySO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StService.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 저장 
	* </pre>
	 */
	public void stPolicySave(StPolicyPO po);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StService.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책  삭제 
	* </pre>
	 */
	public void stPolicyDelete(StPolicySO so);
	
	
	
}