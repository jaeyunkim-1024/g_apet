package biz.app.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.CardcInstmntInfoDao;
import biz.app.order.model.CardcInstmntInfoPO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: CardcInstmntInfoServiceImpl.java
 * - 작성일		: 2021. 4. 7.
 * - 작성자		: kek01
 * - 설명		: 카드사 할부 정보 서비스 Impl
 * </pre>
 */
@Slf4j
@Service("cardcInstmntInfoService")
@Transactional
public class CardcInstmntInfoServiceImpl implements CardcInstmntInfoService {

	@Autowired private CardcInstmntInfoDao cardcInstmntInfoDao;

	/*
	 * 카드사 할부 정보 저장
	 * @see
	 * biz.app.order.service.CardcInstmntInfoService#mergeCardcInstmntInfo(CardcInstmntInfoPO po)
	 */
	@Override
	public int mergeCardcInstmntInfo(CardcInstmntInfoPO po) {
		return cardcInstmntInfoDao.mergeCardcInstmntInfo(po);
	}

	/*
	 * 카드사 할부 정보 삭제
	 * @see
	 * biz.app.order.service.CardcInstmntInfoService#deleteCardcInstmntInfo()
	 */
	@Override
	public int deleteCardcInstmntInfo(CardcInstmntInfoPO po) {
		return cardcInstmntInfoDao.deleteCardcInstmntInfo(po);
	}

}
