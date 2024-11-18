package biz.admin.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String name;
	private Long cnt01;
	private Long cnt02;
	private Long cnt03;
	private Long cnt04;
	private Long cnt05;
	private Long cnt06;
	private Long cnt07;


	private Long cnt310;
	private Long cnt08;
	private Long cnt320;
	private Long cnt340;
	private Long cnt11;
	private Long cnt12;
	private Long cnt210;
	private Long cnt220;
	private Long cnt230;
	private Long cnt19;
	private Long cnt21;
}