<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> 


    <!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

  <body>
 
 <jsp:include page="theme-loader.jsp"></jsp:include>
 
  <!-- Pre-loader end -->
  <div id="pcoded" class="pcoded">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
         
         <jsp:include page="navbar.jsp"></jsp:include>

          <div class="pcoded-main-container">
              <div class="pcoded-wrapper">
              
              <jsp:include page="navbarmainmenu.jsp"></jsp:include>
            
                  
                  <div class="pcoded-content">
                      <!-- Page-header start -->
                    <jsp:include page="page-head.jsp"></jsp:include>
                    
                    
                      <!-- Page-header end -->
                        <div class="pcoded-inner-content">
                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <!-- Page-body start -->
                                    <div class="page-body">
                                    
                                		 <div class="row">
                                            <div class="col-sm-12">
                                             <div class="card">
                                                   <div class="card-block">
                                                    <h4 class="sub-title">Cadastro usu�rio</h4>
                                			
                                                   <form class="form-material" enctype="multipart/form-data" action="<%= request.getContextPath() %>/ServletUsuaioController" method="post" id="formUser">
                                                   
                                                   		<input type="hidden" name="acao" id="acao" value="">
                                                   
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${modelLogin.id}"> <!-- Somente leitura " desabilitado " -->
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Usu�rio: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default input-group mb-4">
                                                            	<div class="input-group-prepend">
                                                            	
                                                            	<c:if test="${modelLogin.fotouser != '' && modelLogin.fotouser != null}">
                                                            	
                                                            	<a href="<%= request.getContextPath()%>/ServletUsuarioController?acao=downloadFoto&id=${modelLogin.id}"> <!-- HREF SEMPRE DISPARA UM GET PARA SERVLET -->
																	<img alt="Imagem User" id="fotoembase64" src="${modelLogin.fotouser}" width="70 px">
																</a>
                                                            	</c:if>
                                                            	
                                                            	<c:if test="${modelLogin.fotouser == '' || modelLogin.fotouser == null}">
																	
																	<img alt="Imagem User" id="fotoembase64" src="assets/images/user.png" width="70 px">
																	
                                                                </c:if>
                                                            	
                                                                </div>
                                                                <input type="file" id="filefoto" name="filefoto" accept="image/*" onchange="visualizarImg('fotoembase64', 'filefoto');" class="form-control-file" style="margin-top: 15px; margin-left: 5px;">
                                                            </div>
                                                            
                                                              <div class="form-group form-default form-static-label">                                                      <!-- Deixa gravado na tela  -->
                                                                <input type="text" name="nome" id="nome" class="form-control" required="required" value="${modelLogin.nome}">   
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Nome: </label>
                                                            </div>
                                                            
                                                              <div class="form-group form-default form-static-label">                                                      <!-- Deixa gravado na tela  -->
                                                                <input type="text" name="dataNascimento" id="dataNascimento" class="form-control" required="required" value="${modelLogin.dataNascimento}">   
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Data Nascimento: </label>
                                                            </div>
                                                            
                                                              <div class="form-group form-default form-static-label">                                                      
                                                                <input type="text" name="rendamensal" id="rendamensal" class="form-control" required="required" value="${modelLogin.rendamensal}">   
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Renda Mensal: </label>
                                                            </div>
                                                           
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="email" name="email" id="email" class="form-control" required="required" autocomplete="off" value="${modelLogin.email}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">E-mail: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
	                                                            <select class="form-control" aria-label="Default select example" name="perfil" >
																  <option disabled="disabled">[Selecione o perfil]</option>
																 
																  <option value="ADMIN" <%
																  
																  ModelLogin modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																  
																	  if(modelLogin != null && modelLogin.getPerfil().equals("ADMIN")) {
																		  out.println("");
																			out.print("selected=\"selected\"");
																		  out.println("");
																  }%> >Admin</option>
																  
																  <option value="SECRETARIA" <%
																  
 																	modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																  
																	  	if(modelLogin != null && modelLogin.getPerfil().equals("SECRETARIA")) {
																		  out.println("");
																			out.print("selected=\"selected\"");
																		  out.println("");
																  }%> >Secret�ria</option>
																  
																  <option value="AUXILIAR" <%
																  
																	modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																  
																	  	if(modelLogin != null && modelLogin.getPerfil().equals("AUXILIAR")) {
																		  out.println("");
																			out.print("selected=\"selected\"");
																		  out.println("");
																  }%> >Auxiliar</option>
																
																</select>
																<span class="form-bar"></span>
                                                                <label class="float-label">Perfil: </label>
                                                            </div>
                                                            
                                                             <div class="form-group form-default form-static-label">
                                                                <input  onblur="pesquisaCep();" name="cep" id="cep" class="form-control" required="required" autocapitalize="off" value="${modelLogin.cep}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Cep: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="logradouro" id="logradouro" class="form-control" required="required" autocapitalize="off" value="${modelLogin.logradouro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Logradouro: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="bairro" id="bairro" class="form-control" required="required" autocapitalize="off" value="${modelLogin.bairro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Bairro: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="localidade" id="localidade" class="form-control" required="required" autocapitalize="off" value="${modelLogin.localidade}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Localidade: </label>
                                                            </div>
                                                            
                                                             <div class="form-group form-default form-static-label">
                                                                <input type="text" name="uf" id="uf" class="form-control" required="required" autocapitalize="off" value="${modelLogin.uf}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Estado: </label>
                                                            </div>
                                                            
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="numero" id="numero" class="form-control" required="required" autocapitalize="off" value="${modelLogin.numero}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Numero: </label>
                                                            </div>
                                                            
                                                             <div class="form-group form-default form-static-label">
                                                                <input type="text" name="login" id="login" class="form-control" required="required" autocapitalize="off" value="${modelLogin.login}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Login: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="password" name="senha" id="senha" class="form-control" required="required" autocapitalize="off" value="${modelLogin.senha}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Senha: </label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                            	<input type="radio" name="sexo" checked="checked" value="MASCULINO" <%
                                                            	
                                                            			modelLogin = (ModelLogin) request.getAttribute("modelLogin");
                                                    			
			                                                       	     if(modelLogin != null && modelLogin.getSexo().equals("MASCULINO")) {
																			  out.println("");
																        		out.print("checked=\"checked\"");
																			  out.println("");
															  }
                                                       	
                                                            	%> >Masculino</>
                                                            	
                                                            	<input type="radio" name="sexo" value="FEMININO" <% 
                                                            		
                                                            		modelLogin = (ModelLogin) request.getAttribute("modelLogin");
                                                            			
                                                            	     if(modelLogin != null && modelLogin.getSexo().equals("FEMININO")) {
																		  out.println("");
																			out.print("checked=\"checked\"");
																		  out.println("");
																  }
                                                            	
                                                            		%> >Feminino</>
                                                            </div>
                                                            
                                                            <button type="button" class="btn btn-primary waves-effect waves-light" onclick="limparForm();">Novo</button>
                                                			<button type="submit" class="btn btn-success waves-effect waves-light">Salvar</button>
												            <button type="button" class="btn btn-info waves-effect waves-light" onclick="criarDeleteComAjax();">Excluir</button>
                                                 			
                                                 			<c:if test="${modelLogin.id > 0}">
                                                 				<a href="<%= request.getContextPath() %>/ServletTelefone?iduser=${modelLogin.id}" class="btn btn-warning">Telefone</a>
                                                 			</c:if>
                                                 			
                                                 			<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>
                                                  </form>
                                		
                                            </div>
                                           </div>
                                          </div>
                                         </div>
                                         <span id="msg">${msg}</span>
                                         
							   <div style="height: 300px; overflow: scroll;">
										<table class="table" id="tabelaresultadosview">
										  <thead>
										    <tr>
										      <th scope="col">Usu�rio</th>
										      <th scope="col">Nome</th>
										      <th scope="col">Ver</th>
										    </tr>
										  </thead>
									<tbody>
										<c:forEach items='${modelLogins}' var='ml'>
										<tr>
											<td><c:out value="${ml.id}"></c:out></td>
											<td><c:out value="${ml.nome}"></c:out></td>
											<td> <a class="btn btn-primary" href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${ml.id}">Ver</a></td>
										</tr>
										
										</c:forEach>
								
							   	  </tbody>
									</table>
								</div>
								
								<nav aria-label="Page navigation example">
									  <ul class="pagination">
									  
									  <%
									  	int totalPagina = (int) request.getAttribute("totalPagina");
									  
										  for (int p = 0; p < totalPagina; p++){
											  String url = request.getContextPath() + "/ServletUsuarioController?acao=paginar&pagina=" + (p * 5);
											  out.print("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url +"\">"+(p + 1)+"</a></li>");
									  }
									  %>
									    	
									  </ul>
								</nav>
                                         
                                       </div>
                                    <!-- Page-body end -->
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  
    
 <jsp:include page="javascriptfile.jsp"></jsp:include> 
 
 <!-- Modal -->
<div class="modal fade" id="exampleModalUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pesquisa de usu�rio</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
		<div class="input-group mb-3">
 			 <input type="text" class="form-control" placeholder="Nome" aria-label="nome" id="Pesquisar" aria-describedby="basic-addon2">
 			  <div class="input-group-append">
    		 <button class="btn btn-warning" type="button" onclick="buscarUsuario();">Buscar</button>
  		</div>
  		</div>
  		
  		
<div style="height: 300px; overflow: scroll;">
	<table class="table" id="tabelaresultados">
	  <thead>
	    <tr>
	      <th scope="col">Usu�rio</th>
	      <th scope="col">Nome</th>
	      <th scope="col">Ver</th>
	    </tr>
	  </thead>
	  <tbody>

  </tbody>
</table>
</div>

 <nav aria-label="Page navigation example">
  <ul class="pagination" id="ulPaginacaoUserAjax">
		


 </ul>
</nav>

<span id="totalResultados"></span>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" data-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>
 
 
 <script type="text/javascript">
 
 
 // Mostar R$ na tela 
 $("#rendamensal").maskMoney({showSymbol:true, symbol:"R$ ", decimal:",", thousands:"."});
 
 const formatter = new Intl.NumberFormat('pt-BR', {
	currency : 'BRL',
	minimumFractionDigits : 2
 }); 
 
 $('#rendamensal').val(formatter.format($("#rendamensal").val()));
 
 $('#rendamensal').focus();
 
 
  // Data formatada
 var dataNascimento = $("#dataNascimento").val();
  
  if (dataNascimento != null && dataNascimento != '') {
 
 	var dateFormat = new Date(dataNascimento);
 
 	$("#dataNascimento").val(dateFormat.toLocaleDateString('pt-BR',{timeZone: 'UTC' }));

  }
 
 $("#nome").focus();
 
 $( function () {
	  
	  $("#dataNascimento").datepicker({
		    dateFormat: 'dd/mm/yy',
		    dayNames: ['Domingo','Segunda','Ter�a','Quarta','Quinta','Sexta','S�bado'],
		    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','S�b','Dom'],
		    monthNames: ['Janeiro','Fevereiro','Mar�o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		    nextText: 'Pr�ximo',
		    prevText: 'Anterior'
		});
} );
 
 
 
 // JQUERY	FAZ QUE O CAMPO DA TELA ACEITE S� N�MERO
 $("#numero").keypress(function (event) {
	return  /\d/.test(String.fromCharCode(event.keyCode));
}); 
 
 $("#cep").keypress(function (event) {
	return  /\d/.test(String.fromCharCode(event.keyCode));
}); 

 
 function pesquisaCep() {
	var cep = $("#cep").val();
	
	$.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
		
		 if (!("erro" in dados)) {
			 
			  //Atualiza os campos com os valores da consulta.
             $("#cep").val(dados.cep);
             $("#logradouro").val(dados.logradouro);
             $("#bairro").val(dados.bairro);
             $("#localidade").val(dados.localidade);
             $("#uf").val(dados.uf);
             
		 }
		
	});
}
 
 
 function visualizarImg(fotoembase64, filefoto) {
	
	 var preview = document.getElementById(fotoembase64); // CAMPO IMG HTML
	 var fileUser = document.getElementById(filefoto).files[0]; // BUSCA A IMAGEM
	 var reader = new FileReader();// IMAGEM QUE VEM TELA
	 
	 
	 reader.onloadend = function () {
		 preview.src = reader.result; //CARREGA A FOTO NA TELA
	};
	
	if (fileUser){
		reader.readAsDataURL(fileUser); // PREVIEW DA IMAGEM
	}else {
		preview.src = '';
	}
}
 
 function verEditar(id) {
	 
	 var urlAction = document.getElementById('formUser').action; 
	 
	 window.location.href = urlAction + '?acao=buscarEditar&id=' + id; // executa um get de redirecionamento 
	 
	 
 }
 
 function buscaUserPagAjax(url) {
	 
    var urlAction = document.getElementById('formUser').action;
    var Pesquisar = document.getElementById('Pesquisar').value;

		 $.ajax({

		 method: "get",
		 url: urlAction,
		 data: url,
		 success: function(response, textStatus, xhr) {
			 
   var json = JSON.parse(response);
		
			 
		$('#tabelaresultados > tbody > tr').remove(); <!-- Fun��o jquery-->
		$("#ulPaginacaoUserAjax > li").remove();
		
			for(var p = 0; p < json.length; p++){
				$('#tabelaresultados > tbody').append('<tr> <td> ' + json[p].id + '</td> <td> ' + json[p].nome + ' </td> <td> <button onclick="verEditar('+json[p].id+')" type="button" class="btn btn-primary">Ver</button> </td></tr>')			
			}
			
			document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
			
			var totalPagina = xhr.getResponseHeader("totalPagina");
			 
				for (var p = 0; p < totalPagina; p++){
					
					var url = 'Pesquisar=' + Pesquisar + '&acao=pesquisarUserAjaxPage&pagina=' + (p * 5);
					
					$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')"> ' +(p + 1)+ '</a></li>');
				}
			 
		}
		 
	  }).fail(function(xhr, status, errorThrown){m
		alert('Erro ao buscar usu�rio por nome: ' + xhr.responseText);
	});
}
 

