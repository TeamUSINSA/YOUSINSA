package service.user;

import java.util.List;

import dto.user.LikeList;

public interface LikeService {
	List<LikeList> getLikedProductsByUserId(String userId,int page, int pageSize) throws Exception;
    int countLikedProducts(String userId) throws Exception;
    void removeLike(int likeId) throws Exception;
}
