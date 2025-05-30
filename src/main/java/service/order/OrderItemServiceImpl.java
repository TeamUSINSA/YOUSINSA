package service.order;

import java.util.List;

import dao.order.OrderItemDAO;
import dao.order.OrderItemDAOImpl;
import dto.order.OrderItem;
import dto.product.Product;

public class OrderItemServiceImpl implements OrderItemService {

	private OrderItemDAO dao = new OrderItemDAOImpl();

	@Override
	public List<OrderItem> getItems(int orderId) throws Exception {
		return dao.selectByOrderId(orderId);
	}

	@Override
	public void addItem(OrderItem item) throws Exception {
		dao.insert(item);
	}
	
	 @Override
	 public List<Product> getTopSellingProducts(int count) throws Exception {
	        return dao.selectTopSellingProducts(count);
	    }

}
