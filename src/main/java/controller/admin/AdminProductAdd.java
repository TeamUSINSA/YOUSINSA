package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.product.Category;
import dto.product.Product;
import dto.product.ProductStock;
import service.admin.ProductService;
import service.admin.ProductServiceImpl;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

/**
 * Servlet implementation class AdminProductAdd
 */
@WebServlet("/adminproductadd")
public class AdminProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminProductAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryService service = new CategoryServiceImpl();
		try {
			List<Category> categoryList = service.selectCategoryList();
			request.setAttribute("categoryList", categoryList);
			request.setAttribute("subCategoryList", service.selectSubCategoriesByCategoryId(categoryList.get(0).getCategoryId()));
			request.getRequestDispatcher("admin/adminProductAdd.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletContext().getRealPath("upload");
		int size = 10*1024*1024;

		MultipartRequest multi = new MultipartRequest(request,path,size,"utf-8", new DefaultFileRenamePolicy());
		
	    Integer productId = Integer.parseInt(multi.getParameter("productId"));
	    String name = multi.getParameter("name");
	    Integer cost = Integer.parseInt(multi.getParameter("cost"));
	    Integer price  = Integer.parseInt(multi.getParameter("price"));    
	    Integer discount = Integer.parseInt(multi.getParameter("discount"));
	    Integer subCategory = Integer.parseInt(multi.getParameter("subCategory"));
	    String description1 = multi.getParameter("description1");;
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
	    
	    //option
	    String[] colorList = multi.getParameterValues("color");
	    String[] fSizeList = multi.getParameterValues("size-f");
	    String[] xsSizeList = multi.getParameterValues("size-xs");
	    String[] sSizeList = multi.getParameterValues("size-s");
	    String[] mSizeList = multi.getParameterValues("size-m");
	    String[] lSizeList = multi.getParameterValues("size-l");
	    String[] xlSizeList = multi.getParameterValues("size-xl");
	    
	    List<ProductStock> stockList = new ArrayList<>();
	    for(int i=0; i<colorList.length; i++) {
	    	if(fSizeList[i]!=null && fSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(fSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("free");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}
	    	if(xsSizeList[i]!=null && xsSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(xsSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("xs");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}
	    	if(sSizeList[i]!=null && sSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(sSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("s");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}
	    	if(mSizeList[i]!=null && mSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(mSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("m");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}
	    	if(lSizeList[i]!=null && lSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(lSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("l");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}
	    	if(xlSizeList[i]!=null && xlSizeList[i].trim().length()>0) {
	    		Integer quantity = Integer.parseInt(xlSizeList[i]);
	    		if(quantity>0) {
	    	    	ProductStock stock = new ProductStock();
	    	    	stock.setProductId(productId);
	    	    	stock.setColor(colorList[i]);
		    		stock.setSize("xl");
		    		stock.setQuantity(quantity);
			    	stockList.add(stock);
	    		}
	    	}		
	    }
	    System.out.println(product);
	    System.out.println(stockList);
	    
	    try {
	    	ProductService service = new ProductServiceImpl();
	    	service.insertProduct(product);
	    	service.setProductStockList(stockList);
	    	request.setAttribute("productId", product.getProductId());
	    	request.getRequestDispatcher("productDetail").forward(request, response);
	    }  catch(Exception e) {
	    	e.printStackTrace();
	    	request.getRequestDispatcher("error.jsp").forward(request, response);
	    }
	}
}
