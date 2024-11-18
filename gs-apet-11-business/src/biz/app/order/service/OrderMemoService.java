package biz.app.order.service;

import java.util.List;

import biz.app.order.model.OrderMemoPO;
import biz.app.order.model.OrderMemoSO;
import biz.app.order.model.OrderMemoVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service
* - 파일명		: OrderMemoService.java
* - 작성일		: 2017. 1. 11.
* - 작성자		: snw
* - 설명			: 주문 메모 서비스
* </pre>
*/
public interface OrderMemoService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderMemoVO> listOrderMemo(OrderMemoSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 등록
	* </pre>
	* @param po
	*/
	public void insertOrderMemo( OrderMemoPO po );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderMemoService.java
	* - 작성일		: 2017. 1. 11.
	* - 작성자		: snw
	* - 설명			: 주문 메모 수정
	* </pre>
	* @param po
	*/
	public void updateOrderMemo(OrderMemoPO po);
}
