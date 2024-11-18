package framework.cis.model.request.gateway;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;
import net.sf.json.JSONArray;

@Data
@EqualsAndHashCode(callSuper = true)
public class GatewayRequest extends ApiRequest {

	/* 요청 경로 */
	private String requestUrl;
	/* 요청 형태 */
	private String requestMethod;
	/* 요청 데이터 */
	private String requestData;
	/* 컨텐츠 유형 */
	private String contentType;
	/* 문자셋 */
	private String characterSet;
	/* request header */
	private JSONArray header;

}