function buscarUsuario() {
	 
	 var Pesquisar = document.getElementById('Pesquisar').value;
	 
	 	if (Pesquisar != null && Pesquisar != '' && Pesquisar.trim() != ''){ // Validando, pois tem que ter valor para bucar no banco de dados
		
	 var urlAction = document.getElementById('formUser').action; <!-- Endere�o da Servelt -->

	 $.ajax({
			 
			 method: "get",
			 url: urlAction,
			 data: "Pesquisar=" + Pesquisar + '&acao=pesquisarUserAjax',
			 success: function(response, textStatus, xhr) {
				 
		 var json = JSON.parse(response);
			
				 
			$('#tabelaresultados > tbody > tr').remove(); <!-- Fun��o jquery-->
			$("#ulPaginacaoUserAjax > li").remove();
			
				for(var p = 0; p < json.length; p++){
					$('#tabelaresultados > tbody').append('<tr> <td> ' + json[p].id + '</td> <td> ' + json[p].nome + ' </td> <td> <button onclick="verEditar('+json[p].id+')" type="button" class="btn btn-primary">Ver</button> </td></tr>')			
				}
				
				document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
				
				var totalPagina = xhr.getResponseHeader("totalPagina");
				 
					for (var p = 0; p < totalPagina; p++){
						
				var url = 'Pesquisar=' + Pesquisar + '&acao=pesquisarUserAjaxPage&pagina=' + (p * 5);
						
						$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')"> ' +(p + 1)+ '</a></li>');
					}
				 
			}
			 
		  }).fail(function(xhr, status, errorThrown){m
			alert('Erro ao buscar usu�rio por nome: ' + xhr.responseText);
		});
		 
	 }
}


 function criarDeleteComAjax() {
	
	 if (confirm("deseja realmente excluir os dados?")){
		 
		 var urlAction = document.getElementById('formUser').action;
		 var idUser = document.getElementById('id').value;
		 
		 $.ajax({
			 
			 method: "get",
			 url: urlAction,
			 data: "id=" + idUser + '&acao=deletarajax',
			 success: function(response) {
				 
				 limparForm(); <!-- Limpa o formul�rio e redireciona para o inicio da p�gina de cadastro-->
				document.getElementById('msg').textContent = response;
			}
			 
		  }).fail(function(xhr, status, errorThrown){
			alert('Erro ao deletear usu�rio por id: ' + xhr.responseText);
		});
		 
	 }
}
 
 
 function criarDelete() {
	 
	 if (confirm("Deseja realmente excluir os dados?")){
		 
		document.getElementById("formUser").method = 'get';
		document.getElementById("acao").value = 'deletar';
	 	document.getElementById("formUser").submit();

	 }
	 
	 
}
 
 function limparForm() {
	var elementos = document.getElementById("formUser").elements; // Retorna os elementos html dentro do form
	
	for (p = 0; p < elementos.length; p ++){
		elementos[p].value = '';
	}
}
 </script>
   
</body>
</html>
    