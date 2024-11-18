package framework.common.model;

import java.io.Serializable;

import static framework.common.constants.CommonConstants.RECORD_COUNT_PAGE;

@SuppressWarnings("unused")
public class BaseSearchVO<T> implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 페이징 정렬 컬럼 */
	private String	sidx;

	/** 페이징 정렬 방향 */
	private String	sord = "asc";

	// datagrid의 header sort field 명 추가
	private String	sort;				// 페이징 정렬 컬럼
	private String	order = "asc";		// 페이징 정렬 방향

	/** 현재 페이지 */
	private int		page = 0;

	/** 한페이지당 보여줄 리스트 수 */
	private Integer	rows;

	/** 총 카운트 */
	private int		totalCount = 0;

	/** 총 페이지 카운트 */
	private int		totalPageCount = 0;

	private int		limit = 0;

	private int		offset = 0;

	private int		startIndex = 0;

	private int		endIndex = 0;

	private int		startOffset = 0;

	private String execSql = "";

	private Long cnctHistNo = 0L;

	private Long inqrHistNo = 0L;

	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public Integer getRows() {
		if (null != rows) {
			return rows;
		}
		
		return RECORD_COUNT_PAGE;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPageCount() {
		this.totalPageCount = ((getTotalCount() - 1) / getRows() + 1);
		return this.totalPageCount;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public int getEndIndex() {
		return endIndex;
	}

	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
		this.sidx = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
		this.sord = order;
	}

	public int getStartOffset() {
		return startOffset;
	}

	public void setStartOffset(int startOffset) {
		this.startOffset = startOffset;
	}

	public void setExecSql(String execSql){
		this.execSql = execSql;
	}
	public String getExecSql(){
		return this.execSql;
	}

	public void setCnctHistNo(Long cnctHistNo){
		this.cnctHistNo = cnctHistNo;
	}
	public Long getCnctHistNo(){
		return this.cnctHistNo;
	}

	public void setInqrHistNo(Long inqrHistNo) {this.inqrHistNo = inqrHistNo;}
	public Long getInqrHistNo() {
		return this.inqrHistNo;
	}
}
