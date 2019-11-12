package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 *	���
 *	1. ��� �Ķ���� Member ��ü�� ����
 *	2. �Էµ� ��й�ȣ�� db�� ����� ��й�ȣ�� ���� ������
 *		"��й�ȣ�� Ʋ�Ƚ��ϴ�." �޼��� ����� , updateForm.me�������� �̵�
 *	3. 1���� ������ db�� ����
 *		 int MemberDao.update(Member)
 *		����� 0���� ũ�� �������� �޼��� ���. info.me ������ �̵�
 *			0���ϸ� ���� ���� �޼��� ���. main.me������ �̵�
*/
public class UpdateAction extends UserLoginAction{

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setTel(request.getParameter("tel"));
		mem.setPicture(request.getParameter("picture"));
		mem.setEmail(request.getParameter("email"));
		Member m = new MemberDao().selectOne(request.getParameter("id"));
		String msg = null;
		String url = null;
		if(!m.getPass().equals(request.getParameter("pass"))) {
			msg = "��й�ȣ�� Ʋ�Ƚ��ϴ�.";
			url = "updateForm.me?id=" + request.getParameter("id");
		}else {
			int result = new MemberDao().update(mem);
			if(result >0 ) {
				msg = "�����Ϸ�";
				url = "info.me?id=" + request.getParameter("id");
			}else{
				msg = "������ �����߻�";
				url = "main.me";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}
