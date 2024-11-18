package admin.web.config.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;

import java.util.Properties;


/*
   작성 일자 : 2021.05.31
   작 성 자 :  김재윤
   내    용 : GS 정보운영팀(?) 요건으로, 개인정보 접근 시 실행 쿼리 DB에 저장
              , delete , update  쿼리 인터셉터
 */

@Slf4j
@Intercepts(
        @Signature(
                type= Executor.class
            ,   method = "update"
            ,   args = {MappedStatement.class, Object.class}
        )
)
public class UpdateInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();
        if(args.length>1 && args[1] != null){
            Object param = args[1];
            //TO-DO :: 회원 정보 UPDATE 처리 필요
        }

        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target,this);
    }

    @Override
    public void setProperties(Properties properties) {}
}
