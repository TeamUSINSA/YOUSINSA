package service.user;

import java.util.List;

import dao.user.NoticeDAO;
import dao.user.NoticeDAOImpl;
import dto.user.Notice;

public class NoticeServiceImpl implements NoticeService {

    private  NoticeDAO noticeDAO = new NoticeDAOImpl();

    /** 전체 공지 목록 조회 */
    @Override
    public List<Notice> getAllNotices() throws Exception{
        return noticeDAO.selectAllNotices();
    }

    /** 단일 공지 조회 */
    @Override
    public Notice getNoticeById(int noticeId) throws Exception{
        return noticeDAO.selectNoticeById(noticeId);
    }

    /** 새 공지 등록 */
    @Override
    public int createNotice(Notice notice) throws Exception{
        return noticeDAO.insertNotice(notice);
    }

    /** 기존 공지 수정 */
    @Override
    public int updateNotice(Notice notice) throws Exception{
        return noticeDAO.updateNotice(notice);
    }

    /** 공지 삭제 */
    @Override
    public int deleteNotice(int noticeId) throws Exception{
        return noticeDAO.deleteNotice(noticeId);
    }
}
