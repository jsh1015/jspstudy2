package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.Action;
import action.ActionForward;

@WebServlet(urlPatterns= {"*.me"},
		initParams = {@WebInitParam(name="properties", value = "action.properties")})
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String,Action> commandMap = new HashMap<String,Action>();
    public ControllerServlet() {
        super();
    }
    @Override
    public void init(ServletConfig config) throws ServletException{
    	String props = config.getInitParameter("properties");
    	Properties pr = new Properties();
    	FileInputStream f = null;
    	try { 
    		f = new FileInputStream(config.getServletContext().getRealPath("/")+"WEB-INF/"+props);
    		pr.load(f);
    		// /model2/ action.AddAction�� ������
    	}catch(IOException e) {
    		throw new ServletException(e);
    	}finally {
    		try {
    			if(f!=null) f.close();
    		}catch(IOException e) {}
    	}
    	for(Object k : pr.keySet()) {
    		String command =(String)k;
    		String className = pr.getProperty(command);
    		try {
    			Class commandClass = Class.forName(className.trim()); 
    			//commandObj : action.HelloAction�Ǵ� AddAction
    			Object commandObj = commandClass.newInstance(); //AddAction�� ��üȭ
    			commandMap.put(command,(Action)commandObj); //commandMap��ü�� ���
    		}catch(Exception e) {
    			throw new ServletException(e);
    		}
    	}
    }
    /*request, response 
     * command�κ��� action�� ������*/
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("euc-kr"); 
		Action action = null;
		ActionForward forward = null;
		String command = null;
		try {
			//command : /model2/hello.me �� �����ϴ°��� (key�ξ��ϳ���)
			command =request.getRequestURI().substring(request.getContextPath().length());
			//action : Action �������̽��� ���� ��ü
			//			action.HelloAction ��ü
			action = commandMap.get(command);
			forward = action.execute(request, response);//AddAction���� �޾ƿ�
			//execute�� ������ �׷��� forward������
			/* redirecte:false view:hello.jsp/addform.jsp
			 * execute(request,response)	(response����)
			 * -->key:hello value:hello world  (request����)*/
		}catch(NullPointerException e) {
			e.printStackTrace();
	//		forward = new ActionForward(false,null);
			forward = new ActionForward();
		}catch(Exception e) {
			throw new ServletException(e);
		}
		
		if(forward != null) {
			if(forward.isRedirect()) { //redirect:false
				response.sendRedirect(forward.getView());
			}else {
				if(forward.getView()==null) { //�䰡������ �׳� ���� �ڱ��̸����� ����
					forward.setView(command.replace(".me", ".jsp"));
				}
				//forward.getView() : actionŬ�������� ���� view�̸�
				//					  addForm.jsp
				//forward ����� ����											addForm.jsp
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
				//			�Ķ����3��, �Ӽ�:result
			}
		}else response.sendRedirect("nopage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
