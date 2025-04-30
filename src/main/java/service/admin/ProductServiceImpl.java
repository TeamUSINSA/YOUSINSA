package service.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.admin.AdminProductDAO;
import dao.admin.AdminProductDAOImpl;
import dto.product.Product;
import dto.product.ProductAndOption;
import dto.product.ProductOption;
import dto.product.ProductStock;
import utils.MybatisSqlSessionFactory;

public class ProductServiceImpl implements ProductService {

	private AdminProductDAO productDAO = new AdminProductDAOImpl();

	@Override
	public Integer regProduct(HttpServletRequest request) throws Exception {
		String path = request.getServletContext().getRealPath("upload");
		int size = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		Integer productId = Integer.parseInt(multi.getParameter("productId"));
		String name = multi.getParameter("name");
		Integer cost = Integer.parseInt(multi.getParameter("cost"));
		Integer price = Integer.parseInt(multi.getParameter("price"));
		Integer discount = Integer.parseInt(multi.getParameter("discount"));
//		Integer category = Integer.parseInt(multi.getParameter("category"));
		Integer subCategory = Integer.parseInt(multi.getParameter("subCategory"));
		String description1 = multi.getParameter("description1");

		String sizeType = multi.getParameter("sizeType");
		if (sizeType == null || sizeType.trim().isEmpty()) {
			sizeType = "F";
		}

		Product product = new Product();
		product.setProductId(productId);
		product.setName(name);
		product.setCost(cost);
		product.setPrice(price);
		product.setDiscount(discount);
//		product.setCategoryId(category);
		product.setSubCategoryId(subCategory);
		product.setDescription1(description1);
		product.setSizeType(sizeType);
		product.setMainImage1(multi.getFilesystemName("mainImage1"));
		product.setMainImage2(multi.getFilesystemName("mainImage2"));
		product.setMainImage3(multi.getFilesystemName("mainImage3"));
		product.setMainImage4(multi.getFilesystemName("mainImage4"));
		product.setImage1(multi.getFilesystemName("image1"));
		product.setImage2(multi.getFilesystemName("image2"));
		product.setImage3(multi.getFilesystemName("image3"));
		product.setImage4(multi.getFilesystemName("image4"));
		product.setSizeChart(multi.getFilesystemName("sizeChart"));

		List<ProductStock> stockList = parseStockList(multi, productId, sizeType);

		productDAO.insertProduct(product);
		setProductStockList(stockList);

		return productId;
	}

	public Integer modifyProduct(HttpServletRequest request) throws Exception {
	    String path = request.getServletContext().getRealPath("upload");
	    int size = 10 * 1024 * 1024;

	    SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false); // auto-commit false

	    try {
	        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

	        System.out.println("multi = " + multi);
	        System.out.println("multi.getParameter(productId) = " + multi.getParameter("productId"));

	        String productIdStr = multi.getParameter("productId");
	        Integer productId = (productIdStr == null || productIdStr.isEmpty()) ? null : Integer.parseInt(productIdStr);

	        String name = multi.getParameter("name");

	        String costStr = multi.getParameter("cost");
	        Integer cost = (costStr == null || costStr.trim().isEmpty()) ? 0 : Integer.parseInt(costStr);

	        String priceStr = multi.getParameter("price");
	        Integer price = (priceStr == null || priceStr.trim().isEmpty()) ? 0 : Integer.parseInt(priceStr);

	        String discountStr = multi.getParameter("discount");
	        Integer discount = (discountStr == null || discountStr.trim().isEmpty()) ? 0 : Integer.parseInt(discountStr);

	        String subCategoryStr = multi.getParameter("subCategory");
	        Integer subCategory = null;
	        if (subCategoryStr != null && !subCategoryStr.isEmpty()) {
	            subCategory = Integer.parseInt(subCategoryStr);
	            if (subCategory == 0) {
	                throw new IllegalArgumentException("서브카테고리를 선택해야 합니다.");
	            }
	        } else {
	            throw new IllegalArgumentException("서브카테고리를 선택해야 합니다.");
	        }

	        String description1 = multi.getParameter("description1");

	        String sizeType = multi.getParameter("sizeType");
	        if (sizeType == null || sizeType.trim().isEmpty()) {
	            sizeType = "F";
	        }

	        Product product = new Product();
	        product.setProductId(productId);
	        product.setName(name);
	        product.setCost(cost);
	        product.setPrice(price);
	        product.setDiscount(discount);
	        product.setSubCategoryId(subCategory);
	        product.setSizeType(sizeType);
	        product.setDescription1(description1);

	        restoreImages(multi, product);

	        List<ProductStock> stockList = parseStockList(multi, productId, sizeType);
	        System.out.println(stockList);

	        for (ProductStock ps : stockList) {
	            if (ps.getColor() == null || ps.getColor().isBlank()
	                    || ps.getSize() == null || ps.getSize().isBlank()
	                    || ps.getQuantity() <= 0 ){
	                throw new IllegalArgumentException("색상, 사이즈, 수량을 모두 입력해야 합니다.");
	            }
	        }

	        productDAO.updateProduct(product, session);

	        for (ProductStock ps : stockList) {
	            int count = productDAO.countStockByProductIdColorSize(
	                ps.getProductId(), ps.getColor(), ps.getSize(), session);

	            System.out.println(productId);
	            System.out.println(ps.getColor());
	            System.out.println(ps.getSize());
	            System.out.println(count);
	            System.out.println("====================================================================");
	            
	            if (count > 0) {
	                productDAO.updateStockQuantity(ps, session);
	            } else {
	                productDAO.insertProductStock(ps, session);
	            }
	        }


	        session.commit();
	        return productId;

	    } catch (Exception e) {
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
	}


