package framework.common.model;

import java.io.Serializable;

import lombok.Data;

/**
 * 팝업 Param
 * 
 * @author valueFactory
 * @since 2015. 06. 12.
 */
@Data
public class PopParam implements Serializable {

	private static final long serialVersionUID = 1L;

	private String	popId;			// 팝업 ID
	private String	callBackFnc;	// 콜백함수명
	private String	closeFnc;		// 창닫기 버튼 시 함수명
}
