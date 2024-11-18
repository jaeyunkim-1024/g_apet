package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import framework.cis.model.response.shop.OrderResponse;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ReturnInquiryVO extends OrderResponse<ReturnInquiryItemVO>{
		
}
