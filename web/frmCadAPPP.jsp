<%@include file="cabecalho.jsp"%>
<%        /**
         * @{#}frmCadAPPP.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor             |   Data        |   Descricao                |
         * |------------------------------------------------------------------|
         * |  Matheus Gonçalves  |  19/03/2009   | Definicao do Cadastro      |
         * |------------------------------------------------------------------|
         **/
%>
<link type="text/css" href="css/ui.all.css" rel="Stylesheet" />
<script src="js/jquery-ui-personalized-1.5.3.js" type="text/javascript"></script>
<script type="text/javascript">
			$(function(){

				// Accordion
				$("#accordion").accordion({ header: "h3" });

				// Tabs
				$('#tabs').tabs();


				// Dialog
				$('#dialog').dialog({
					autoOpen: false,
					width: 600,
					buttons: {
						"Ok": function() {
							$(this).dialog("close");
						},
						"Cancel": function() {
							$(this).dialog("close");
						}
					}
				});

				// Dialog Link
				$('#dialog_link').click(function(){
					$('#dialog').dialog('open');
					return false;
				})
				.hover(
					function() { $(this).addClass('ui-hover-state'); },
					function() { $(this).removeClass('ui-hover-state'); }
				);

				// Datepicker
				$('#datepicker').datepicker({
					inline: true
				});

				// Slider
				$('#slider').slider({
					range: true
				});

			});
		</script>
        <style type="text/css">
			body{ font: 62.5% Verdana, sans-serif; margin: 50px;}
			#dialog_link {padding: .7em 1em;text-decoration: none;}
		</style>

		<!-- Tabs -->
		<h2 class="demoHeaders">APPP</h2>
		<div id="tabs" style="width:95%;left:10px" align="left">

			<ul>
				<li><a href="#tabs-1">Patterns</a></li>
				<li><a href="#tabs-2">Anti-Patterns</a></li>
				<li><a href="#tabs-3">Personas</a></li>
			</ul>
			<div id="tabs-1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
			<div id="tabs-2">Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.</div>

			<div id="tabs-3">Nam dui erat, auctor a, dignissim quis, sollicitudin eu, felis. Pellentesque nisi urna, interdum eget, sagittis et, consequat vestibulum, lacus. Mauris porttitor ullamcorper augue.</div>
		</div>
		
<%@include file="rodape.jsp"%>
