package biz.app.display.dao;

import org.springframework.stereotype.Repository;


import biz.app.display.model.DispCornerItemTagMapPO;
import biz.app.display.model.DisplayCornerItemPO;
import biz.app.display.model.DisplayTemplatePO;
import framework.common.dao.MainAbstractDao;

@Repository
public class DispCornerItemTagDao extends MainAbstractDao{

	/**
	 * <pre>
	 * - Method 명	: insertDispCornerItemTag
	 * - 작성일		: 2020. 04. 07.
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템 태그 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDispCornerItemTag(DispCornerItemTagMapPO po) {
		return insert("dispCornerItemTagMap.insertDispCornerItemTag", po);
	}
	
	/**
	 * <pre>
	 * - Method 명	: deleteDispCornItemTag
	 * - 작성일		: 2020. 04. 07.
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템 태그 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDispCornItemTag(DisplayCornerItemPO po) {
		return delete("dispCornerItemTagMap.deleteDispCornItemTag", po);
	}
}
