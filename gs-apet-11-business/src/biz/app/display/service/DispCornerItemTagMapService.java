package biz.app.display.service;

import biz.app.display.model.DispCornerItemTagMapPO;
import biz.app.display.model.DisplayCornerItemPO;

public interface DispCornerItemTagMapService {
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 태그 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDispCornerItemTag(DispCornerItemTagMapPO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 태그 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDispCornItemTag(DisplayCornerItemPO po);
}
