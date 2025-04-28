package dao.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.user.Notice;
import utils.MybatisSqlSessionFactory;

public class NoticeDAOImpl implements NoticeDAO {
    private final SqlSessionFactory sqlSessionFactory;

    public NoticeDAOImpl() {
        this.sqlSessionFactory = MybatisSqlSessionFactory.getSqlSessionFactory();
    }

    @Override
    public List<Notice> selectAllNotices() throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.selectList("mapper.notice.selectAllNotices");
        }
    }

    @Override
    public Notice selectNoticeById(int noticeId) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.selectOne("mapper.notice.selectNoticeById", noticeId);
        }
    }

    @Override
    public int insertNotice(Notice notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.insert("mapper.notice.insertNotice", notice);
        }
    }

    @Override
    public int updateNotice(Notice notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.update("mapper.notice.updateNotice", notice);
        }
    }

    @Override
    public int deleteNotice(int noticeId) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession(true)) {
            return session.delete("mapper.notice.deleteNotice", noticeId);
        }
    }
}
