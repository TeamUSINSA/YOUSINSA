// src/main/java/service/order/impl/CouponServiceImpl.java
package service.order;

import java.util.List;

import dao.order.CouponDAO;
import dao.order.CouponDAOImpl;
import dto.order.Coupon;

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
    public void downloadCoupon(int couponId, String userId) throws Exception {
        couponDAO.insertUserCoupon(couponId, userId);
    }
}
