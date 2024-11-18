package biz.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import biz.common.service.CryptoService;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.common.typehandler
 * - 파일명		: CryptoTypeHandler.java
 * - 작성일		: 2021. 03. 21.
 * - 작성자		: sorce
 * - 설명			: mybatis type handler
 * </pre>
 */
@Component
@MappedJdbcTypes(JdbcType.UNDEFINED)
public class CryptoTypeHandler extends BaseTypeHandler<String> {

	@Autowired
	CryptoService cryptoService;

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: setCryptoService
	 * - 작성일		: 2021. 03. 21.
	 * - 작성자		: sorce
	 * - 설명			: mybatis typeHandler설정시 xml로 inject하기 위해 set 메서드 생성
	 * </pre>
	 * @param cryptoService
	 */
	public void setCryptoService(CryptoService cryptoService) {
		this.cryptoService = cryptoService;
	}

	/* (non-Javadoc)
	 * @see org.apache.ibatis.type.BaseTypeHandler#setNonNullParameter(java.sql.PreparedStatement, int, java.lang.Object, org.apache.ibatis.type.JdbcType)
	 */
	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, (String) encrypt(parameter));
	}

	/* (non-Javadoc)
	 * @see org.apache.ibatis.type.BaseTypeHandler#getNullableResult(java.sql.ResultSet, java.lang.String)
	 */
	@Override
	public String getNullableResult(ResultSet rs, String columnIndex) throws SQLException {

		// ResultSet으로 부터 가져온 Data를 Decrypt 한다.
		return decrypt(rs.getString(columnIndex));
	}

	/* (non-Javadoc)
	 * @see org.apache.ibatis.type.BaseTypeHandler#getNullableResult(java.sql.ResultSet, int)
	 */
	@Override
	public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		// ResultSet으로 부터 가져온 Data를 Decrypt 한다.
		return decrypt(rs.getString(columnIndex));
	}

	/* (non-Javadoc)
	 * @see org.apache.ibatis.type.BaseTypeHandler#getNullableResult(java.sql.CallableStatement, int)
	 */
	@Override
	public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		// ResultSet으로 부터 가져온 Data를 Decrypt 한다.
		return decrypt(cs.getString(columnIndex));
	}

	private String encrypt(String toEncrypt) {
		return cryptoService.twoWayEncrypt(toEncrypt);
	}

	private String decrypt(String toDecrypt) {
		if (StringUtils.endsWith(toDecrypt, "=")) {
			return cryptoService.twoWayDecrypt(toDecrypt);
		} else {
			return toDecrypt;
		}
	}
}
