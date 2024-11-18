package biz.app.goods.model.interfaces;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 51.interface
* - 패키지명		: biz.app.goods.model.interfaces
* - 파일명		: ItemAttributesVO.java
* - 작성일		: 2017. 8. 28.
* - 작성자		: hjko
* - 설명			:
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class ItemAttributesVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long attributeNo;

	private String attributeValue;


}
