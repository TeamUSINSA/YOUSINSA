package dao.order;

import org.apache.ibatis.session.SqlSession;
import dto.order.OrderList;
import utils.MybatisSqlSessionFactory;

public class OrderListDAOImpl implements OrderListDAO {
    private final SqlSession sqlSession;

    public OrderListDAOImpl() {
        this.sqlSession = MybatisSqlSessionFactory
                              .getSqlSessionFactory()
                              .openSession(true);
    }

    @Override
    public void insertPendingOrder(OrderList order) throws Exception {
        sqlSession.insert("mapper.orderlist.insertPendingOrder", order);
    }

    @Override
    public OrderList selectByOrderId(int orderId) throws Exception {
        return sqlSession.selectOne("mapper.orderlist.selectByOrderId", orderId);
    }

    @Override
    public void updateToPaid(OrderList order) throws Exception {
        sqlSession.update("mapper.orderlist.updateToPaid", order);
    }

    @Override
    public void updateToCanceled(int orderId) throws Exception {
        sqlSession.update("mapper.orderlist.updateToCanceled", orderId);
    }
}
