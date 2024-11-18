package framework.admin.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Bo View App 정보 App package계열의 화면에서 사용되는 기본정보
 * 
 * @author valueFactory
 * @since 2015. 06. 13
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ViewApp extends View {

	private static final long serialVersionUID = 1L;

	private String	title;

	private String	navigation;

}