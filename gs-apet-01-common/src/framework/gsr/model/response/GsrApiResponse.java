package framework.gsr.model.response;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.*;
import org.json.XML;

import java.io.IOException;


/* <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.cis.model.response
 * - 파일명		: ApiResponse.java
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
@Data
@RequiredArgsConstructor
public class GsrApiResponse {
    @NonNull
    private String serviceName;

    private String responseBody;
    private JsonNode responseJson;

    public void setResponseBody(String responseBody){
        this.responseBody = responseBody;
        try{
            String xml = XML.toJSONObject(responseBody).toString();
            setResponseJson(new ObjectMapper().readTree(xml));
        }catch(IOException e){
            setResponseJson(null);
        }
    }

    public JsonNode getResponseJson(){
        return this.responseJson != null ? responseJson.get("soap:Envelope").get("soap:Body").get("ns2:"+getServiceName()+"Response").get("gsc-was") : this.responseJson;
    }
}
