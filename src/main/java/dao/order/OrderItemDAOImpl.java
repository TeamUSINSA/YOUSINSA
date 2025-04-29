package dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.order.OrderItem;
import dto.product.Product;
import utils.MybatisSqlSessionFactory;

public class OrderItemDAOImpl implements OrderItemDAO{
	private SqlSession sqlSession  = MybatisSqlSessionFactory
	        .getSqlSessionFactory().openSession(true);


    @Override
    public List<OrderItem> selectByOrderId(int orderId) throws Exception {
        return sqlSession.selectList("mapper.orderitem.selectByOrderId", orderId);
    }

    @Override
    public void insert(OrderItem item) throws Exception {
    	sqlSession.insert("mapper.orderitem.insert", item);
    }
    
    @Override
    public List<Product> selectTopSellingProducts(int count) throws Exception {
        return sqlSession.selectList(
            "mapper.orderitem.selectTopSellingProducts", count);
    }
}
