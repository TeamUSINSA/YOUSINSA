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
import dto.order.OrderList;
import dto.order.Return;

public class ReturnServiceImpl implements ReturnService {

    private ReturnDAO returnDAO;
    private ProductStockDAO productStockDAO = new ProductStockDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl(); // ⬅ 추가해줘야 해
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
    private OrderService orderService = new OrderServiceImpl();


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

	@Override
	public int requestReturn(Return returnRequest) throws Exception {
		// 1) 반품 테이블에 등록
        int cnt = returnDAO.insertReturn(returnRequest);
        // 2) 주문상품 상태를 '반품중'으로 변경
        returnDAO.updateOrderItemStatus(returnRequest);
     // 3) 같은 주문의 모든 아이템이 반품중(또는 완료) 상태인지 확인
        OrderList order = orderService.getOrderDetail(returnRequest.getOrderId());
        boolean allReturned = order.getItems().stream()
            .allMatch(i -> i.getStatus().equals("반품중") || i.getStatus().equals("반품완료"));

        if (allReturned) {
            // 전부 반품 대상이면 주문 전체도 '반품중' 또는 '반품완료'로
            returnDAO.updateOrderListStatus(returnRequest);
        }
        // 일부만 반품이면 orderlist 상태는 그대로 두거나,
        // 필요한 경우 '부분반품' 같은 별도 상태코드를 사용하세요.

        return cnt;
	}

	@Override
	public List<Return> getReturnsByUser(String userId) throws Exception {
		return returnDAO.selectReturnsByUserId(userId);
	}

	@Override
	public Return getReturnById(int returnId) throws Exception {
		return returnDAO.selectReturnById(returnId);
	}
}
