package framework.front.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * Web용 페이징 처리 화면 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class ListPagingSupport extends BodyTagSupport {
	private static final long serialVersionUID = 3053197864832459164L;

	protected int totalRecord;
	protected int recordPerPage;
	protected int currentPage;
	protected int indexPerPage;

	public int doStartTag() throws JspException {

		try {
			listPaging(this.pageContext, this.id, this.totalRecord, this.recordPerPage, this.currentPage, this.indexPerPage);
			return EVAL_BODY_BUFFERED;
		} catch (IOException ex) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//throw new JspException(ex.toString(), ex);
			throw new JspException("IOException", ex);
		}
	}

	/**
	 *
	 * @param pageContext
	 * @param id            페이지 ID
	 * @param totalRecord   전체 데이터 수
	 * @param recordPerPage 한페이지에 출력되는 데이터 수
	 * @param currentPage   현재 페이지
	 * @param indexPerPage  한화면에 출력되는 페이지 수
	 * @throws IOException
	 */
	public static void listPaging(PageContext pageContext, String id, int totalRecord, int recordPerPage, int currentPage, int indexPerPage) throws IOException {

		JspWriter w = pageContext.getOut();

		StringBuilder pageStr = new StringBuilder();
		pageStr.append("<div class=\"paging\" id=\"" + id + "\">");

		if (totalRecord > 0) {
			int startPage;
			int endPage;
			int prevPage;
			int nextPage;
			int totalPage;
			int block;

			block = (int) Math.ceil((double) currentPage / (double) indexPerPage);

			startPage = (block - 1) * indexPerPage + 1;
			endPage = startPage + indexPerPage - 1;
			totalPage = (int) Math.ceil((double) totalRecord / (double) recordPerPage);

			if (endPage > totalPage) {
				endPage = totalPage;
			}

			prevPage = currentPage - 1;

			if (currentPage == 1) {
				prevPage = 1;
			}

			nextPage = currentPage + 1;

			if (nextPage > totalPage) {
				nextPage = currentPage;
			}

			// 클릭시 상단 이동 방지
			String rf = " onclick=\"return false\"";
			if (currentPage > indexPerPage) {
				pageStr.append( "<a class=\"btnPaging btnFirst\" href=\"#\"" + rf + "><span>1</span></a>");
				pageStr.append("<a class=\"btnPaging btnPrev\" href=\"#\"" + rf + "><span>" + prevPage + "</span></a>");
			}
			pageStr.append("<div class=\"number\">");
			for (int i = startPage; i <= endPage; i++) {
				if (i == currentPage) {
					pageStr.append( "<a class=\"on\"><span>" + i + "</span></a>");
				} else {
					pageStr.append( "<a href=\"#\"" + rf + "><span>" + i + "</span></a>");

				}
			}
			pageStr.append("</div>");
			if (totalPage > endPage) {
				pageStr.append("<a class=\"btnPaging btnNext\" href=\"#\"" + rf + "><span>" + nextPage + "</span></a>");
				pageStr.append("<a class=\"btnPaging btnLast\" href=\"#\"" + rf + "><span>" + totalPage + "</span></a>");
			}

		}

		pageStr.append("</div>");

		w.write(pageStr.toString());
	}

}