package framework.cis.model.response;

import org.codehaus.jackson.JsonNode;

import lombok.Data;

/* <pre>
* - 프로젝트명	: 01.common
* - 패키지명		: framework.cis.model.response
* - 파일명		: ApiResponse.java
* - 작성자		: valueFactory
* - 설명		:
* </pre>
*/
@Data
public class ApiResponse {

	private String responseBody;
	private JsonNode responseJson;

}
