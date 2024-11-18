package admin.web.config.grid;

import java.io.Serializable;
import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;

@Data
public class DataGridResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	public DataGridResponse(List<?> list) {
		this.total = list.size();
		this.rows = list;
	}
	
	public DataGridResponse(List<?> list, BaseSearchVO<?> vo) {
		this.total = vo.getTotalCount();
		this.rows = list;
	}

	private Integer total; // 전체페이지

	private List<?> rows; // 전체데이터

}