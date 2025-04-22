package service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import dao.user.LikeDAO;
import dao.user.LikeDAOImpl;
import dto.user.LikeList;

public class LikeServiceImpl implements LikeService {

    private LikeDAO likeDAO = new LikeDAOImpl();

    @Override
    public List<LikeList> getLikedProductsByUserId(String userId, int page, int pageSize) throws Exception {
    	int offset = (page - 1) * pageSize;
        return likeDAO.getLikedProductsByUserId(userId, offset, pageSize);
    }

    @Override
    public int countLikedProducts(String userId) throws Exception {
        return likeDAO.countLikedProducts(userId);
    }

	@Override
	public void removeLike(int likeId) throws Exception {
		likeDAO.deleteLikeById(likeId);
	}
}
