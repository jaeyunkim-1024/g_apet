package biz.app.display.service;

import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;

/**
 * get업무명	:	단건
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.display.service
 * - 파일명		: SeoService.java
 * - 작성일		: 2020. 12. 24.
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
public interface SeoService {
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeoService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 조회
	 * </pre>
	 * @param list
	 */
	public SeoInfoVO getSeoInfo(SeoInfoSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeoService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 등록/수정
	 * </pre>
	 * @param list
	 */
	public int saveSeoInfo(SeoInfoPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: SeoService.java
	 * - 작성일		: 2021. 2. 1. 
	 * - 작성자		: YJU
	 * - 설명			: SEO 정보 조회(FO)
	 * </pre>
	 * @param seoSO
	 * @param secretYn
	 * @return
	 */
	public SeoInfoVO getSeoInfoFO(SeoInfoSO seoSO, boolean secretYn);
}
