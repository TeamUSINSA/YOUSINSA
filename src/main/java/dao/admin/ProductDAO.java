package dao.admin;

import java.util.List;
import java.util.Map;

import dto.product.Product;
import dto.product.ProductStock;

public interface ProductDAO {

    // 상품 등록
    void insertProduct(Product product) throws Exception;

    // 상품 수정
    void updateProduct(Product product) throws Exception;

    // 상품 삭제
    void deleteProductById(int productId) throws Exception;

    // 상품 단건 조회
    Product selectProductById(int productId) throws Exception;
 
    // 전체 상품 목록 조회
    List<Product> selectProductList(String searchType, String keyword) throws Exception;

    // (옵션) 서브카테고리 ID로 상품 필터링
    List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception;
    
    void insertProductStockList(List<ProductStock> productStockList) throws Exception;
    
    List<String> getAllMainCategories() throws Exception;
    List<String> getAllSubCategories() throws Exception;
    
    int getTotalSales(String start, String end, String mainCategory, String subCategory) throws Exception;

	Map<String, List<Integer>> getSalesChartData(String start, String end) throws Exception;
}
