package admin.web.config.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import framework.common.model.BaseSearchVO;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.Properties;


/*
   작성 일자 : 2021.05.31
   작 성 자 :  김재윤
   내    용 : GS 정보운영팀(?) 요건으로, 개인정보 접근 시 실행 쿼리 DB에 저장
              , SELECT 쿼리 인터셉터
 */

@Slf4j
@Intercepts(@Signature(
            type= Executor.class
        ,   method = "query"
        ,   args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}
    )
)
public class QueryInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();

        if(args.length>1 && args[1] != null){
            Object param = args[1];
            if(StringUtil.equals(param.getClass().getSuperclass().getName(), BaseSearchVO.class.getName())){
                BoundSql boundSql= ((MappedStatement)args[0]).getBoundSql(param);
                //String sql = ((MappedStatement)args[0]).getBoundSql(param).getSql(); -> 바인드 변수 노출 안됨.
                String query = bindSql(boundSql,new ObjectMapper().convertValue(param,Map.class));
                Method setExecSql = param.getClass().getMethod("setExecSql", String.class);
                setExecSql.invoke(param, query);
            }
        }

        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target,this);
    }

    @Override
    public void setProperties(Properties properties) {}

    @SuppressWarnings("rawtypes")
    private String bindSql(BoundSql boundSql,Object param) throws NoSuchFieldException, IllegalAccessException {
        String sql = boundSql.getSql();

        // 바인딩 파라미터가 없으면
        if (param == null) {
            sql = sql.replaceFirst("\\?", "''");
            return sql;
        }

        // 해당 파라미터의 클래스가 Integer, Long, Float, Double 클래스일 경우
        if (param instanceof Integer || param instanceof Long || param instanceof Float || param instanceof Double) {
            sql = sql.replaceFirst("\\?", param.toString());
        }
        // 해당 파라미터의 클래스가 String인 경우
        else if (param instanceof String) {
            sql = sql.replaceFirst("\\?", "'" + param + "'");
        }
        // 해당 파라미터의 클래스가 Map인 경우
        else if (param instanceof Map) {
            List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
            for (ParameterMapping mapping : paramMapping) {
                String propValue = mapping.getProperty();
                Object value = ((Map) param).get(propValue);
                if (value == null) {
                    continue;
                }

                if (value instanceof String) {
                    sql = sql.replaceFirst("\\?", "'" + value + "'");
                } else {
                    sql = sql.replaceFirst("\\?", value.toString());
                }
            }
        }
        // 해당 파라미터의 클래스가 사용자 정의 클래스인 경우
        else {
            List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
            Class<? extends Object> paramClass = param.getClass();

            for (ParameterMapping mapping : paramMapping) {
                String propValue = mapping.getProperty();
                Field field = paramClass.getDeclaredField(propValue);
                field.setAccessible(true);
                Class<?> javaType = mapping.getJavaType();
                if (String.class == javaType) {
                    sql = sql.replaceFirst("\\?", "'" + field.get(param) + "'");
                } else {
                    sql = sql.replaceFirst("\\?", field.get(param).toString());
                }
            }
        }

        // return sql
        return sql;
    }
}

