package br.edu.fei.sigepapp.log;

/*
 * @(#)GravarLog.java 0.01 20/02/09
 *
 * Este codigo e parte integrante do projeto de formatura,
 * do curso de ciencias da computacao, do Centro Universitario da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * |   Andrey    | 20/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 * 
 */

//~-- JDK import --------------------------------------------------------------
import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Logger;

/**
 *	Classe responsavel por salvar os logs de eventos do sistema.
 *	Estes logs podem ser acessados dentro do diretorio do servidor de conteiner,
 * neste caso o Tomcat. (%CATALINA_HOME%)
 *  
 * @author Andrey Masiero
 * @version 0.01 20 Fev 2009
 *
 */
public class GravarLog {
	
	/**
	 * Metodo responsavel pela gravacao do arquivo de log para erros.
	 * 
	 * @param erro String contendo a mensagem de erro.
	 */
	public static void gravaErro(String erro){
		try{
			//Cria o arquivo de log
			FileHandler hand = new FileHandler("sigepapp_log_erro.log");
			//Cria o log
			Logger log = Logger.getLogger("log_file");
			//Adiciona o log no arquivo
			log.addHandler(hand);
			//Escreve o log conforme do tipo (Ex: .severe() é o metodo para gravar log para level de erros)
			log.severe(erro);
		}catch(IOException e){
			
		}
	}
	
	/**
	 * Metodo responsavel pela gravacao do arquivo de log para alertas.
	 * 
	 * @param alerta String contendo o alerta do sistema.
	 */
	public static void gravaAlerta(String alerta){
		try{
			//Cria o arquivo de log
			FileHandler hand = new FileHandler("sigepapp_log_alerta.log");
			//Cria o log
			Logger log = Logger.getLogger("log_file");
			//Adiciona o log no arquivo
			log.addHandler(hand);
			//Escreve o log conforme do tipo (Ex: .warning() é o metodo para gravar log para level de alertas)
			log.warning(alerta);
		}catch(IOException e){
			
		}
	}
	
	/**
	 * Metodo responsavel pela gravacao do arquivo de log para informacoes de sucesso.
	 * 
	 * @param info String contendo a informacao.
	 */
	public static void gravaInformacao(String info){
		try{
			//Cria o arquivo de log
			FileHandler hand = new FileHandler("sigepapp_log_info.log");
			//Cria o log
			Logger log = Logger.getLogger("log_file");
			//Adiciona o log no arquivo
			log.addHandler(hand);
			//Escreve o log conforme do tipo (Ex: .info() é o metodo para gravar log para level de informacao)
			log.info(info);
		}catch (IOException e){
			
		}
	}

}
