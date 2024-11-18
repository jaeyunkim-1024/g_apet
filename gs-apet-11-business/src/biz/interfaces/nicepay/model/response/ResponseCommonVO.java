package biz.interfaces.nicepay.model.response;

import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ResponseCommonVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String ResultCode;
	
	private String ResultMsg;
	
	private String responseBody;
}
