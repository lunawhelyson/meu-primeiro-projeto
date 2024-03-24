package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import jakarta.servlet.jsp.jstl.sql.Result;
import model.ModelTelefone;

public class DAOTelefoneRepository {

	private Connection connection; 
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	public DAOTelefoneRepository() {
		
		connection = SingleConnectionBanco.getConnection(); // CONECTA COM BANCO DE DADOS
	
		}
	
	public List<ModelTelefone> listFone(Long idUserPai) throws Exception{
		
		List<ModelTelefone> retorno = new ArrayList<ModelTelefone>();
		
		String sql = "select * from telefone where usuario_pai_id = ? ";
		
		PreparedStatement preparaStatement = connection.prepareStatement(sql);
		
		preparaStatement.setLong(1, idUserPai);
		
		ResultSet rs = preparaStatement.executeQuery();
		
		while (rs.next()) { // ENQUANTO ESTIVER DADOS 
			
			ModelTelefone modelTelefone = new ModelTelefone();
			
			modelTelefone.setId(rs.getLong("id"));
			modelTelefone.setNumero(rs.getString("numero"));
			modelTelefone.setUsuario_cad_id(daoUsuarioRepository.consultaUsuarioID(rs.getLong("usuario_cad_id"))); //Carregando objeto       
			modelTelefone.setUsuario_pai_id(daoUsuarioRepository.consultaUsuarioID(rs.getLong("usuario_pai_id")));     
			
			retorno.add(modelTelefone);
		}
		
		return retorno;
	}
	
	
	   public void gravarTelefone (ModelTelefone modelTelefone) throws Exception {
		
		String sql = "insert into telefone (numero, usuario_pai_id, usuario_cad_id) values (?, ?, ?)";
		
		PreparedStatement preparaStatement = connection.prepareStatement(sql);
		
		preparaStatement.setString(1, modelTelefone.getNumero());
		preparaStatement.setLong(2, modelTelefone.getUsuario_pai_id().getId());
		preparaStatement.setLong(3, modelTelefone.getUsuario_cad_id().getId());
		
		preparaStatement.execute();
		
		connection.commit();
		
	}
	
	public void deletarFone (Long id) throws Exception {
		
		String sql = "delete from telefone where id = ?";
		
		PreparedStatement preparaStatement = connection.prepareStatement(sql);
		
		preparaStatement.setLong(1, id);
		
		preparaStatement.executeUpdate();
		
		connection.commit();
	}
	
	public boolean existeFone(String fone, Long idUser)  throws Exception{
		
		String sql = "select count(1) > 0 as existe from telefone where usuario_pai_id =? and numero =? ";
		
		PreparedStatement preparaStatement = connection.prepareStatement(sql);
		
		preparaStatement.setLong(1, idUser);
		preparaStatement.setString(2, fone);
		
		ResultSet resultSet = preparaStatement.executeQuery();
		
		resultSet.next();
		
		return resultSet.getBoolean("existe");
		
	}
	
}
