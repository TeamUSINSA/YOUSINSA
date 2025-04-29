package service.order;

import java.util.List;

import dao.order.OrderItemDAO;
import dao.order.OrderItemDAOImpl;
import dao.order.OrderListDAO;
import dao.order.OrderListDAOImpl;
import dto.order.OrderItem;
import dto.order.OrderList;

public class OrderListServiceImpl implements OrderListService {

    private final OrderListDAO dao = new OrderListDAOImpl();
    private final OrderItemDAO orderItemDao = new OrderItemDAOImpl();

    @Override
    public void createPendingOrder(OrderList order) throws Exception {
        dao.insertPendingOrder(order);
    }

//    @Override
//    public OrderList getOrder(int orderId) throws Exception {
//        return dao.selectByOrderId(orderId);
//    }
    @Override
    public OrderList getOrder(int orderId) throws Exception {
        // 1) 헤더
        OrderList order = dao.selectByOrderId(orderId);
        if (order == null) return null;

        // 2) 아이템 리스트
        List<OrderItem> items = orderItemDao.selectByOrderId(orderId);
        order.setItems(items);

        return order;
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
