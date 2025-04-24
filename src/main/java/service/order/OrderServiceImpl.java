package service.order;

import java.util.List;
import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.order.OrderList;

public class OrderServiceImpl implements OrderService {
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    public List<OrderList> getAllOrders() throws Exception {
        return orderDAO.selectAllOrders();
    }

    @Override
    public int getTotalPages() throws Exception {
        return orderDAO.getTotalOrderPages();
    }

    @Override
    public List<OrderList> getFilteredOrders(String userId, String status, String period) throws Exception{
        return orderDAO.selectFilteredOrders(userId, status, period);
    }
}