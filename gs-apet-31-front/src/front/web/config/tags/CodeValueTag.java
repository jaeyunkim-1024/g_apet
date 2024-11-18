package front.web.config.tags;



/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.tags
* - 파일명		: CodeValueTag.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
public class CodeValueTag extends CodeValueSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setItems(Object items) {
		this.items = items;
	}

	public void setDtlCd(String dtlCd) {
		this.dtlCd = dtlCd;
	}

	public void setType(String type){
		this.type = type;
	}

}