package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.product.Product;
import dto.product.ProductQuantity;
import dto.product.ProductStock;

public interface AdminProductDAO {

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
    
    List<ProductStock> selectStockByProductId(Integer productId) throws Exception;
    
	List<String> selectStockColorByProductId(Integer productId) throws Exception;
	List<ProductQuantity> selectStockByColor(Integer productId, String color) throws Exception;
 
	void deleteStockByProductId(Integer productId) throws Exception;
	
	void deleteStockByProductId(Integer productId, SqlSession session) throws Exception;
	void updateProduct(Product product, SqlSession session) throws Exception;
	void insertProductStockList(List<ProductStock> stockList, SqlSession session) throws Exception;
	
	// 재고 존재 여부 확인
	int countStockByProductIdColorSize(int productId, String color, String size, SqlSession session) throws Exception;

	// 재고 수량 업데이트
	void updateStockQuantity(ProductStock stock, SqlSession session) throws Exception;

	// 재고 새로 삽입
	void insertProductStock(ProductStock stock, SqlSession session) throws Exception;
}
