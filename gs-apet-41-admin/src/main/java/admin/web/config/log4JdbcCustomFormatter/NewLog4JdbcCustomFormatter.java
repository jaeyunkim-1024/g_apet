package admin.web.config.log4JdbcCustomFormatter;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.log4jdbc.Spy;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;

public class NewLog4JdbcCustomFormatter extends Log4JdbcCustomFormatter {

	@Override
	public String sqlOccured(Spy spy, String methodCall, String rawSql) {
		// 정규식 문자열을 컴파일
        Pattern pattern = Pattern.compile("\\d{2}\\/\\d{2}\\/\\d{4}\\s\\d{2}:\\d{2}:\\d{2}.\\d{3}", Pattern.CASE_INSENSITIVE); // 대소문자 구분 안함 
        // 검색 결과를 Matcher에 저장
        Matcher matcher = pattern.matcher(rawSql);
        StringBuffer replacedString = new StringBuffer();
        while(matcher.find()) {
            // 찾은 대상을 치환 
        	StringBuilder newFormat = new StringBuilder();
            String[] array = matcher.group().split(" ");
			String[] array0 = array[0].split("/");
            newFormat.append(array0[2]+"-");
            newFormat.append(array0[0]+"-");
            newFormat.append(array0[1]+" ");
            newFormat.append(array[1]);            
            matcher.appendReplacement(replacedString, newFormat.toString());
        }
        // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
        matcher.appendTail(replacedString);
        // 개행 제거후 리턴
		return super.sqlOccured(spy, methodCall,replacedString.toString().replaceAll("(\\s*(\\r\\n|\\r|\\n|\\n\\r)+\\s*(\\r\\n|\\r|\\n|\\n\\r)+)+","\n"));
	}
	
}
