package biz.app.counsel.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.counsel.model
* - 파일명		: CounseFilelVO.java
* - 작성일		: 2016. 3. 24.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Data
public class CounselFileVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 파일번호 */
	private String flNo;
	
	/** 첨부파일 경로 */
	private String phyPath;
	
	/** 파일원본명 */
	private String orgFlNm;

}
