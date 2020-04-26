package pedi.util;

import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

/**
 * Created by yvettee on 2017/10/2.
 */
public class BeanHandlerImpl implements ResultSetHandler {
    private Class clazz;

    public BeanHandlerImpl(Class clazz) {
        this.clazz = clazz;
    }

    @Override
    public Object handler(ResultSet rs) {
        try {
            if (!rs.next()) {
                return null;
            }

            //创建出封装结果集的bean
            Object bean = clazz.newInstance();
            //得到结果集的元数据，以获取结果集的信息
            ResultSetMetaData meta = rs.getMetaData();
            int count = meta.getColumnCount();
            for (int i = 0; i < count; i++) {
                String name = meta.getColumnName(i + 1);//获取到结果集每列的列名
                Object value = rs.getObject(name);
                //将获取到的值封装到与bean上相对应的属性上去（反射出bean上与列名相应的属性）
                Field f = bean.getClass().getDeclaredField(name);
                f.setAccessible(true);
                f.set(bean, value);
            }
            return bean;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}