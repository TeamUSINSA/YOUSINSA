
package service.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.admin.AdminProductDAO;
import dao.admin.AdminProductDAOImpl;
import dto.product.Product;
import dto.product.ProductAndOption;
import dto.product.ProductOption;
import dto.product.ProductStock;

public class ProductServiceImpl implements ProductService {

	// DAO 연결
	private AdminProductDAO productDAO = new AdminProductDAOImpl();

	@Override
	public Integer regProduct(HttpServletRequest request) throws Exception {
	    String path = request.getServletContext().getRealPath("upload");
	    int size = 10 * 1024 * 1024;

	    MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

	    // 상품 기본 정보
	    Integer productId = Integer.parseInt(multi.getParameter("productId"));
	    String name = multi.getParameter("name");
	    Integer cost = Integer.parseInt(multi.getParameter("cost"));
	    Integer price = Integer.parseInt(multi.getParameter("price"));
	    Integer discount = Integer.parseInt(multi.getParameter("discount"));
	    Integer category = Integer.parseInt(multi.getParameter("category"));
	    Integer subCategory = Integer.parseInt(multi.getParameter("subCategory"));
	    String description1 = multi.getParameter("description1");

	    String mainImage1 = multi.getFilesystemName("mainImage1");
	    String mainImage2 = multi.getFilesystemName("mainImage2");
	    String mainImage3 = multi.getFilesystemName("mainImage3");
	    String mainImage4 = multi.getFilesystemName("mainImage4");
	    String image1 = multi.getFilesystemName("image1");
	    String image2 = multi.getFilesystemName("image2");
	    String image3 = multi.getFilesystemName("image3");
	    String image4 = multi.getFilesystemName("image4");
	    String sizeChart = multi.getFilesystemName("sizeChart");

	    Product product = new Product();
	    product.setProductId(productId);
	    product.setName(name);
	    product.setCost(cost);
	    product.setPrice(price);
	    product.setDiscount(discount);
	    product.setCategoryId(category);
	    product.setSubCategoryId(subCategory);
	    product.setDescription1(description1);
	    product.setMainImage1(mainImage1);
	    product.setMainImage2(mainImage2);
	    product.setMainImage3(mainImage3);
	    product.setMainImage4(mainImage4);
	    product.setImage1(image1);
	    product.setImage2(image2);
	    product.setImage3(image3);
	    product.setImage4(image4);
	    product.setSizeChart(sizeChart);

	    // 옵션 관련
	    String[] colorList = multi.getParameterValues("color");
	    String[] sizeTypes = multi.getParameterValues("sizeType");

	    List<ProductStock> stockList = new ArrayList<>();

	    if (colorList != null) {
	        for (int i = 0; i < colorList.length; i++) {
	            String sizeType = (sizeTypes != null && sizeTypes.length > i) ? sizeTypes[i] : "F"; // 기본값 'F'

	            if ("F".equals(sizeType)) {
	                String[] fSizeList = multi.getParameterValues("F");
	                if (fSizeList == null || fSizeList.length <= i) {
	                    throw new IllegalArgumentException("F 사이즈 수량이 색상 개수보다 적습니다.");
	                }
	                Integer quantity = Integer.parseInt(fSizeList[i]);
	                ProductStock stock = new ProductStock();
	                stock.setProductId(productId);
	                stock.setColor(colorList[i]);
	                stock.setSize("F");
	                stock.setQuantity(quantity);
	                stockList.add(stock);

	            } else { // M 사이즈 그룹
	                String[] xsSizeList = multi.getParameterValues("XS");
	                String[] sSizeList = multi.getParameterValues("S");
	                String[] mSizeList = multi.getParameterValues("M");
	                String[] lSizeList = multi.getParameterValues("L");
	                String[] xlSizeList = multi.getParameterValues("XL");

	                String[] sizeNames = {"XS", "S", "M", "L", "XL"};
	                String[][] sizeArrays = {xsSizeList, sSizeList, mSizeList, lSizeList, xlSizeList};

	                for (int j = 0; j < sizeNames.length; j++) {
	                    if (sizeArrays[j] != null && sizeArrays[j].length > i && sizeArrays[j][i] != null && !sizeArrays[j][i].trim().isEmpty()) {
	                        Integer quantity = Integer.parseInt(sizeArrays[j][i]);
	                        ProductStock stock = new ProductStock();
	                        stock.setProductId(productId);
	                        stock.setColor(colorList[i]);
	                        stock.setSize(sizeNames[j]);
	                        stock.setQuantity(quantity);
	                        stockList.add(stock);
	                    }
	                }
	            }
	        }
	    }

	    productDAO.insertProduct(product);
	    setProductStockList(stockList);

	    return productId;
	}

