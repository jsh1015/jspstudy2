package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import action.board.BoardAllAction;

@WebServlet(urlPatterns = {"*.do"}, //.do�������� ���� ȣ���ض�
initParams= {@WebInitParam(name="properties",value="method.properties")})

public class ControllerMethodServlet extends HttpServlet{ //Ŭ�������·� �����ִٰ� ��üȭ �Ǿ����������� ��Ĺ�� ��üȭ�� ��Ŵ
	private static final long serialVersionUID = 1L;
	private Properties pr = new Properties();
	private BoardAllAction action = new BoardAllAction(); 
	private Class[] paramType = new Class[] {HttpServletRequest.class,HttpServletResponse.class};
	
	@Override 
	//init : ������ ��üȭ �� ���� �ٷ� ȣ��Ǵ� �޼���(�ѹ���)
	//config ��ü : �Ķ���� ����
	//				properties = method.properties
	public void init(ServletConfig config) throws ServletException{ //��üȭ�Ǹ� init�޼��尡 �����
//		props : method.properties
		String props = config.getInitParameter("properties");
		FileInputStream f = null;
		try {
//			f : WEB-INF/method.properties ���� �б� ���� �Է� ��Ʈ��
			f = new FileInputStream(config.getServletContext().getRealPath("/")+"WEB-INF/"+props);
//			key = /model2/hello.do
//			value = hello
			pr.load(f); // Map��ü�� ������ü Properties pr
			f.close();
		}catch(IOException e) {e.printStackTrace();}
	}
//	Ŭ���̾�Ʈ  GET ��� ��û�� ȣ��Ǵ� �޼���
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("euc-kr");
		Object[] paramObjs = new Object[] {request,response};
		ActionForward forward = null;
		String command = null;
		try {
//			System.out.println(request.getRequestURI());	/jspstudy2/*.do
//			System.out.println(request.getContextPath());	/jspstudy2
//			������Ʈ�� ������ ��û url : /model2/hello.do
			command = request.getRequestURI().substring(request.getContextPath().length());
//			methodName : hello
			String methodName = pr.getProperty(command);
//			method : �޼��� ��ü ����
//			BoardAllAction Ŭ���� �� �޼����� �̸��� methodName �̰�
//			�Ű������� paramType�� �޼��带 ��ü�� ����
			Method method = BoardAllAction.class.getMethod(methodName, paramType);
//			invoke : �޼��带 ȣ���ϴ� ���			BoardAllAction
//					 action.hello(request,response) ȣ�� //���ϰ��� ActionForward
			forward = (ActionForward)method.invoke(action, paramObjs);
		}catch(NullPointerException e){
			forward = new ActionForward();
			e.printStackTrace();
		}catch(Exception e) {
			throw new ServletException(e);
		}
		//View�κ�
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getView());
			}else {
				if(forward.getView() == null) {
					forward.setView(command.replace(".do", ".jsp")); //jsp�� �ٷν����ϰ� ��
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		}else response.sendRedirect("nopage.jsp");
	}
	
//	Ŭ���̾�Ʈ  POST ��� ��û�� ȣ��Ǵ� �޼���
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
