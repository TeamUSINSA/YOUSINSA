package dao.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.order.Cart;
import dto.order.Order;
import utils.MybatisSqlSessionFactory;

public class CartDAOImpl implements CartDAO {

    private SqlSession sqlSession;

    public CartDAOImpl() {
        sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // auto commit
    }

    @Override
    public List<Cart> selectCartListByUserId(String userId) {
        return sqlSession.selectList("mapper.cart.selectCartListByUserId", userId);
    }

    @Override
    public void insertCart(Cart cart) throws Exception{
        sqlSession.insert("mapper.cart.insertCart", cart);
    }

    @Override
    public void deleteCartById(int cartId) throws Exception{
        sqlSession.delete("mapper.cart.deleteCartById", cartId);
    }

    @Override
    public void deleteCartByUserId(String userId) throws Exception{
        sqlSession.delete("mapper.cart.deleteCartByUserId", userId);
    }

    @Override
    public void updateCartQuantity(Cart cart) throws Exception{
        sqlSession.update("mapper.cart.updateCartQuantity", cart);
    }

    @Override
    public Cart selectCartByUserAndProduct(Cart cart) throws Exception{
        return sqlSession.selectOne("mapper.cart.selectCartByUserAndProduct", cart);
    }

    @Override
    public List<Order> selectOrderItemsByCartIds(List<Integer> cartIds) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("cartIds", cartIds);
        return sqlSession.selectList("mapper.cart.selectOrderItemsByCartIds", param);
    }

}
