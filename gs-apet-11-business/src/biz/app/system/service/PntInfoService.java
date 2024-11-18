package biz.app.system.service;

import java.util.List;

import biz.app.system.model.PntInfoPO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.system.service
 * - 파일명		: PntInfoService.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 포인트 Service
 * </pre>
 */
/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.system.service
 * - 파일명		: PntInfoService.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 
 * </pre>
 */
public interface PntInfoService {

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.service
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 페이지 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PntInfoVO> pagePntInfo(PntInfoSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.service
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public PntInfoVO getPntInfo(PntInfoSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.service
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 등록
	 * </pre>
	 * @param po
	 */
	public void insertPntInfo(PntInfoPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.service
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 수정
	 * </pre>
	 * @param po
	 */
	public void updatePntInfo(PntInfoPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.system.service
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: JinHong
	 * - 설명		: 포인트 유효성 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getValidCount(PntInfoSO so);

}