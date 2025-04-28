package service.user;

import java.util.List;

import dto.user.Notice;

public interface NoticeService {

	/** 전체 공지 목록 조회 */
	List<Notice> getAllNotices() throws Exception;

	/** 단일 공지 조회 */
	Notice getNoticeById(int noticeId) throws Exception;

	/** 새 공지 등록 */
	int createNotice(Notice notice) throws Exception;

	/** 기존 공지 수정 */
	int updateNotice(Notice notice) throws Exception;

	/** 공지 삭제 */
	int deleteNotice(int noticeId) throws Exception;

}
