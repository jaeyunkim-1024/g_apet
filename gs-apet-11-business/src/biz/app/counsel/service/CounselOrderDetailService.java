package biz.app.counsel.service;

import java.util.List;

import biz.app.counsel.model.CounselOrderDetailVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.service
* - 파일명		: CounselOrderDetailService.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 상담 주문 상세 서비스 Interface
* </pre>
*/
public interface CounselOrderDetailService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselOrderDetailService.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: Administrator
	* - 설명			: 상담 주문 목록 조회
	* </pre>
	* @param cusNo
	* @return
	*/
	public List<CounselOrderDetailVO> listCounselOrderDetail(Long cusNo);

}