// src/main/java/service/user/LikeServiceImpl.java
package service.user;

import java.util.List;

import dao.user.LikeDAO;
import dao.user.LikeDAOImpl;
import dto.user.LikeList;

public class LikeServiceImpl implements LikeService {

	private LikeDAO likeDAO = new LikeDAOImpl();

	@Override
	public List<LikeList> getLikedProductsByUserId(String userId, int offset, int limit) throws Exception {
		return likeDAO.getLikedProductsByUserId(userId, offset, limit);
	}

	@Override
	public int countLikedProducts(String userId) throws Exception {
		return likeDAO.countLikedProducts(userId);
	}

	@Override
	public void removeLike(int likeId) throws Exception {
		likeDAO.deleteLikeById(likeId);
	}

	@Override
	public boolean toggleLike(String userId, int productId) throws Exception {
		boolean exists = likeDAO.existsLike(userId, productId);
		if (exists) {
			likeDAO.deleteLike(userId, productId);
			return false;
		} else {
			likeDAO.insertLike(userId, productId);
			return true;
		}
	}

	@Override
	public int countLikes(int productId) throws Exception {
		return likeDAO.countLikes(productId);
	}

	@Override
	public boolean existsLike(String userId, int productId) throws Exception {
		return likeDAO.existsLike(userId, productId);
	}

}
