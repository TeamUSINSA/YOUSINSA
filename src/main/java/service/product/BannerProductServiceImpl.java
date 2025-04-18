package service.product;

import java.util.List;

import dao.product.BannerProductDAO;
import dao.product.BannerProductDAOImpl;
import dto.product.BannerProduct;

public class BannerProductServiceImpl implements BannerProductService{
	
	 private BannerProductDAO bannerProductDAO;

	    public BannerProductServiceImpl() {
	        this.bannerProductDAO = new BannerProductDAOImpl();
	    }

	    @Override
	    public List<BannerProduct> getMainBannerList() {
	        return bannerProductDAO.selectMainBannerList();
	    }
	    
	    @Override
	    public List<BannerProduct> getSubBannerList() {
	        return bannerProductDAO.selectSubBannerList();
	    }

}
