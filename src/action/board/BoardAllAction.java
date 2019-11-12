package action.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.BoardDao;

public class BoardAllAction {
	private BoardDao dao = new BoardDao();
	public ActionForward hello(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("hello", "Hello World");
		return new ActionForward();
	}
	/*
	 * 1. multipart/form-data Ÿ���� �����̹Ƿ� MultiparteRequest ��ü ����
	 * 2. �Ķ���� ���� model.Board ��ü ����
	 * 3. �Խù���ȣ num ���� ��ϵ� num�� �ִ밪�� ��ȸ. �ִ밪 +1 ��ϵ� �Խù��� ��ȣ
	 * 		db���� maxnum�� ���ؼ� +1 ������ num �����ϱ�
	 * 4. board ������ db�� ����ϱ�
	 * 		��ϼ��� : �޼��� ���. list.do ������ �̵�
	 * 		��Ͻ��� : �޼��� ���. writeForm.me������ �̵�
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		String msg = "�Խù� ��� ����";
		String url = "writeForm.jsp";
		String path = request.getServletContext().getRealPath("/")+"model2/board/file/";
		try {
			File f = new File(path);
			if(!f.exists()) f.mkdirs();
			MultipartRequest multi = new MultipartRequest(request,path,10*1024*1024,"euc-kr"); //1.
			Board b = new Board();
			b.setName(multi.getParameter("name"));
			b.setPass(multi.getParameter("pass"));
			b.setSubject(multi.getParameter("subject"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));	//2.
			
			int num = dao.maxnum();	//�ִ밪 ������
			b.setNum(++num);
			b.setGrp(num);
			if(dao.insert(b)) {
				msg = "�Խù� ��� ����";
				url = "list.do";
			}									//3. 4.
		}catch(IOException e) {
			throw new ServletException(e);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	/*
	 * 	1. ���������� 10���� �Խù��� ����ϱ�.
			pageNum �Ķ���Ͱ��� ���� 1-1������ =>���°��� 1�� �����ϱ�.
		2. �ֱ� ��ϵ� �Խù��� ���� ���� ��ġ��.(List����)
		3. ȭ�鿡 �ʿ��� ������ �Ӽ����� ���. =>��� ���� 
	*/
	public ActionForward list(HttpServletRequest request, HttpServletResponse response){
		int limit = 10; //�ѰǴ� ������ 10
		int pageNum = 1;
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));	//1.
		}catch(NumberFormatException e) {}
		
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if(column != null && column.trim().equals("")) column=null;
		if(find != null && find.trim().equals("")) find=null;
		if(column == null || find == null) {
			column = null;
			find = null;
		}
		int boardcnt = dao.boardCount(column,find); //��ϵ� �ѰԽù��� �Ǽ�
		List<Board> list = dao.list(pageNum, limit, column, find);
		
		int maxpage = (int)((double)boardcnt/limit + 0.95);
		int startpage = ((int)(pageNum/10.0+0.9)-1)*10+1;
		int endpage = startpage + 9;
		if(endpage >maxpage)endpage = maxpage;
		int boardnum = boardcnt - (pageNum - 1) *limit;		//2.
		request.setAttribute("boardcnt", boardcnt);
		request.setAttribute("list", list);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("pageNum", pageNum);		//3.
		return new ActionForward();
	}
	
	/*
	 * 	1. num �Ķ���� ������ ������ ����. (�Խù���ȣ)
		2. num�� �̿��Ͽ� db���� �ش� �Խù� ������ ��ȸ
			Board b = new BoardDao.selectOne(num)
		3. ��ȸ�� ������Ű�� 
			void BoardDao.readcntadd(num)
		4. 2���� ��ȸ�� �Խù��� ȭ�鿡 ���
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response){
		int num = Integer.parseInt(request.getParameter("num")); //1
		Board b = new BoardDao().selectOne(num);//2
		
		//jspstudy2/medel2/info.do : �󼼺������� 
		if(request.getRequestURI().contains("info.do")) { 
			//���࿡ URI�� info.do�̸� �׶� readcntadd�� ��ȸ�� ����
			new BoardDao().readcntadd(num);	//3
		}
		request.setAttribute("b", b);	//4
		return new ActionForward();
	}
	
	/*
	 * 1. �Ķ���� ���� Board ��ü�� �����ϱ�
			�������� : num,grp,grplevel,grpstep
			������� : name,pass,subject,content = ���������
		2. ���� grp ���� ����ϴ� �Խù����� grpstep ���� 1 �����ϱ�  = ��� �ؿ� ���� �ְ�
			void BoardDao.grpStepAdd(grp, grpstep) �����׷��̸鼭 ���ۺ��� ���ڰ� ū�ֵ� +1
		3. Board ��ü�� db�� insert �ϱ�
		 	num : maxnum + 1
		 	grp : ���۰� ����
		 	grplevel : ���� + 1
		 	grpstep : ���� + 1
		 	num grp grplevel grpstep
		 	15	  15     0       0
	 */
	public ActionForward reply(HttpServletRequest request, HttpServletResponse response){
		BoardDao dao = new BoardDao();
		Board b = new Board();
		b.setNum(Integer.parseInt(request.getParameter("num")));
		b.setGrp(Integer.parseInt(request.getParameter("grp")));
		b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
		b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
		b.setName(request.getParameter("name"));
		b.setContent(request.getParameter("content"));
		b.setPass(request.getParameter("pass")); 
		b.setSubject(request.getParameter("subject"));
		dao.grpStepAdd(b.getGrp(), b.getGrpstep());
		int grplevel = b.getGrplevel(); //���� ����
		int grpstep = b.getGrpstep();
		int num = dao.maxnum();
		String msg = "�亯��Ͻ� �����߻�";
		String url = "replyForm.do?num="+b.getNum();
		b.setNum(++num);
		b.setGrplevel(grplevel+1);
		b.setGrpstep(grpstep+1);
		if(dao.insert(b)){
			msg="�亯��ϿϷ�";
			url="list.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
	
	/*
	 * 	1. �Ķ���� �������� Board ��ü ����.
		2. ��й�ȣ ����
			��й�ȣ ��ġ �ϴ� ��� ����
				�Ķ������ �������� �ش� �Խù��� ������ �����ϱ�
				÷�������� ������ ���� ��� file2 �Ķ������ ������ �ٽ� �����ϱ� 
			��й�ȣ ����ġ
				��й�ȣ ���� �޼��� ����ϰ�, updateForm.jsp�� ������ �̵�
		3. �������� : �������� �޼��� ��� �� info.jsp ������ �̵�
	      	�������� : �������� �޼��� ��� �� updateForm.jsp ������ �̵�
	 */
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String path = request.getServletContext().getRealPath("/")+"model2/board/file/";
		MultipartRequest multi = new MultipartRequest(request,path,10*1024*1024,"euc-kr"); //1.
		Board b = new Board();
		b.setNum(Integer.parseInt(multi.getParameter("num")));
		b.setPass(multi.getParameter("pass"));
		b.setName(multi.getParameter("name"));
		b.setSubject(multi.getParameter("subject"));
		b.setContent(multi.getParameter("content"));
		b.setFile1(multi.getFilesystemName("file1"));
		if(b.getFile1()==null || b.getFile1().equals("")){
			b.setFile1(multi.getParameter("file2"));
		}//������ ���� ���� �ʾ������
		
		String pass = request.getParameter("pass"); //�Է��� ��й�ȣ
		Board board = new BoardDao().selectOne(b.getNum());
		String msg = "��й�ȣ ����ġ";
		String url = "updateForm.do?num=" + b.getNum();
		if(b.getPass().equals(board.getPass())) {
			if(new BoardDao().update(b)) {
				msg = "��������";
				url = "info.do?num="+b.getNum();
			}else {
				msg = "��������";
				url = "updateForm.do?num="+b.getNum();
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
	
	
	/*
	 * 	1. num, pass �Ķ���͸� ������ ����
		2. �Էµ� ��й�ȣ�� db ��й�ȣ ����
			Ʋ����� : ��й�ȣ ���� �޼��� ���, deleteForm.jsp ������ �̵�
		3. ��й�ȣ�� �´� ��� : �Խù� ����.
			���� ���� : ���� ���� �޼��� ���, list.jsp ������ �̵�
			���� ���� : ���� ���� �޼��� ���, info.jsp ������ �̵�
	 */
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response){
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");
		Board db = new BoardDao().selectOne(num);
		String msg = "��й�ȣ ����";
		String url = "deleteForm.do?num="+num;
		if(db==null) {
			msg = "���� �Խñ��Դϴ�.";
			url = "list.do";
		}else {
			if(pass.equals(db.getPass())) {
				boolean result = new BoardDao().delete(num);
				if(result) {
					msg = "��������";
					url = "list.do";
				}else {
					msg = "��������";
					url = "info.do?num="+num;
				}
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String path = request.getServletContext().getRealPath("/")+"model2/board/imgfile/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload"); //upload�� �����̸�
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditiorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
}