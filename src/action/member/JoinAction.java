package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 * 1. �Ķ���� ������ Member ��ü�� ����(useBean��������)
 * 2. ������ Member��ü�� db�� �߰�
 * 		- ���� : ȸ������ �Ϸ� �޼��� ���, loginForm.me�� �̵�
 * 		- ���� : ȸ������ ���� �޼��� ���, joinForm.me�� �̵�
 * 
 * 	**request.setCharacterEncoding�� �� �ʿ䰡 ���� Controller���� �̹� �߱� ������.**
 */
public class JoinAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setTel(request.getParameter("tel"));
		mem.setEmail(request.getParameter("email"));
		mem.setPicture(request.getParameter("picture"));
		MemberDao dao = new MemberDao();
		String msg = "ȸ������ ����";
		String url = "joinForm.jsp";
		if(dao.insert(mem) > 0) {
			msg = "ȸ������ ����";
			url = "loginForm.me";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}