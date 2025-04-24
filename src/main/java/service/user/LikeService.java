// src/main/java/service/user/LikeService.java
package service.user;

import java.util.List;
import dto.user.LikeList;

public interface LikeService {
	// 페이징된 좋아요 상품 조회
	List<LikeList> getLikedProductsByUserId(String userId, int page, int pageSize) throws Exception;

	// 특정 유저 총 좋아요 개수
	int countLikedProducts(String userId) throws Exception;

	void removeLike(int likeId) throws Exception;

	// 토글: 좋아요 여부를 뒤집고, true=좋아요된 상태, false=취소된 상태 반환
	boolean toggleLike(String userId, int productId) throws Exception;

	// 상품 전체 좋아요 수 조회
	int countLikes(int productId) throws Exception;

	boolean existsLike(String userId, int productId) throws Exception;

}
