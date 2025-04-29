package dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.user.LikeList;
import utils.MybatisSqlSessionFactory;

public class LikeDAOImpl implements LikeDAO {

    private final SqlSessionFactory factory =
        MybatisSqlSessionFactory.getSqlSessionFactory();

    @Override
    public List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception {
        try (SqlSession session = factory.openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("userId", userId);
            param.put("offset", offset);
            param.put("limit", limit);
            return session.selectList("mapper.user.selectLikedProducts", param);
        }
    }

    @Override
    public int countLikedProducts(String userId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            return session.selectOne("mapper.user.countLikedProducts", userId);
        }
    }

    @Override
    public boolean existsLike(String userId, int productId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("userId", userId);
            param.put("productId", productId);
            return session.selectOne("mapper.productdetail.existsLike", param);
        }
    }

    @Override
    public void deleteLikeById(int likeId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            session.delete("mapper.user.deleteLikeById", likeId);
            session.commit();
        }
    }

    @Override
    public void insertLike(String userId, int productId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("userId", userId);
            param.put("productId", productId);
            session.insert("mapper.productdetail.insertLike", param);
            session.commit();
        }
    }

    @Override
    public void deleteLike(String userId, int productId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("userId", userId);
            param.put("productId", productId);
            session.delete("mapper.productdetail.deleteLike", param);
            session.commit();
        }
    }

    @Override
    public int countLikes(int productId) throws Exception {
        try (SqlSession session = factory.openSession()) {
            return session.selectOne("mapper.productdetail.countLikesByProductId", productId);
        }
    }
}
