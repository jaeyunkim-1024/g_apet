package biz.app.system.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class MenuSO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 메뉴 번호 */
	private Long menuNo;

	/** 상위 메뉴 번호 */
	private Long upMenuNo;

	/*권한 번호*/
	private List<Long> authNos;

}