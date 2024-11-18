package framework.gsr.model.request;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor(access = AccessLevel.PUBLIC)
public class GsrApiRequest {
    private final String divCd;

    private final String storeCd;

    /*그 외 요청 Parameter*/
    private Map<String,String> param;

    public Map<String,String> getRequestParam(){
        Map<String,String> requestParam = new HashMap<String,String>();
        requestParam.put("div_code",this.divCd);
        requestParam.put("store_code",this.storeCd);
        requestParam.putAll(getParam());
        return requestParam;
    }
}
