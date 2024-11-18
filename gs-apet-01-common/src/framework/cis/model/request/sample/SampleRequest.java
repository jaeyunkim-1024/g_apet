package framework.cis.model.request.sample;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class SampleRequest extends ApiRequest {

	private String allYn;

}
