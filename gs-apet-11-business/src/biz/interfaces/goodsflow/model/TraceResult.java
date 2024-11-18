package biz.interfaces.goodsflow.model;

import java.io.Serializable;
import java.util.List;

import biz.interfaces.goodsflow.model.response.data.TraceVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model
* - 파일명		: TraceResult.java
* - 작성일		: 2017. 7. 21.
* - 작성자		: WilLee
* - 설명		:
* </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TraceResult implements Serializable {

	private static final long serialVersionUID = 1L;

	private String status;

	private List<TraceVO> items;
	
	/* 전체건수 */
	private Long total;
	/* 성공건수 */
	private Long success;
	/* 실패 건수 */
	private Long fail;
	
	

}