	@Override
	public Integer modifyProduct(HttpServletRequest request) throws Exception {
		String path = request.getServletContext().getRealPath("upload");
		int size = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		Integer productId = Integer.parseInt(multi.getParameter("productId"));
		String name = multi.getParameter("name");
		Integer cost = Integer.parseInt(multi.getParameter("cost"));
		Integer price = Integer.parseInt(multi.getParameter("price"));
		Integer discount = Integer.parseInt(multi.getParameter("discount"));
		Integer category = Integer.parseInt(multi.getParameter("category"));
		Integer subCategory = Integer.parseInt(multi.getParameter("subCategory"));
		String description1 = multi.getParameter("description1");
		;
		String sizeType = multi.getParameter("sizeType");
		String mainImage1 = multi.getFilesystemName("mainImage1");
		String mainImage2 = multi.getFilesystemName("mainImage2");
		String mainImage3 = multi.getFilesystemName("mainImage3");
		String mainImage4 = multi.getFilesystemName("mainImage4");
		String image1 = multi.getFilesystemName("image1");
		String image2 = multi.getFilesystemName("image2");
		String image3 = multi.getFilesystemName("image3");
		String image4 = multi.getFilesystemName("image4");
		String sizeChart = multi.getFilesystemName("sizeChart");

		String oldMainImage1 = multi.getParameter("oldMainImage1");
		String oldMainImage2 = multi.getParameter("oldMainImage2");
		String oldMainImage3 = multi.getParameter("oldMainImage3");
		String oldMainImage4 = multi.getParameter("oldMainImage4");
		String oldImage1 = multi.getParameter("oldImage1");
		String oldImage2 = multi.getParameter("oldImage2");
		String oldImage3 = multi.getParameter("oldImage3");
		String oldImage4 = multi.getParameter("oldImage4");
		String oldSizeChart = multi.getParameter("oldSizeChart");

		Product product = new Product();
		product.setProductId(productId);
		product.setName(name);
		product.setCost(cost);
		product.setPrice(price);
		product.setDiscount(discount);
		product.setCategoryId(category);
		product.setSubCategoryId(subCategory);
		product.setSizeType(sizeType);
		product.setDescription1(description1);
		product.setMainImage1(mainImage1);
		product.setMainImage2(mainImage2);
		product.setMainImage3(mainImage3);
		product.setMainImage4(mainImage4);
		product.setImage1(image1);
		product.setImage2(image2);
		product.setImage3(image3);
		product.setImage4(image4);
		product.setSizeChart(sizeChart);

		String[] colorList = multi.getParameterValues("color");
		List<ProductStock> stockList = new ArrayList<>();
		if (sizeType.equals("F")) {
			String[] fSizeList = multi.getParameterValues("F");
			if (fSizeList != null) {
				for (int i = 0; i < colorList.length; i++) {
					if (fSizeList.length > i && fSizeList[i] != null && fSizeList[i].trim().length() > 0) {
						Integer quantity = Integer.parseInt(fSizeList[i]);
						ProductStock stock = new ProductStock();
						stock.setProductId(productId);
						stock.setColor(colorList[i]);
						stock.setSize("F");
						stock.setQuantity(quantity);
						stockList.add(stock);
					}
				}
			}
		} else {
			String[] xsSizeList = multi.getParameterValues("XS");
			String[] sSizeList = multi.getParameterValues("S");
			String[] mSizeList = multi.getParameterValues("M");
			String[] lSizeList = multi.getParameterValues("L");
			String[] xlSizeList = multi.getParameterValues("XL");
			for (int i = 0; i < colorList.length; i++) {
				Integer quantity = 0;
				if (xsSizeList[i] != null && xsSizeList[i].trim().length() > 0)
					quantity = Integer.parseInt(xsSizeList[i]);
				ProductStock stock = new ProductStock();
				stock.setProductId(productId);
				stock.setColor(colorList[i]);
				stock.setSize("XS");
				stock.setQuantity(quantity);
				stockList.add(stock);

				if (sSizeList[i] != null && sSizeList[i].trim().length() > 0)
					quantity = Integer.parseInt(sSizeList[i]);
				else
					quantity = 0;
				stock = new ProductStock();
				stock.setProductId(productId);
				stock.setColor(colorList[i]);
				stock.setSize("S");
				stock.setQuantity(quantity);
				stockList.add(stock);

				if (mSizeList[i] != null && mSizeList[i].trim().length() > 0)
					quantity = Integer.parseInt(mSizeList[i]);
				else
					quantity = 0;
				stock = new ProductStock();
				stock.setProductId(productId);
				stock.setColor(colorList[i]);
				stock.setSize("M");
				stock.setQuantity(quantity);
				stockList.add(stock);

				if (lSizeList[i] != null && lSizeList[i].trim().length() > 0)
					quantity = Integer.parseInt(lSizeList[i]);
				else
					quantity = 0;
				stock = new ProductStock();
				stock.setProductId(productId);
				stock.setColor(colorList[i]);
				stock.setSize("L");
				stock.setQuantity(quantity);
				stockList.add(stock);

				if (xlSizeList[i] != null && xlSizeList[i].trim().length() > 0)
					quantity = Integer.parseInt(xlSizeList[i]);
				else
					quantity = 0;
				stock = new ProductStock();
				stock.setProductId(productId);
				stock.setColor(colorList[i]);
				stock.setSize("XL");
				stock.setQuantity(quantity);
				stockList.add(stock);
			}
		}

//		    System.out.println(product);
//		    System.out.println(stockList);    	

		// 이미지 복원
		// mainImage1
		if (oldMainImage1 != null && product.getMainImage1() == null) {
			product.setMainImage1(oldMainImage1);
		}
		// mainImage2
		if (oldMainImage2 != null && product.getMainImage2() == null) {
			product.setMainImage2(oldMainImage2);
		}
		// mainImage3
		if (oldMainImage3 != null && product.getMainImage3() == null) {
			product.setMainImage3(oldMainImage3);
		}
		// mainImage4
		if (oldMainImage4 != null && product.getMainImage4() == null) {
			product.setMainImage4(oldMainImage4);
		}
		// image1
		if (oldImage1 != null && product.getImage1() == null) {
			product.setImage1(oldImage1);
		}
		// image2
		if (oldImage2 != null && product.getImage2() == null) {
			product.setImage2(oldImage2);
		}
		// image1
		if (oldImage3 != null && product.getImage3() == null) {
			product.setImage3(oldImage3);
		}
		// image1
		if (oldImage4 != null && product.getImage4() == null) {
			product.setImage4(oldImage4);
		}
		// sizeChart
		if (oldSizeChart != null && product.getSizeChart() == null) {
			product.setSizeChart(oldSizeChart);
		}

		productDAO.deleteStockByProductId(productId);
		productDAO.updateProduct(product);
		setProductStockList(stockList);
		return productId;
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
