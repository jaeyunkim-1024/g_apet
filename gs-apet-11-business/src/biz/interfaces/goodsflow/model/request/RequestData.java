package biz.interfaces.goodsflow.model.request;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.request
* - 파일명		: RequestData.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RequestData<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private List<T> items;

}
