package biz.app.display.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String text;

	private String parent;

	private Long dispLvl;

	private String dispClsfCd;

	private String dispPath;

	private String stId;

	private String stNm;
	
	private String compNo;
}