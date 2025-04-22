package service.order;

import java.util.List;

import dto.order.Cart;

public interface CartService {
    List<Cart> getCartList(String userId) throws Exception;
    void addCart(Cart cart) throws Exception;
    void removeCartById(int cartId) throws Exception;
    void removeCartByUser(String userId) throws Exception;
    void updateQuantity(Cart cart) throws Exception;
    Cart getCartItem(Cart cart) throws Exception;
}
