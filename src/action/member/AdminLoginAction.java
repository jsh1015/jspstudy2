package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
/*
 * 1. �α׾ƿ� ���� : �α����� �ʿ��մϴ�. �޼��� ���
 * 					loginForm.me ������ �̵�
 * 2. �α��� ����
 * 		�Ϲݻ���� : �����ڸ� ������ �ŷ��Դϴ�. �޼������
 * 					main.me�� ������ �̵�
 */
public abstract class AdminLoginAction implements Action {
	protected String login;	//�α��� ����
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		if(login == null || login.equals("")) {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�.");
			request.setAttribute("url", "loginForm.jsp");
			return new ActionForward(false, "../alert.jsp");
		}else if(!login.equals("admin")) {
				request.setAttribute("msg", "�����ڸ� ������ �ŷ��Դϴ�.");
				request.setAttribute("url", "main.jsp");
				return new ActionForward(false, "../alert.jsp");
		}
		return adminExecute(request,response); //�����ϴºκ�
	}
	protected abstract ActionForward adminExecute(HttpServletRequest request, HttpServletResponse response);
}
