package framework.common.util.security;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Properties;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.codec.Hex;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.common.util.security
 * - 파일명		: PBKDF2PasswordEncoder.java
 * - 작성일		: 2018. 03. 30
 * - 작성자		: WilLee
 * - 설명		: 암호화 관련 Utility
 * </pre>
 */
@Component
@Slf4j
public class PBKDF2PasswordEncoder implements PasswordEncoder, InitializingBean {

	private SecureRandom saltGenerator;
	private SecretKeyFactory keyFactory;
	private int iterations = 1000;
	private int keyLength = 512;
	private String keyAlgorithm = "PBKDF2WithHmacSHA1";
	private int saltLength = 16;
	private String saltAlgorithm = "SHA1PRNG";

	@Autowired
	private Properties bizConfig;

	public void afterPropertiesSet() throws NoSuchAlgorithmException {
		this.iterations = Integer.parseInt(bizConfig.getProperty("member.password.encoder.pbkdf2.iterations"));
		this.keyLength = Integer.parseInt(bizConfig.getProperty("member.password.encoder.pbkdf2.keylength"));
		this.saltGenerator = SecureRandom.getInstance(this.saltAlgorithm);
		this.keyFactory = SecretKeyFactory.getInstance(this.keyAlgorithm);
	}

	public String encode(String password) {
		byte[] salt = generateSalt();
		byte[] hash = calculateHash(password, salt, this.iterations, this.keyLength);
		return new EncodedHash(this.iterations, salt, hash).toString();
	}

	public boolean check(String encoded, String plain) {
		EncodedHash parsedEncodedHash = new EncodedHash(encoded);
		byte[] hash = calculateHash(plain, parsedEncodedHash.salt, parsedEncodedHash.iterations, parsedEncodedHash.hash.length * 8);

		log.debug("#####" + PBKDF2PasswordEncoder.byteArrayToBinaryString(parsedEncodedHash.hash));
		log.debug("#####" + PBKDF2PasswordEncoder.byteArrayToBinaryString(hash));
		return Arrays.equals(parsedEncodedHash.hash, hash);
	}

	public static String byteArrayToBinaryString(byte[] b) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < b.length; ++i) {
			sb.append(PBKDF2PasswordEncoder.byteToBinaryString(b[i]));
		}
		return sb.toString();
	}

	public static String byteToBinaryString(byte n) {
		StringBuilder sb = new StringBuilder("00000000");
		for (int bit = 0; bit < 8; bit++) {
			if (((n >> bit) & 1) > 0) {
				sb.setCharAt(7 - bit, '1');
			}
		}
		return sb.toString();
	}

	protected byte[] calculateHash(String password, byte[] salt, int iterations, int keyLength) {
		String _password = (password == null) ? "" : password;
		try {
			PBEKeySpec spec = new PBEKeySpec(_password.toCharArray(), salt, iterations, keyLength);
			return this.keyFactory.generateSecret(spec).getEncoded();
		} catch (InvalidKeySpecException e) {
			throw new IllegalArgumentException(e);
		}
	}

	private byte[] generateSalt() {
		byte[] salt = new byte[this.saltLength];
		this.saltGenerator.nextBytes(salt);
		return salt;
	}

	public void setIterations(int iterations) {
		this.iterations = iterations;
	}

	public void setKeyLength(int keyLength) {
		this.keyLength = keyLength;
	}

	public void setKeyAlgorithm(String keyAlgorithm) {
		this.keyAlgorithm = keyAlgorithm;
	}

	public void setSaltAlgorithm(String saltAlgorithm) {
		this.saltAlgorithm = saltAlgorithm;
	}

	public void setSaltLength(int saltLength) {
		this.saltLength = saltLength;
	}

	protected static class EncodedHash {
		final int iterations;
		final byte[] salt;
		final byte[] hash;

		EncodedHash(String encoded) {
			String[] parts = encoded.split(":");
			this.iterations = Integer.parseInt(parts[0]);
			this.salt = Hex.decode(parts[1]);
			this.hash = Hex.decode(parts[2]);
		}

		EncodedHash(int iterations, byte[] salt, byte[] hash) {
			this.iterations = iterations;
			this.hash = hash;
			this.salt = salt;
		}

		public String toString() {
			return this.iterations + ":" + new String(Hex.encode(this.salt)) + ":" + new String(Hex.encode(this.hash));
		}
	}
}
