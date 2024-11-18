package biz.app.display.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.display.dao.DispCornerItemTagDao;
import biz.app.display.model.DispCornerItemTagMapPO;
import biz.app.display.model.DisplayCornerItemPO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class DispCornerItemTagMapServiceImpl implements DispCornerItemTagMapService{
	
	@Autowired
	private DispCornerItemTagDao dispCornerItemTagMapDao;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DisplayServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 전시 코너 아이템 태그 등록
	* </pre>
	*
	* @param po
	*/

	@Override
	public int insertDispCornerItemTag(DispCornerItemTagMapPO po) {
		return dispCornerItemTagMapDao.insertDispCornerItemTag(po);
	}

	@Override
	public int deleteDispCornItemTag(DisplayCornerItemPO po) {
		return dispCornerItemTagMapDao.deleteDispCornItemTag(po);
	}

}
