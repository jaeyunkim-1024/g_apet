package biz.app.tag.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagGroupTreeVO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
public class TagGroupTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String text;

	private String parent;
	
	private String pathText;

}