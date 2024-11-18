package biz.common.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import framework.common.model.BaseSysVO;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: SgrPushVO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KSH
* - 설명		: Sgr PUSH PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SgrPushVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 회원번호 array */
	private String mbrNo[];
	
	/** push 제목 */
	private String pushSubject;	
	
	/** push 내용 */
	private String pushContent;
	
	/** push url */
	private String pushUrl;
}