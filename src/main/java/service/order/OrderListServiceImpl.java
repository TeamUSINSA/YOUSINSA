package service.order;

import dao.order.OrderListDAO;
import dao.order.OrderListDAOImpl;
import dto.order.OrderList;

public class OrderListServiceImpl implements OrderListService {

    private final OrderListDAO dao = new OrderListDAOImpl();

    @Override
    public void createPendingOrder(OrderList order) throws Exception {
        dao.insertPendingOrder(order);
    }

    @Override
    public OrderList getOrder(int orderId) throws Exception {
        return dao.selectByOrderId(orderId);
    }

    @Override
    public void markPaid(OrderList order) throws Exception {
        dao.updateToPaid(order);
    }

    @Override
    public void cancelOrder(int orderId) throws Exception {
        dao.updateToCanceled(orderId);
    }
}
