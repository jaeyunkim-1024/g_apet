package front.web.config.tiles;

import front.web.config.constants.FrontWebConstants;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.tiles
* - 파일명		: TilesView.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Tiles3관련 Url 생성
* </pre>
*/
public class TilesView {

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Layout을 사용하지 않고 View를 호출하는 경우
	* </pre>
	* @param subUrl /WEB-INF/view/ 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String none(String[] subUrl) {
		StringBuilder viewUrl = new StringBuilder(1024);
		viewUrl.append("none");

		if(subUrl != null && subUrl.length > 0){
			for(int i = 0; i < subUrl.length; i++){
				viewUrl.append("/" + subUrl[i]);
			}
		}

		return viewUrl.toString();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Popup Layout을 사용하는 경우
	* </pre>
	* @param subUrls /WEB-INF/view 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String popup(String[] subUrls) {
		StringBuilder viewUrl = new StringBuilder(1024);
		viewUrl.append("popup");

		if(subUrls != null && subUrls.length > 0){
			for(int i = 0; i < subUrls.length; i++){
				viewUrl.append("/" + subUrls[i]);
			}
		}
		return viewUrl.toString();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Common Layout을 사용하는 경우
	* </pre>
	* @param siteId
	* @param subUrls /WEB-INF/view/common 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String common(String[] subUrls) {
		return layout("common", subUrls);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Main Layout을 사용하는 경우
	* </pre>
	* @param siteId
	* @param subUrls /WEB-INF/view/사이트/main 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String main(String[] subUrls) {
		return layout("main", subUrls);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Order Layout을 사용하는 경우
	* </pre>
	* @param siteId
	* @param subUrls /WEB-INF/view/common/order 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String order(String[] subUrls) {
		return layout("order", subUrls);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: MyPage Layout을 사용하는 경우
	* </pre>
	* @param siteId
	* @param subUrls /WEB-INF/view/common/mypage 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String mypage(String[] subUrls) {
		return layout("mypage", subUrls);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2017. 4. 20.
	* - 작성자		: Administrator
	* - 설명			: Customer Layout을 사용하는 경우
	* </pre>
	* @param subUrls
	* @return
	*/
	public static String customer(String[] subUrls) {
		return layout("customer", subUrls);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TilesView.java
	 * - 작성일		: 2021. 03. 30.
	 * - 작성자		: 김재윤
	 * - 설명			: event Layout을 사용하는 경우
	 * </pre>
	 * @param subUrls
	 * @return
	 */
	public static String event(String[] subUrls) {
		return layout("event", subUrls);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 34.front.brand.mobile
	* - 파일명		: TilesView.java
	* - 작성일		: 2017. 6. 12.
	* - 작성자		: hg.jeong
	* - 설명		: 검색엔진 Layout
	* </pre>
	* @param subUrls /WEB-INF/view/search_new 이하의 경로
	* @return
	*/
	public static String search_new(String[] subUrls) {
		return layout("search_new", subUrls);
	}	
	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Layout에 대한 Tiles형식의 URL 생성
	* </pre>
	* @param stId
	* @param layoutGb
	* @param subUrl
	* @return
	* @throws Exception
	*/
	public static String layout(String layoutGb, String[] subUrl) {
		StringBuilder viewUrl = new StringBuilder(1024);
		
		viewUrl.append(layoutGb);
		
		if(subUrl != null && subUrl.length > 0){
			for(int i = 0; i < subUrl.length; i++){
				viewUrl.append("/" + subUrl[i]);			
			}
		}
		
		return viewUrl.toString();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Redirect 처리하는 경우
	* </pre>
	* @param subUrl
	* @return
	* @throws Exception
	*/
	public static String redirect(String[] subUrl){
		StringBuilder viewUrl = new StringBuilder(1024);
		viewUrl.append("redirect:");

		if(subUrl != null && subUrl.length > 0){
			for(int i = 0; i < subUrl.length; i++){
				viewUrl.append("/" + subUrl[i]);
			}
		}

		return viewUrl.toString();		
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: 파일 다운로드 일 경우
	* </pre>
	* @return
	* @throws Exception
	*/
	public static String fileView() {
		return FrontWebConstants.FILE_VIEW_NAME;
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: 파일 다운로드 일 경우
	* </pre>
	* @return
	* @throws Exception
	*/
	public static String fileUrlView() {
		return FrontWebConstants.FILE_URL_VIEW_NAME;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: 파일 다운로드 일 경우
	* </pre>
	* @return
	* @throws Exception
	*/
	public static String fileNcpView() {
		return FrontWebConstants.FILE_NCP_VIEW_NAME;
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: 엑셀 다운로드 일 경우
	* </pre>
	* @return
	* @throws Exception
	*/
	public static String excelView() {
		return FrontWebConstants.EXCEL_VIEW_NAME;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: TilesView.java
	* - 작성일		: 2016. 3. 4.
	* - 작성자		: snw
	* - 설명		: Goods Layout을 사용하는 경우
	* </pre>
	* @param siteId
	* @param subUrls /WEB-INF/view/common 이하의 경로
	* @return
	* @throws Exception
	*/
	public static String goods(String[] subUrls) {
		return layout("goods", subUrls);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TilesView.java
	 * - 작성일		: 2017. 07. 04.
	 * - 작성자		: wyjeong
	 * - 설명		: Login Layout을 사용하는 경우
	 * </pre>
	 * 
	 * @param siteId
	 * @param subUrls /WEB-INF/view/ 이하의 경로
	 * @return
	 * @throws Exception
	 */
	public static String login(String[] subUrls) {
		return layout("login", subUrls);
	}

}
