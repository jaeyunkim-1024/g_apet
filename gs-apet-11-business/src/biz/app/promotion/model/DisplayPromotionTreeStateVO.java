package biz.app.promotion.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayPromotionTreeStateVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Boolean opened;

	private Boolean disabled;

	private Boolean selected;
	
}

