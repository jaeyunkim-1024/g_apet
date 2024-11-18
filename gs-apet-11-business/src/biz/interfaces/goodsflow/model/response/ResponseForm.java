package biz.interfaces.goodsflow.model.response;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response
* - 파일명		: ResponseForm.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ResponseForm<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	private boolean success;

	private String context;

	private ResponseData<T> data;

	private ResponseError error;

}
