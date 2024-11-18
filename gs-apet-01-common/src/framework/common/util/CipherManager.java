
package framework.common.util;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-01-common
 * - 패키지명	: framework.common.util
 * - 파일명		: CipherManager.java
 * - 작성일		: 2021. 06. 29.
 * - 작성자		: JinHong
 * - 설명		: SKT MP 암복호화
 * </pre>
 */
@Deprecated
public class CipherManager
{
	public static CipherManager instance;

    public static CipherManager getInstance()
	{
		if ( instance == null )
			instance = new CipherManager();
		return instance;
	}

    /*--------------------------------------------------------
	  ASCII Code를 암호화 된 데이터로 변환
	--------------------------------------------------------*/
	public String encrypt_ascii(String input, String mkey) 
    {
       /* byte[] ect = null;
        String ret = null;
        try {

                Cipher alg = Cipher.getInstance("DES-EDE3", "Cryptix");
                RawSecretKey key = new RawSecretKey("DES_EDE3", mkey.getBytes());
                    
                alg.initEncrypt(key);
                ect = alg.crypt(input.getBytes());
                ret = new String(ect);
            } catch ( Exception e )
                {
                    e.printStackTrace();
                }
            return ret;*/
        return null;
     }                        
    /*--------------------------------------------------------
	  암호화 된 데이터를 ASCII Code로 복호화시킨다
	---------------------------------------------------------*/
	public  String decrypt_ascii(String input, String mkey) 
    {
       /* byte[] dct = null;
        
        try {

                Cipher alg = Cipher.getInstance("DES-EDE3", "Cryptix");
                RawSecretKey key = new RawSecretKey("DES_EDE3", mkey.getBytes());
                
                alg.initDecrypt(key);
                dct = alg.crypt(input.getBytes());        
                
            } catch ( Exception e )
                {
                    e.printStackTrace();
                }
            return new String(dct);*/
        return null;
     }                        
     
    /*---------------------------------------------------------
	  HEX Type 데이터를 암호화 된 데이터로 변환
	----------------------------------------------------------*/
	public  String encrypt_hex(String input, String mkey) 
    {
       /* byte[] ect = null;
		
        try {

				*//***** 메세지 길이 체크(8의 배수여야 한다) *****//*
				while( (input.length() % 8) != 0 )
				{
					input += " ";
				}

				Cipher alg = Cipher.getInstance("DES-EDE3", "Cryptix");
                RawSecretKey key = new RawSecretKey("DES_EDE3", mkey.getBytes());
                    
                alg.initEncrypt(key);
                ect = alg.crypt(input.getBytes());
            } catch ( Exception e )
                {
                    e.printStackTrace();
                }
            
			return Hex.toString(ect);*/
        return null;
    }                        

	/*--------------------------------------------------------
	  암호화 된 데이터를 원래의 HEX Type으로 복호화
	--------------------------------------------------------*/
	public  String decrypt_hex(String input, String mkey) 
    {
        /*byte[] dct = null;
    
        try {

                Cipher alg = Cipher.getInstance("DES-EDE3", "Cryptix");
                RawSecretKey key = new RawSecretKey("DES_EDE3", mkey.getBytes());
                
                alg.initDecrypt(key);
                dct = alg.crypt(Hex.fromString(input));        
                
            } catch ( Exception e )
                {
                    e.printStackTrace();
                }
            return new String(dct).trim();*/
        return null;
    }                            

}
