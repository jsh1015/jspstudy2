package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("hello", "Hello World");
		return new ActionForward(false,"hello.jsp"); 
		//view에서는 나한테 전달된 값만 지정된 위치에 출력하겠다.
		//어떠한 알고리즘을 사용하지 않고 미리 지정한 값을 여기서는 출력만 하겠다. 
	}
}
