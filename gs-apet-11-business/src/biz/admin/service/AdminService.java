package biz.admin.service;

import java.util.List;

import biz.admin.model.GoodsMainVO;
import biz.admin.model.OrderMainVO;
import biz.admin.model.SalesStateMainVO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.service
 * - 파일명		: OrderService.java
 * - 작성일		: 2017. 1. 17.
 * - 작성자		: snw
 * - 설명			: 관리자 서비스
 * </pre>
 */

public interface AdminService {


	public List<SalesStateMainVO> listSalesStateMain();

	public List<OrderMainVO> listOrderMain();

	public List<OrderMainVO> listOrderMainNc();

	public List<OrderMainVO> listClaimMain();

	public List<OrderMainVO> listClaimMainNc();

	public List<GoodsMainVO> listGoodsMain();

	public List<GoodsMainVO> listGoodsMainNc();

}
