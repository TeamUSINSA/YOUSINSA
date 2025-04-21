package dao.order;

import java.util.List;
import dto.order.Cart;

public interface CartDAO {
    List<Cart> selectCartListByUserId(String userId) throws Exception;
    void insertCart(Cart cart) throws Exception;
    void deleteCartById(int cartId) throws Exception;
    void deleteCartByUserId(String userId) throws Exception;
    void updateCartQuantity(Cart cart) throws Exception;
    Cart selectCartByUserAndProduct(Cart cart) throws Exception;
}
