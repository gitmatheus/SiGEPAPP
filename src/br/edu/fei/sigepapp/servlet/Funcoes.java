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

        return (    (vCampo.toUpperCase().matches("DESCRI��O")      )
                 || (vCampo.toUpperCase().matches("CONTEXTO")       )
                 || (vCampo.toUpperCase().matches("PROBLEMA")       )
                 || (vCampo.toUpperCase().matches("SOLU��O")        )
                 || (vCampo.toUpperCase().matches("BARREIRAS")      )
                 || (vCampo.toUpperCase().matches("SINTOMAS")       )
                 || (vCampo.toUpperCase().matches("CONSEQU�NCIAS")  )
                 || (vCampo.toUpperCase().matches("RECOMENDA��ES")  )
               );
    }
}
