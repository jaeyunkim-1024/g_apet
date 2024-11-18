package batch.excute.order;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Hex;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Slf4j
public class DataEncrypt {
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";
	String strOUTData = "";

	public String encrypt(String strData){
		String passACL = null;
		MessageDigest md = null;
		try{
			md = MessageDigest.getInstance("SHA-256");
			md.reset();
			md.update(strData.getBytes());
			byte[] raw = md.digest();
			passACL = encodeHex(raw);
		}catch(NoSuchAlgorithmException e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
		}
		return passACL;
	}

	public String encodeHex(byte [] b){
		char [] c = Hex.encodeHex(b);
		return new String(c);
	}

}
