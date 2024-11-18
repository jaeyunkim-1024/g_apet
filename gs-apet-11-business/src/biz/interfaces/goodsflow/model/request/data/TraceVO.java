package biz.interfaces.goodsflow.model.request.data;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response.data
* - 파일명		: TraceVO.java
* - 작성일		: 2017. 6. 23.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TraceVO implements Serializable {

	private static final long serialVersionUID = 1L;

	// 고객사용번호(3) : 요청시 사용한 상품고유번호(Key)
	private String transUniqueCode;
	
	// 고객사용번호(2) : 요청시 사용한 상품고유번호(Key)
	private String itemUniqueCode;

	// 일련번호 : 배송결과에서 받는 순서
	private Integer seq;

}
