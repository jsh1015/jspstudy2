package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

public class DeleteAction extends UserLoginAction{
	/*
	1. id�� �������� ���
		"�����ڴ� Ż�� �Ұ��� �մϴ�." �޼��� ���. list.me ������ �̵�
	2. Ż�� ����
		�Էµ� ��й�ȣ�� db�� ��й�ȣ�� ����
			- �����ڰ� �ƴϸ鼭 ��й�ȣ ����ġ
				"��й�ȣ�� Ʋ���ϴ�" �޼��� ���, deleteForm.me ������ �̵�
	3. ������ �α���, �Ǵº�й�ȣ ��ġ�ϴ� ��� db���� ȸ������ �����ϱ�
		���� ���� : �Ϲݻ���� : �α׾ƿ� �� , Ż��޼��� ���, loginForm.me�� ������ �̵�
				  ������	: Ż��޼��� ���, list.me ������ �̵�.
		���� ���� : �Ϲݻ���� : �������� �޼��� ���, info.me ������ �̵�.
				  ������	: �������� �޼��� ���, list.me ������ �̵�.
	*/
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String msg = null;
		String url = null;
		if(id.equals("admin")) { //1.
			msg = "�����ڴ� Ż���� �� �����ϴ�.";
			url = "list.me";
			return new ActionForward(false, "../alert.jsp");
		}
		
		Member m = new MemberDao().selectOne(id);
		int result = new MemberDao().delete(id);
		if(login.equals("admin") || m.getPass().equals(pass)) {
			if(result>0) {
				if(login.equals("admin")) {
					msg = id +"�� ����Ż�� ����";
					url = "list.me";
				}else {
					request.getSession().invalidate();
					msg = id + "���� Ż�� �Ϸ�Ǿ����ϴ�.";
					url = "loginForm.me";
				}
			}else {
				msg = "���� ����";
				if(login.equals("admin")) {
					url="list.me";
				}else {
					url="info.me?id="+id;
				}
			}
		}else {
			msg = "��й�ȣ�� Ʋ���ϴ�.";
			url = "deleteForm.jsp?id=" + id;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}
