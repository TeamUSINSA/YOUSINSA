package dao.product;

import java.util.List;
import dto.product.BannerProduct;

public interface BannerProductDAO {

    // 메인 배너 리스트 (position = 'main')
    List<BannerProduct> selectMainBannerList() throws Exception;

    // 서브 배너 리스트 (position = 'sub')
    List<BannerProduct> selectSubBannerList() throws Exception;

    // 배너 전체 목록
    List<BannerProduct> selectAllBannerList() throws Exception;

    

//    // 배너 삭제
//    int deleteBanner(int id) throws Exception;

    // 특정 배너 조회
    BannerProduct findBannerById(int id) throws Exception;
    void insertBanner(BannerProduct banner) throws Exception;
    
    void deleteBanner(int id) throws Exception;
    List<BannerProduct> selectAll() throws Exception;
}
