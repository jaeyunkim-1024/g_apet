package admin.web.config.view;

import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.config.view
 * - 파일명		: View.java
 * - 작성일		: 2016. 3. 3.
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
public class View {

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: Redirect 처리하는 경우
	 * </pre>
	 * @param url
	 * @return
	 */
	public static String redirect(String url) {
		return "redirect:" + url;
	}

	public static String forward(String url) {
		return "forward:" + url;
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: View.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: valueFactory
	* - 설명			: 엑셀 다운로드 일 경우
	* </pre>
	* @return
	*/
	public static String excelDownload() {
		return CommonConstants.EXCEL_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 파일 다운로드 일 경우
	 * </pre>
	 * @return
	 */
	public static String fileDownload() {
		return CommonConstants.FILE_VIEW_NAME;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 파일 다운로드 일 경우
	 * </pre>
	 * @return
	 */
	public static String fileUrlDownload() {
		return CommonConstants.FILE_URL_VIEW_NAME;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 파일 다운로드 일 경우
	 * </pre>
	 * @return
	 */
	public static String fileNcpDownload() {
		return CommonConstants.FILE_NCP_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 이미지 뷰
	 * </pre>
	 * @return
	 */
	public static String imageView() {
		return CommonConstants.IMAGE_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: jsonView 호출
	 * </pre>
	 * @return
	 */
	public static String jsonView() {
		return CommonConstants.JSON_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: error 화면
	 * </pre>
	 * @return
	 */
	public static String errorView() {
		return AdminConstants.ERROR_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: View.java
	 * - 작성일		: 2016. 3. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 로그인 화면
	 * </pre>
	 * @return
	 */
	public static String loginView() {
		return redirect(AdminConstants.LOGIN_URL);
	}

	/**
	 * <pre>
	 * - 프로젝트명    : 41.admin.web
	 * - 파일명        : View.java
	 * - 작성일        : 2021. 08. 18.
	 * - 작성자        : valueFactory
	 * - 설명            : 첨부파일 일괄 다운로드 일 경우
	 * </pre>
	 *
	 * @return
	 */
	public static String fileDownloadAll() {
		return CommonConstants.FILE_All_VIEW_NAME;
	}

}
