package dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.order.Cart;
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
}
