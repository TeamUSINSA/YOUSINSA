package controller.admin;

import java.io.IOException;
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
import dto.product.SubCategory;
import service.product.CategoryService;
import service.product.CategoryServiceImpl;

@WebServlet("/adminproductadd")
public class AdminProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 상품 등록 폼 진입
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		CategoryService service = new CategoryServiceImpl();
		try {
			List<Category> categoryList = service.selectCategoryList();
			List<SubCategory> subCategoryList = service
					.selectSubCategoriesByCategoryId(categoryList.get(0).getCategoryId());

			request.setAttribute("categoryList", categoryList);
			request.setAttribute("subCategoryList", subCategoryList);
			request.getRequestDispatcher("admin/adminProductAdd.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

	// 상품 등록 처리
	
    	@Override
    	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    	        throws ServletException, IOException {

    	    Product product = new Product();

    	    try {
    	        // 🔹 MultipartRequest 초기화
    	        String path = request.getServletContext().getRealPath("upload");
    	        int size = 10 * 1024 * 1024;

    	        MultipartRequest multi = new MultipartRequest(
    	            request,
    	            path,
    	            size,
    	            "utf-8",
    	            new DefaultFileRenamePolicy()
    	        );

    	        // 🔹 값 세팅
    	        product.setName(multi.getParameter("name"));
    	        product.setCode(multi.getParameter("code"));
    	        product.setCategory1(multi.getParameter("category1"));
    	        product.setCategory2(multi.getParameter("category2"));
    	        product.setType(multi.getParameter("type"));
    	        product.setDescription1(multi.getParameter("description1"));
    	        product.setDescription2(multi.getParameter("description2"));
    	        product.setSizeChart(multi.getFilesystemName("sizeChart")); // sizeImage -> sizeChart로 반영
    	        product.setSizeImage(multi.getFilesystemName("sizeChart")); // 혹시 둘 다 쓰고 있다면 둘 다 유지 가능

    	        String costStr = multi.getParameter("cost");
    	        if (costStr != null && !costStr.isEmpty()) {
    	            product.setCost(Integer.parseInt(costStr));
    	        }

    	        String priceStr = multi.getParameter("price");
    	        if (priceStr != null && !priceStr.isEmpty()) {
    	            product.setPrice(Integer.parseInt(priceStr));
    	        }

    	        String discountStr = multi.getParameter("discount");
    	        if (discountStr != null && !discountStr.isEmpty()) {
    	            product.setDiscount(Integer.parseInt(discountStr));
    	        }

    	        String subCategoryIdStr = multi.getParameter("subCategory");
    	        if (subCategoryIdStr != null && !subCategoryIdStr.isEmpty()) {
    	            product.setSubCategoryId(Integer.parseInt(subCategoryIdStr));
    	        }

    	        // 이미지 파일들
    	        product.setMainImage1(multi.getFilesystemName("mainImage1"));
    	        product.setMainImage2(multi.getFilesystemName("mainImage2"));
    	        product.setMainImage3(multi.getFilesystemName("mainImage3"));
    	        product.setMainImage4(multi.getFilesystemName("mainImage4"));

    	        product.setImage1(multi.getFilesystemName("image1"));
    	        product.setImage2(multi.getFilesystemName("image2"));
    	        product.setImage3(multi.getFilesystemName("image3"));
    	        product.setImage4(multi.getFilesystemName("image4"));
    	        product.setImage5(multi.getFilesystemName("image5"));
    	        product.setImage6(multi.getFilesystemName("image6"));
    	        product.setImage7(multi.getFilesystemName("image7"));
    	        product.setImage8(multi.getFilesystemName("image8"));
    	        product.setImage9(multi.getFilesystemName("image9"));
    	        product.setImage10(multi.getFilesystemName("image10"));

    	        // 🔹 DB 저장
    	        service.admin.ProductService service = new service.admin.ProductServiceImpl();
    	        service.insertProduct(product);
    	        System.out.println("✅ 상품이 DB에 성공적으로 저장되었습니다.");

    	        // 🔹 결과 전달
    	        request.setAttribute("product", product);
    	        request.getRequestDispatcher("/admin/adminProductDetail.jsp").forward(request, response);

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	        request.setAttribute("errorMessage", "상품 등록 중 오류가 발생했습니다.");
    	        request.getRequestDispatcher("/error.jsp").forward(request, response);
    	    }
    	}
       
    }

