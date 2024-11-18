package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.model
 * - 파일명		: LocalPostSO.java
 * - 작성일		: 2017. 6. 1.
 * - 작성자		: Administrator
 * - 설명		: 도서산간 우편번호 검색
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class LocalPostSO extends BaseSearchVO<LocalPostSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 우편번호(신) */
	private String postNoNew;

	/** 우편번호(구) */
	private String postNoOld;

}