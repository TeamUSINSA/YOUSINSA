package dao.user;

import java.util.List;

import dto.user.Notice;

public interface NoticeDAO {

	List<Notice> selectAllNotices() throws Exception;

	Notice selectNoticeById(int noticeId) throws Exception;

	int insertNotice(Notice notice) throws Exception;

	int updateNotice(Notice notice) throws Exception;

	int deleteNotice(int noticeId) throws Exception;

}
