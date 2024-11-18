package framework.admin.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Bo View Popup 정보 팝업 화면에서 사용되는 기본 정보
 * 
 * @author valueFactory
 * @since 2015. 06. 13
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ViewPopup extends View {

	private static final long serialVersionUID = 1L;

	private String	title;

}