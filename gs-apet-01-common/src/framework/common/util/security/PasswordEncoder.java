package framework.common.util.security;

public abstract interface PasswordEncoder {

	public abstract String encode(String paramString2);

	public abstract boolean check(String paramString2, String paramString3);

}
