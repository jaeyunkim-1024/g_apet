package biz.app.system.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 메뉴 명 */
	private String menuNm;

	/** 정렬 순서 */
	private Long sortSeq;

	/** 사용 여부 */
	private String useYn;

	/** 메뉴 번호 */
	private Integer menuNo;

	/** 상위 메뉴 번호 */
	private Integer upMenuNo;

	/** URL */
	private String url;

	private String actNm;

	/** MAST MENU NO */
	private Integer mastMenuNo;

	private String menuPathNm;

	private Integer level;

	private List<MenuBaseVO> listMenuBaseVO;

	private List<MenuActionVO> listMenuActionVO;

	/** commonMenuDetail 의 메인목록 혹은 순번이 1번인 기능번호 **/
	private Long actNo;

}