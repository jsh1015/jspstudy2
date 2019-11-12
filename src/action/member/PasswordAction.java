package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;

/*
 * 1. �α׾ƿ������� ���, �α����ϼ��� �޼��� ���
 * 		�ٸ� ������� ��й�ȣ ���� �Ұ�
 * 		opener �������� loginForm.me �������� �̵�
 * 		���� ������ �ݱ�
 * 2. pass, rpass1 �Ķ���Ͱ� ����
 * 3. pass ��й�ȣ�� db�� ����� ��й�ȣ�� Ʋ���� 
 * 		��й�ȣ ���� �޼��� ���. passwordForm.me ������ �̵�
 * 4. pass ��й�ȣ�� db�� ����� ��й�ȣ�� ������ ��й�ȣ ����.
 * 		opener �������� info.me ������ �̵�.
 * 		���������� �ݱ�
 */
public class PasswordAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String login = (String)request.getSession().getAttribute("login");
		boolean op = false;
		boolean c = false;
		String msg = "��й�ȣ �����Դϴ�. Ȯ���ϼ���";
		String url = "passwordForm.me";
		if(login == null || login.trim().equals("")) { //�α׾ƿ�����
			msg = "�α��� �ϼ���";
			url = "loginForm.me";
			op = true;
			c = true;
		}else { //�α��� ����
			String pass = request.getParameter("pass");
			Member mem = new MemberDao().selectOne(login); //�ٸ������ ���� ���ϰ� �ϱ�����
			if(pass.equals(mem.getPass())) {
				c = true;
				String chpass = request.getParameter("rpass1");
				int result = new MemberDao().passupdate(login, chpass);
				if(result>0) {
					msg="��й�ȣ ����Ϸ�, ��α��� �ϼ���";
					url="loginForm.jsp";
					op = true;
				}else {
					msg = "��й�ȣ �������";
				}
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("c", c);
		request.setAttribute("op", op);
		return new ActionForward();
	}

}
