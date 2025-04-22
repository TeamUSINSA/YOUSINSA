package service.product;

import java.util.List;

import dto.product.BannerProduct;

public interface BannerProductService {

	List<BannerProduct> getMainBannerList() throws Exception;

	List<BannerProduct> getSubBannerList() throws Exception;

}
