// src/main/java/dao/user/LikeDAOImpl.java
package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import utils.MybatisSqlSessionFactory;
import dto.user.LikeList;

public class LikeDAOImpl implements LikeDAO {
    private SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("offset", offset);
        param.put("limit", limit);
        return session.selectList("mapper.user.selectLikedProducts", param);
    }

    @Override
    public int countLikedProducts(String userId) throws Exception {
        return session.selectOne("mapper.user.countLikedProducts", userId);
    }

    @Override
    public boolean existsLike(String userId, int productId) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("productId", productId);
        return session.selectOne("mapper.productdetail.existsLike", param);
    }

    @Override
    public void insertLike(String userId, int productId) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("productId", productId);
        session.insert("mapper.productdetail.insertLike", param);
        session.commit();
    }

    @Override
    public void deleteLike(String userId, int productId) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("productId", productId);
        session.delete("mapper.productdetail.deleteLike", param);
        session.commit();
    }

    @Override
    public int countLikes(int productId) throws Exception {
        return session.selectOne("mapper.productdetail.countLikesByProductId", productId);
    }
}
