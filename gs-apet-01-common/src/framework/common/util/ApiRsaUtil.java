package framework.common.util;

import lombok.extern.slf4j.Slf4j;

import javax.crypto.Cipher;
import java.security.*;
import java.security.spec.*;
import java.util.HashMap;

@Slf4j
public class ApiRsaUtil {

    /**
     * Api Rsa Key 생성
     * @return
     * @throws NoSuchAlgorithmException
     * @throws NoSuchProviderException
     * @throws InvalidKeySpecException
     */
    public static void rsaGenKey() throws NoSuchAlgorithmException, NoSuchProviderException, InvalidKeySpecException {

        String pubkey = "aboutPetApi";

        SecureRandom random = new SecureRandom(pubkey.getBytes());
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA","SunJSSE");
        generator.initialize(1024, random);
        KeyPair pair = generator.generateKeyPair();
        Key pubKey = pair.getPublic();
        Key privKey = pair.getPrivate();

        KeyFactory keyFactory1 = KeyFactory.getInstance("RSA");
        RSAPublicKeySpec rsaPublicKeySpec = keyFactory1.getKeySpec(pubKey, RSAPublicKeySpec.class);
        RSAPrivateKeySpec rsaPrivateKeySpec = keyFactory1.getKeySpec(privKey, RSAPrivateKeySpec.class);

        System.out.println("pubKeyHex:" + byteArrayToHex(pubKey.getEncoded()));
        System.out.println("privKeyHex:" + byteArrayToHex(privKey.getEncoded()));

    }

    // ENC_RSA() => RSA 암호화
    public static String ENC_RSA(String encStr, String key) throws Exception{

        Cipher cipher = Cipher.getInstance("RSA");
        X509EncodedKeySpec ukeySpec = new X509EncodedKeySpec(hexToByteArray(key));
        KeyFactory ukeyFactory = KeyFactory.getInstance("RSA");
        PublicKey publickey = null;

        try {
            publickey = ukeyFactory.generatePublic(ukeySpec); // PublicKey에 공용키 값 설정
        } catch (Exception e) {
            e.printStackTrace();
        }

        byte[] input = encStr.getBytes();
        cipher.init(Cipher.ENCRYPT_MODE, publickey);
        byte[] cipherText = cipher.doFinal(input);

        return byteArrayToHex(cipherText);
    }

    // DEC_RSA() => RSA 복호화
    public static String DEC_RSA(String decStr, String key) throws Exception{

        Cipher cipher = Cipher.getInstance("RSA");
        PKCS8EncodedKeySpec rkeySpec = new PKCS8EncodedKeySpec(hexToByteArray(key));
        KeyFactory rkeyFactory = KeyFactory.getInstance("RSA");
        PrivateKey privateKey = null;

        privateKey = rkeyFactory.generatePrivate(rkeySpec);

        // 복호화
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] plainText = cipher.doFinal(hexToByteArray(decStr));
        String returnStr = new String(plainText);

        return returnStr;
    }

    // hex string to byte[]
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() == 0) {
            return null;
        }
        byte[] ba = new byte[hex.length() / 2];
        for (int i = 0; i < ba.length; i++) {
            ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
        }
        return ba;
    }

    // byte[] to hex sting
    public static String byteArrayToHex(byte[] ba) {
        if (ba == null || ba.length == 0) {
            return null;
        }
        StringBuffer sb = new StringBuffer(ba.length * 2);
        String hexNumber;
        for (int x = 0; x < ba.length; x++) {
            hexNumber = "0" + Integer.toHexString(0xff & ba[x]);

            sb.append(hexNumber.substring(hexNumber.length() - 2));
        }
        return sb.toString();
    }
}