package biz.interfaces.goodsflow.model.request;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.request
* - 파일명		: RequestForm.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RequestForm<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private RequestData<T> data;

}
