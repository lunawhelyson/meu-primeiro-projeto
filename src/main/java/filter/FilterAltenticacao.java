package filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import connection.SingleConnectionBanco;
import dao.DaoVersionadorBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


// Intercepta todas as requisiçoes que vierem do projeto ou mapeamento
@WebFilter(urlPatterns = {"/principal/*"})
public class FilterAltenticacao extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;
	
	private static Connection connection;

	public FilterAltenticacao() {
       
    }

	//Encerra os processos quando o servidor é parado
	//Mataria os processos de conexão com banco
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Intercepta todas as requisições e dar as respostas no sistema 
	// Tudo que fizer no sistema vai passar por aqui
	// Valição de autenticação
	// Dar commit e rolback de transaçõe no banco
	// Validar e fazer redirecionamento de paginas 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		try {
			
			HttpServletRequest req = (HttpServletRequest) request; // Conversão
			HttpSession session = req.getSession();
			
			String usuarioLogado = (String) session.getAttribute("usuario"); // Busca pelo usuário logado
			
			String UrlParaAutenticar = req.getServletPath(); // Url que está sendo acessada
			
			
			// Validar se está logado, senão redireciona para tela de login
			if (usuarioLogado == null && !UrlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) { // Não está logado
				
				RequestDispatcher redireciona = request.getRequestDispatcher("/index.jsp?url=" + UrlParaAutenticar);
				request.setAttribute("msg", "Por favor realize o login");
				redireciona.forward(request, response); // Comando de redirecionamento 
				return; // Para a execução e redireciona para o login
			
			}else {
				chain.doFilter(request, response);
			}
			
			connection.commit(); // Deu tudo certo então comita as alterações no banco de dados
		
		}catch (Exception e) {
			e.printStackTrace();
			
				RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
				request.setAttribute("msg", e.getMessage());
				redirecionar.forward(request, response);
			
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
	}

	// Inicia os processos ou recursos quando o servidor sobe os projetos
	//Iniciar a conexão com o banco
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnectionBanco.getConnection();
		
		DaoVersionadorBanco daoVersionadorBanco = new DaoVersionadorBanco();
		
		String caminhoPastaSql = fConfig.getServletContext().getRealPath("versionadorbancosql") + File.separator;
	
		File[] filesSql = new File(caminhoPastaSql).listFiles();
		
		try {
		
			
			for (File file : filesSql) {
				
				boolean arquivoJaRodado = daoVersionadorBanco.arquivoSqlRodado(file.getName());
			
				if (!arquivoJaRodado) {
					
					FileInputStream entradaArquivo = new FileInputStream(file);
					
					Scanner lerArquivo = new Scanner(entradaArquivo, "UTF-8");
					
					StringBuilder sql = new StringBuilder();
					
					while (lerArquivo.hasNext()) {
						
						sql.append(lerArquivo.nextLine());
						sql.append("\n");
					}

					connection.prepareStatement(sql.toString()).execute();
					daoVersionadorBanco.gravaArquivoSqlRodado(file.getName());
					
					connection.commit();
					lerArquivo.close();
				}
			}
			
		}catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		  e.printStackTrace();
	  }

   }
}
