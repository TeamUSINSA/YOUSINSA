// src/main/java/dao/user/LikeDAO.java
package dao.user;

import java.util.List;
import dto.user.LikeList;

public interface LikeDAO {
	// 페이징된 좋아요 상품 조회
	List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception;

	// 특정 유저 총 좋아요 개수
	int countLikedProducts(String userId) throws Exception;

	void deleteLikeById(int likeId) throws Exception;

	// 토글용 메서드
	// 해당 유저가 해당 상품을 이미 좋아요했는지
	boolean existsLike(String userId, int productId) throws Exception;

	// 좋아요 추가
	void insertLike(String userId, int productId) throws Exception;

	// 좋아요 삭제
	void deleteLike(String userId, int productId) throws Exception;

	// 상품 전체 좋아요 수 조회
	int countLikes(int productId) throws Exception;

}
