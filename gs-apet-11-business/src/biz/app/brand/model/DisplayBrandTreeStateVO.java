package biz.app.brand.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayBrandTreeStateVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Boolean opened;

	private Boolean disabled;

	private Boolean selected;
	
}

