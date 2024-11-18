package framework.front.tags;

/**
 * Web용 페이징 처리 화면 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class ListPagingTag extends ListPagingSupport {

	private static final long serialVersionUID = -7798325594439867134L;

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public void setIndexPerPage(int indexPerPage){
		this.indexPerPage = indexPerPage;
	}
	
	public void setId(String id) {
		this.id = id;
	}

}