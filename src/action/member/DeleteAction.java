package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

public class DeleteAction extends UserLoginAction{
	/*
	1. id가 관리자인 경우
		"관리자는 탈퇴가 불가능 합니다." 메세지 출력. list.me 페이지 이동
	2. 탈퇴 조건
		입력된 비밀번호와 db의 비밀번호를 검증
			- 관리자가 아니면서 비밀번호 불일치
				"비밀번호가 틀립니다" 메세지 출력, deleteForm.me 페이지 이동
	3. 관리자 로그인, 또는비밀번호 일치하는 경우 db에서 회원정보 삭제하기
		삭제 성공 : 일반사용자 : 로그아웃 후 , 탈퇴메세지 출력, loginForm.me로 페이지 이동
				  관리자	: 탈퇴메세지 출력, list.me 페이지 이동.
		삭제 실패 : 일반사용자 : 삭제실패 메세지 출력, info.me 페이지 이동.
				  관리자	: 삭제실패 메세지 출력, list.me 페이지 이동.
	*/
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String msg = null;
		String url = null;
		if(id.equals("admin")) { //1.
			msg = "관리자는 탈퇴할 수 없습니다.";
			url = "list.me";
			return new ActionForward(false, "../alert.jsp");
		}
		
		Member m = new MemberDao().selectOne(id);
		int result = new MemberDao().delete(id);
		if(login.equals("admin") || m.getPass().equals(pass)) {
			if(result>0) {
				if(login.equals("admin")) {
					msg = id +"님 강제탈퇴 성공";
					url = "list.me";
				}else {
					request.getSession().invalidate();
					msg = id + "님의 탈퇴가 완료되었습니다.";
					url = "loginForm.me";
				}
			}else {
				msg = "삭제 실패";
				if(login.equals("admin")) {
					url="list.me";
				}else {
					url="info.me?id="+id;
				}
			}
		}else {
			msg = "비밀번호가 틀립니다.";
			url = "deleteForm.jsp?id=" + id;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}
