/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.servlet;

/**
 *
 * @author Matheus
 */
public class Funcoes {

    public Funcoes (){
     
    }

    public static final boolean campoDescritivo(String vCampo){

        return (    (vCampo.toUpperCase().matches("DESCRIÇÃO")      )
                 || (vCampo.toUpperCase().matches("CONTEXTO")       )
                 || (vCampo.toUpperCase().matches("PROBLEMA")       )
                 || (vCampo.toUpperCase().matches("SOLUÇÃO")        )
                 || (vCampo.toUpperCase().matches("BARREIRAS")      )
                 || (vCampo.toUpperCase().matches("SINTOMAS")       )
                 || (vCampo.toUpperCase().matches("CONSEQUÊNCIAS")  )
                 || (vCampo.toUpperCase().matches("RECOMENDAÇÕES")  )
               );
    }
}
