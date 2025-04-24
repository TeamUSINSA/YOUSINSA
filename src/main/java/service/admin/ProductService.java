package service.admin;

import java.util.List;

import dto.product.Product;
import dto.product.ProductStock;

public interface ProductService {

    // 상품 등록
    void insertProduct(Product product) throws Exception;

    // 상품 수정
    void updateProduct(Product product) throws Exception;

    // 상품 삭제
    void deleteProductById(int productId) throws Exception;

    // 단일 상품 조회
    Product selectProductById(int productId) throws Exception;

    // 전체 상품 목록 조회
    List<Product> searchProduct(String searchType, String keyword) throws Exception;

    // (선택) 서브카테고리 기준으로 상품 조회
    List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception;
    
    void setProductStockList(List<ProductStock> productStockList) throws Exception;
    
}
