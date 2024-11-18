package biz.interfaces.goodsflow.model.response;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response
* - 파일명		: ResponseError.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ResponseError implements Serializable {

	private static final long serialVersionUID = 1L;

	private String status;

	private String message;

	private String detailMessage;

	private List<Map<String, String>> details;

}
