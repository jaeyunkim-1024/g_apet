package biz.app.order.service;

import biz.app.order.model.OrdSavePntPO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: OrdSavePntService.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 주문 적립 포인트 서비스
 * </pre>
 */
/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: OrdSavePntService.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 
 * </pre>
 */
public interface OrdSavePntService {
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 GS 포인트 지급
	 * </pre>
	 * @param po
	 */
	public void accumOrdGsPoint(OrdSavePntPO po);
	//public void accumOrdGsPoint(GsPntHistPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.service
	 * - 작성일		: 2021. 03. 15.
	 * - 작성자		: JinHong
	 * - 설명		: 주문 GS 포인트 재지급
	 * </pre>
	 * @param po
	 */
	public void accumReOrdGsPoint(OrdSavePntPO po);
	//public void accumReOrdGsPoint(GsPntHistPO po);
	
	
	
}
