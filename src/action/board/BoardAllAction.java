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
	 * 1. multipart/form-data 타입의 전송이므로 MultiparteRequest 객체 생성
	 * 2. 파라미터 값을 model.Board 객체 저장
	 * 3. 게시물번호 num 현재 등록된 num의 최대값을 조회. 최대값 +1 등록된 게시물의 번호
	 * 		db에서 maxnum을 구해서 +1 값으로 num 설정하기
	 * 4. board 내용을 db에 등록하기
	 * 		등록성공 : 메세지 출력. list.do 페이지 이동
	 * 		등록실패 : 메세지 출력. writeForm.me페이지 이동
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		String msg = "게시물 등록 실패";
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
			
			int num = dao.maxnum();	//최대값 가져옴
			b.setNum(++num);
			b.setGrp(num);
			if(dao.insert(b)) {
				msg = "게시물 등록 성공";
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
	 * 	1. 한페이지당 10건의 게시물을 출력하기.
			pageNum 파라미터값을 저장 1-1페이지 =>없는경우는 1로 설정하기.
		2. 최근 등록된 게시물을 가장 위에 배치함.(List형태)
		3. 화면에 필요한 정보를 속성으로 등록. =>뷰로 전송 
	*/
	public ActionForward list(HttpServletRequest request, HttpServletResponse response){
		int limit = 10; //한건당 페이지 10
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
		int boardcnt = dao.boardCount(column,find); //등록된 총게시물의 건수
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
	 * 	1. num 파라미터 정보를 변수에 저장. (게시물번호)
		2. num을 이용하여 db에서 해당 게시물 정보를 조회
			Board b = new BoardDao.selectOne(num)
		3. 조회수 증가시키기 
			void BoardDao.readcntadd(num)
		4. 2번의 조회된 게시물을 화면에 출력
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response){
		int num = Integer.parseInt(request.getParameter("num")); //1
		Board b = new BoardDao().selectOne(num);//2
		
		//jspstudy2/medel2/info.do : 상세보기인지 
		if(request.getRequestURI().contains("info.do")) { 
			//만약에 URI가 info.do이면 그때 readcntadd로 조회수 증가
			new BoardDao().readcntadd(num);	//3
		}
		request.setAttribute("b", b);	//4
		return new ActionForward();
	}
	
	/*
	 * 1. 파라미터 값을 Board 객체에 저장하기
			원글정보 : num,grp,grplevel,grpstep
			답글정보 : name,pass,subject,content = 등록한정보
		2. 같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기  = 답글 밑에 들어갈수 있게
			void BoardDao.grpStepAdd(grp, grpstep) 같은그룹이면서 원글보다 숫자가 큰애들 +1
		3. Board 객체를 db에 insert 하기
		 	num : maxnum + 1
		 	grp : 원글과 동일
		 	grplevel : 원글 + 1
		 	grpstep : 원글 + 1
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
		int grplevel = b.getGrplevel(); //원글 정보
		int grpstep = b.getGrpstep();
		int num = dao.maxnum();
		String msg = "답변등록시 오류발생";
		String url = "replyForm.do?num="+b.getNum();
		b.setNum(++num);
		b.setGrplevel(grplevel+1);
		b.setGrpstep(grpstep+1);
		if(dao.insert(b)){
			msg="답변등록완료";
			url="list.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
	
	/*
	 * 	1. 파라미터 정보들을 Board 객체 저장.
		2. 비밀번호 검증
			비밀번호 일치 하는 경우 수정
				파라미터의 내용으로 해당 게시물의 내용을 수정하기
				첨부파일의 변경이 없는 경우 file2 파라미터의 내용을 다시 저장하기 
			비밀번호 불일치
				비밀번호 오류 메세지 출력하고, updateForm.jsp로 페이지 이동
		3. 수정성공 : 수정성공 메세지 출력 후 info.jsp 페이지 이동
	      	수정실패 : 수정실패 메세지 출력 후 updateForm.jsp 페이지 이동
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
		}//파일이 변경 되지 않았을경우
		
		String pass = request.getParameter("pass"); //입력한 비밀번호
		Board board = new BoardDao().selectOne(b.getNum());
		String msg = "비밀번호 불일치";
		String url = "updateForm.do?num=" + b.getNum();
		if(b.getPass().equals(board.getPass())) {
			if(new BoardDao().update(b)) {
				msg = "수정성공";
				url = "info.do?num="+b.getNum();
			}else {
				msg = "수정실패";
				url = "updateForm.do?num="+b.getNum();
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false,"../alert.jsp");
	}
	
	
	/*
	 * 	1. num, pass 파라미터를 변수에 저장
		2. 입력된 비밀번호와 db 비밀번호 검증
			틀림경우 : 비밀번호 오류 메세지 출력, deleteForm.jsp 페이지 이동
		3. 비밀번호가 맞는 경우 : 게시물 삭제.
			삭제 성공 : 삭제 성공 메세지 출력, list.jsp 페이지 이동
			삭제 실패 : 삭제 실패 메세지 출력, info.jsp 페이지 이동
	 */
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response){
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");
		Board db = new BoardDao().selectOne(num);
		String msg = "비밀번호 오류";
		String url = "deleteForm.do?num="+num;
		if(db==null) {
			msg = "없는 게시글입니다.";
			url = "list.do";
		}else {
			if(pass.equals(db.getPass())) {
				boolean result = new BoardDao().delete(num);
				if(result) {
					msg = "삭제성공";
					url = "list.do";
				}else {
					msg = "삭제실패";
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
		String fileName = multi.getFilesystemName("upload"); //upload된 파일이름
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditiorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
}