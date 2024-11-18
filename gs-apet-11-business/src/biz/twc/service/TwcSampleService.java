package biz.twc.service;

import java.util.List;

import biz.twc.model.TwcSampleVO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.twc.service
 * - 파일명		: TwcSampleService.java
 * - 작성일		: 2021.01.08
 * - 작성자		: KKB
 * - 설명		: TWC 샘플 서비스
 * </pre>
 */

public interface TwcSampleService {

	public List<TwcSampleVO> getHelpKeyword();

}
