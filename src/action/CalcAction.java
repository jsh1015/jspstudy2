package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CalcAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			int num1 = Integer.parseInt(request.getParameter("num1"));
			String op = request.getParameter("op");
			int num2 = Integer.parseInt(request.getParameter("num2"));
//			switch(op) { //틀린거 수정필요
//			case "+": request.setAttribute("result", num1+num2);
//			case "-": request.setAttribute("result", num1-num2);
//			case "*": request.setAttribute("result", num1*num2);
//			case "/": request.setAttribute("result", (double)num1/num2);
//			}
			if(op.equals("+")) {
				request.setAttribute("result", num1+num2);
			}else if(op.equals("-")) {
				request.setAttribute("result", num1-num2);
			}else if(op.equals("*")) {
				request.setAttribute("result", num1*num2);
			}else {
				request.setAttribute("result", (double)num1/num2);
			}
		}catch(NumberFormatException e) {
			request.setAttribute("result", 0);
		}
		return new ActionForward(false,"calc.jsp");
	}

}
