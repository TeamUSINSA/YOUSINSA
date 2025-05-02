// src/main/java/service/order/impl/CouponServiceImpl.java
package service.order;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.order.CouponDAO;
import dao.order.CouponDAOImpl;
import dto.order.Coupon;
import dto.user.UserCoupon;

public class CouponServiceImpl implements CouponService {

    private CouponDAO couponDAO = new CouponDAOImpl();

    @Override
    public List<Coupon> selectValidCoupons() throws Exception {
        return couponDAO.selectValidCoupons();
    }

    @Override
    public List<Coupon> selectValidCouponsByUser(String userId) throws Exception {
        return couponDAO.selectValidCouponsByUser(userId);
    }
    
    @Override
    public void markCouponUsed(String userId, int couponId) throws Exception {
        UserCoupon uc = new UserCoupon();
        uc.setUserId(userId);
        uc.setCouponId(couponId);
        uc.setUsed(true);
        couponDAO.updateUserCouponUsed(uc);
    }
    
    @Override
    public Coupon getCouponById(int couponId) throws Exception {
        return couponDAO.selectCouponById(couponId);
    }

    @Override
    public void downloadCoupon(int couponId, String userId,
                               LocalDate issueDate, LocalDate expireDate) throws Exception {
        Map<String,Object> params = new HashMap<>();
        params.put("couponId",   couponId);
        params.put("userId",     userId);
        params.put("issueDate",  issueDate);
        params.put("expireDate", expireDate);
        couponDAO.insertUserCoupon(params);
    }
    
    @Override
    public void expireUserCoupons(String userId) throws Exception {
        couponDAO.expireCouponsByUser(userId);
    }
}
