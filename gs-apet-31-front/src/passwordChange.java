import java.security.SecureRandom;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.springframework.security.crypto.codec.Hex;

import framework.common.util.DateUtil;

import java.sql.Timestamp;
public class passwordChange {
	private SecureRandom saltGenerator;
	private SecretKeyFactory keyFactory;
	private static final String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";
	public static void main(String[] args) {
		try {
			passwordChange f = new passwordChange();
			byte[] salt = new byte[16];
			f.saltGenerator = SecureRandom.getInstance("SHA1PRNG");
			f.saltGenerator.nextBytes(salt);
			byte[] hash = f.calculateHash("test1234", salt, 1000, 512); 
			String result = new EncodedHash(1000, salt, hash).toString();
			System.out.println(result);
			
			Timestamp now = DateUtil.getTimestamp();
			
			//현재 날짜
			String nowDt = DateUtil.getTimestampToString(now);
			Timestamp oneDayCloseTime = DateUtil.getTimestamp(nowDt + "1330000", YYYYMMDDHHMMSS);
			
			System.out.println("현재시간 :"+now);
			System.out.println("마감시간 :"+oneDayCloseTime);
			
			System.out.println(now.before(oneDayCloseTime));
			
			
		} catch(Exception e) {
			
		}
	}
	
	protected byte[] calculateHash(String password, byte[] salt, int iterations, int keyLength) {
		String _password = (password == null) ? "" : password;
		try {
			PBEKeySpec spec = new PBEKeySpec(_password.toCharArray(), salt, iterations, keyLength);
			keyFactory = keyFactory.getInstance("PBKDF2WithHmacSHA1");
			return keyFactory.generateSecret(spec).getEncoded();
		} catch (Exception e) {
			throw new IllegalArgumentException(e);
		}
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
