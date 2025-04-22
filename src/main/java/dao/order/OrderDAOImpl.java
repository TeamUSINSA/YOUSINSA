package dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.order.Order;
import dto.order.OrderItem;
import dto.order.OrderList;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

    private SqlSession sqlSession;

    public OrderDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
	}

    @Override
    public int insertOrder(Order order) throws Exception {
        return sqlSession.insert("mapper.order.insertOrder", order);
    }

    @Override
    public void insertOrderItem(OrderItem item) throws Exception {
        sqlSession.insert("mapper.order.insertOrderItem", item);
    }

    @Override
    public List<OrderList> selectOrderListByUser(String userId) throws Exception {
        return sqlSession.selectList("mapper.order.selectOrderListByUser", userId);
    }
}
