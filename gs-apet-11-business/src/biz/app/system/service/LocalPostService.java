package biz.app.system.service;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.service
 * - 파일명		: LocalPostService.java
 * - 작성일		: 2017. 6. 1.
 * - 작성자		: Administrator
 * - 설명		: 도서산간지역 우편번호 서비스
 * </pre>
 */
public interface LocalPostService {

	/**
	 * <pre>
	 * - 작성일		: 2017. 6. 1.
	 * - 작성자		: Administrator
	 * - 설명		: 도서/산간지역 여부
	 * </pre>
	 * 
	 * @param postNoNew
	 * @param postNoOld
	 * @return
	 */
	public String getLocalPostYn(String postNoNew, String postNoOld);
}