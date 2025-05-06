package service.order;

import java.util.List;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dao.order.OrderItemDAO;
import dao.order.OrderItemDAOImpl;
import dao.order.ReturnDAO;
import dao.order.ReturnDAOImpl;
import dao.product.ProductStockDAO;
import dao.product.ProductStockDAOImpl;
import dto.order.OrderItem;
import dto.order.Return;

public class ReturnServiceImpl implements ReturnService {

    private ReturnDAO returnDAO;
    private ProductStockDAO productStockDAO = new ProductStockDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl(); // ⬅ 추가해줘야 해
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

    public ReturnServiceImpl() {
        this.returnDAO = new ReturnDAOImpl();
    }

    @Override
    public List<Return> getAllReturns() throws Exception {
        return returnDAO.selectAllReturns();
    }

    @Override
    public List<Return> getReturnsByApproved(int approved) throws Exception {
        return returnDAO.selectReturnsByApproved(approved);
    }

    @Override
    public int getTotalPages() throws Exception {
        return returnDAO.getTotalPages();
    }


    @Override
    public void approveReturn(int returnId) throws Exception {
        returnDAO.updateApprovedStatus(returnId, 1); // 승인

        Return refund = returnDAO.selectReturnById(returnId); // 환불 정보
        OrderItem item = orderDAO.selectOrderItemById(refund.getOrderItemId());

        productStockDAO.increaseQuantity(
            item.getProductId(),
            item.getColor(),
            item.getSize(),
            item.getQuantity()
        );
        orderItemDAO.updateOrderItemStatus(refund.getOrderItemId(), "반품승인");
    }

    @Override
    public void rejectReturn(int returnId, String rejectReason) throws Exception {
        returnDAO.updateRejectedStatus(returnId, 2, rejectReason); // 2 = 반려
        
        int orderItemId = returnDAO.getOrderItemIdByReturnId(returnId);
        orderItemDAO.updateOrderItemStatus(orderItemId, "반품반려");
    }
}
