package biz.interfaces.goodsflow.model.response;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response
* - 파일명		: ResponseData.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ResponseData<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private int totalItems;

	private List<T> items;

}
