package framework.admin.model;

import java.io.Serializable;

import lombok.Data;

/**
 * Bo View 정보 Bo VIew에서 사용되는 기본 정보
 * 
 * @author valueFactory
 * @since 2015. 06. 13
 */
@Data
public class View implements Serializable {

	private static final long serialVersionUID = 1L;

	private String	sys_gb_cd;

	private String	sys_gb_nm;

	private String	lang;

	private String	theme;

	private String	image_comm_path;

	private String	image_theme_path;

}