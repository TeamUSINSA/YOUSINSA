package dao.product;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import utils.MybatisSqlSessionFactory;

public class ProductStockDAOImpl implements ProductStockDAO {
    private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit

    @Override
    public void increaseQuantity(int productId, String color, String size, int quantity) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("productId", productId);
        param.put("color", color);
        param.put("size", size);
        param.put("quantity", quantity);

        sqlSession.update("mapper.productstock.increaseQuantity", param);
    }
}
