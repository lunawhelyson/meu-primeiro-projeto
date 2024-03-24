package servlets;

import java.io.IOException;

import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

// O chamado Controller são as servlets ou ServletLoginController
// Mapeamento da url que vem da tela
@WebServlet(urlPatterns = {"/principal/ServletLogin"})
public class ServletLogin extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private DAOLoginRepository daoLoginRepository = new DAOLoginRepository();
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	
    public ServletLogin() {

    }

    // Recebe os dados pela url em parametros
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		
		if (acao != null && !acao.isEmpty()&& acao.equalsIgnoreCase("logout")) {
			request.getSession().invalidate(); // Invalida a sessão
			RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
			redirecionar.forward(request, response);
		}else {
			doPost(request, response);
		}
		
	}

	// Recebe os dados enviados por um formulario
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Pegando dos parametros
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String url = request.getParameter("url");
		
		try {
		
				if (login != null && !login.isEmpty() && senha  != null && !senha.isEmpty()) {
					
					//Passando para um objeto
					ModelLogin modelLogin = new ModelLogin();
					modelLogin.setLogin(login);
					modelLogin.setSenha(senha);
				
					if (daoLoginRepository.ValidarAutenticacao(modelLogin)) { // Simulando login
						
						modelLogin = daoUsuarioRepository.consultaUsuarioLogado(login);
						
						request.getSession().setAttribute("usuario", modelLogin.getLogin());
						request.getSession().setAttribute("perfil", modelLogin.getPerfil());
						
						request.getSession().setAttribute("imagemUser", modelLogin.getFotouser());
						
						if (url == null || url.equals("null")) {
							url = "principal/principal.jsp";
						}
						
						RequestDispatcher redirecionar = request.getRequestDispatcher(url);
						redirecionar.forward(request, response);
						
					}else {
						RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
						request.setAttribute("msg", "Informe o login e senha corretamente!");
						redirecionar.forward(request, response);
					}
					
				}else {
					RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
					request.setAttribute("msg", "Informe o login e senha corretamente!");
					redirecionar.forward(request, response); // Redirecionamento pro index que a pagina principal
				}
			
		}catch (Exception e) {
			e.printStackTrace();
				RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
				request.setAttribute("msg", e.getMessage());
				redirecionar.forward(request, response);
		}
		
	}

}
