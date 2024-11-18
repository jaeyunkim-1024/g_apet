package biz.app.system.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class MenuTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String text;

	private String parent;

}