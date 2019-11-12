package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;

public class LogoutAction extends UserLoginAction{ 
	//UserLoginAction���� �̹� �α��ξ��� ������� �ɷ����Ƿ� ���� �ʿ���� �α׾ƿ��Ȱ͸� �ϸ� ��.

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		request.setAttribute("msg", login + "���� �α׾ƿ� �Ǿ����ϴ�."); //login�� UserLoginAction������
		request.setAttribute("url", "loginForm.me");
		return new ActionForward(false, "../alert.jsp");
	}
}
