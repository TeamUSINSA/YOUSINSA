package dao.product;

import java.util.List;

import dto.product.BannerProduct;

public interface BannerProductDAO {

	List<BannerProduct> selectMainBannerList();

	List<BannerProduct> selectSubBannerList();

}
	