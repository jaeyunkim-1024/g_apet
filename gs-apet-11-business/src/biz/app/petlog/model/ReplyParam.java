package biz.app.petlog.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class ReplyParam extends PopParam {

	private static final long serialVersionUID = 1L;

    /*펫로그 번호*/
    private Long petLogNo;
    
    private String listNo;	
}