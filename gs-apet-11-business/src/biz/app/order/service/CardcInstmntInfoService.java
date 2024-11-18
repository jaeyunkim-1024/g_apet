package biz.app.order.service;

import java.sql.Timestamp;

import biz.app.order.model.CardcInstmntInfoPO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: CardcInstmntInfoService.java
 * - 작성일		: 2021. 4. 7.
 * - 작성자		: kek01
 * - 설명		: 카드사 할부 정보 서비스
 * </pre>
 */
public interface CardcInstmntInfoService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CardcInstmntInfoService.java
	 * - 작성일		: 2021. 4. 7.
	 * - 작성자		: kek01
	 * - 설명		: 카드사 할부 정보 저장
	 * </pre>
	 * 
	 * @param po
	 * @return count
	 */
	public int mergeCardcInstmntInfo(CardcInstmntInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CardcInstmntInfoService.java
	 * - 작성일		: 2021. 4. 7.
	 * - 작성자		: kek01
	 * - 설명		: 카드사 할부 정보 삭제
	 * </pre>
	 * 
	 * @return count
	 */
	public int deleteCardcInstmntInfo(CardcInstmntInfoPO po);

}
