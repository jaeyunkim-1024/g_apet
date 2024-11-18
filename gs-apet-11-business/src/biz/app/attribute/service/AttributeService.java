package biz.app.attribute.service;


import java.util.List;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.attribute.service
* - 파일명		: AttributeService.java
* - 작성일		: 2017. 2. 6.
* - 작성자		: snw
* - 설명			: 속성 서비스 Interface
* </pre>
*/
public interface AttributeService {

	/**
	 * 속성 추가
	 * @param po
	 * @return
	 */
	Long insertNewAttribute(AttributePO po);


	/**
	 * 추가하려는 속성이 존재하는지 체크
	 */
	List<AttributeVO> checkAttributeExist(AttributePO po);

}
