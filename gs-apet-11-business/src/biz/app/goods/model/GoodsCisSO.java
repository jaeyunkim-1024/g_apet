package biz.app.goods.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@AllArgsConstructor
@NoArgsConstructor
public class GoodsCisSO{

	/** UID */
	private static final long serialVersionUID = 1L;

	/** API KEY */
	@NotEmpty
	private String apiKey;

	/** SKU CD */
	@NotEmpty
	private String skuCd;

	public GoodsCisSO sample(){
		return new GoodsCisSO("2b908ba7970e7526d11bb8123a72f0f9", "13452");
	}
}