	private void restoreImages(MultipartRequest multi, Product product) {
		String[] imageFields = { "mainImage1", "mainImage2", "mainImage3", "mainImage4", "image1", "image2", "image3",
				"image4", "sizeChart" };

		for (String field : imageFields) {
			String newFile = multi.getFilesystemName(field);
			String oldFile = multi.getParameter("old" + capitalize(field));

			if (newFile != null) {
				setProductImage(product, field, newFile);
			} else if (oldFile != null && !"".equals(oldFile)) {
				setProductImage(product, field, oldFile);
			}
		}
	}

	private String capitalize(String str) {
		if (str == null || str.isEmpty())
			return str;
		return str.substring(0, 1).toUpperCase() + str.substring(1);
	}

	private void setProductImage(Product product, String field, String filename) {
		switch (field) {
		case "mainImage1":
			product.setMainImage1(filename);
			break;
		case "mainImage2":
			product.setMainImage2(filename);
			break;
		case "mainImage3":
			product.setMainImage3(filename);
			break;
		case "mainImage4":
			product.setMainImage4(filename);
			break;
		case "image1":
			product.setImage1(filename);
			break;
		case "image2":
			product.setImage2(filename);
			break;
		case "image3":
			product.setImage3(filename);
			break;
		case "image4":
			product.setImage4(filename);
			break;
		case "sizeChart":
			product.setSizeChart(filename);
			break;
		}
	}

	private List<ProductStock> parseStockList(MultipartRequest multi, int productId, String sizeType) {
	    List<ProductStock> stockList = new ArrayList<>();
	    
	    String[] colorList = multi.getParameterValues("color");

	    // 🔥 colorList가 null이면 아예 재고 리스트 없이 끝내기
	    if (colorList == null || colorList.length == 0) {
	        return stockList;
	    }

	    if ("F".equals(sizeType)) {
	        String[] fSizeList = multi.getParameterValues("F");
	        for (int i = 0; i < colorList.length; i++) {
	            // 🔥🔥 fSizeList도 null 체크
	            if (fSizeList != null && fSizeList.length > i && fSizeList[i] != null && !fSizeList[i].trim().isEmpty()) {
	                Integer quantity = Integer.parseInt(fSizeList[i]);
	                ProductStock stock = new ProductStock(productId, colorList[i], "F", quantity);
	                stockList.add(stock);
	            }
	        }
	    } else {
	        String[] sizeNames = {"XS", "S", "M", "L", "XL"};
	        for (int i = 0; i < colorList.length; i++) {
	            for (String sizeName : sizeNames) {
	                String[] sizeArray = multi.getParameterValues(sizeName);
	                if (sizeArray != null && sizeArray.length > i && sizeArray[i] != null && !sizeArray[i].trim().isEmpty()) {
	                    Integer quantity = Integer.parseInt(sizeArray[i]);
	                    ProductStock stock = new ProductStock(productId, colorList[i], sizeName, quantity);
	                    stockList.add(stock);
	                }
	            }
	        }
	    }

	    return stockList;
	}


	@Override
	public void deleteProductById(int productId) throws Exception {
		productDAO.deleteProductById(productId);
	}

	@Override
	public Product selectProductById(int productId) throws Exception {
		return productDAO.selectProductById(productId);
	}

	@Override
	public List<Product> searchProduct(String searchType, String keyword) throws Exception {
		return productDAO.selectProductList(searchType, keyword);
	}

	@Override
	public List<Product> selectProductsBySubCategoryId(int subCategoryId) throws Exception {
		return productDAO.selectProductsBySubCategoryId(subCategoryId);
	}

	@Override
	public void setProductStockList(List<ProductStock> productStockList) throws Exception {
		productDAO.insertProductStockList(productStockList);
	}

	@Override
	public ProductAndOption getProductAndOption(Integer productId) throws Exception {
		ProductAndOption pao = new ProductAndOption();
		Product product = productDAO.selectProductById(productId);
		List<String> colorList = productDAO.selectStockColorByProductId(productId);

		pao.setProduct(product);
		for (String color : colorList) {
			ProductOption po = new ProductOption();
			po.setColor(color);
			po.setSizeQuanity(productDAO.selectStockByColor(productId, color));
			pao.getOptionList().add(po);
		}
		return pao;
	}

	@Override
	public Product findProductById(int productId) throws Exception {
		return productDAO.selectProductById(productId);
	}
}
