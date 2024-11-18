package biz.app.member.model;

import java.io.Serializable;

import lombok.Data;

/**
 * 회원 로그인이력 등록 PO
 * @author	snw
 * @since	2016.02.17
 */

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberLoginHistPO.java
* - 작성일		: 2021. 2. 17
* - 작성자		: 이지희
* - 설명		: 회원 로그인 이력 Param Object
*             등록/수정/삭제 사용
* </pre>
*/
@Data
public class MemberLoginHistPO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long	mbrNo;	// I
	private String 	loginIp;	// I
	private Long	sysRegrNo;	// I
	private String 	loginPathCd ; //로그인 경로 코드

}