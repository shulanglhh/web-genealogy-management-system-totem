package pedi.util;

import java.sql.ResultSet;

/**
 * Created by yvettee on 2017/10/2.
 */
//暴露一个处理结果集的接口
public interface ResultSetHandler {
    //返回多个值，Object类型
    public Object handler(ResultSet rs);
}
