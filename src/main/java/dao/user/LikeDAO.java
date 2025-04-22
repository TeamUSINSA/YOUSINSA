package dao.user;

import java.util.List;

import dto.user.LikeList;

public interface LikeDAO {
	List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception;
    int countLikedProducts(String userId) throws Exception;
    void deleteLikeById(int likeId) throws Exception;
}
