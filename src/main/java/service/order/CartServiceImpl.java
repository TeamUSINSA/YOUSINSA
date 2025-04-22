package service.order;

import java.util.List;
import dao.order.CartDAO;
import dao.order.CartDAOImpl;
import dto.order.Cart;

public class CartServiceImpl implements CartService {

    private CartDAO cartDAO;

    public CartServiceImpl() {
        cartDAO = new CartDAOImpl();
    }

    @Override
    public List<Cart> getCartList(String userId) throws Exception{
        return cartDAO.selectCartListByUserId(userId);
    }

    @Override
    public void addCart(Cart cart) throws Exception{
        cartDAO.insertCart(cart);
    }

    @Override
    public void removeCartById(int cartId) throws Exception{
        cartDAO.deleteCartById(cartId);
    }

    @Override
    public void removeCartByUser(String userId) throws Exception{
        cartDAO.deleteCartByUserId(userId);
    }

    @Override
    public void updateQuantity(Cart cart) throws Exception{
        cartDAO.updateCartQuantity(cart);
    }

    @Override
    public Cart getCartItem(Cart cart) throws Exception{
        return cartDAO.selectCartByUserAndProduct(cart);
    }
}
