/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.cryptography;

/**
 *
 * @author Matheus
 */
public class Criptografia {

    public Criptografia() {
    }
    
    public static final String escondeSenha(String pw)
    {
        String x = null;
        x = RemoverAcentos.remover(pw);
        x = VigenereCipherBean.Cipher(x,"walle");
        x = Base64Coder.encodeString(x);

        return x;
    }
    public static final String descobreSenha(String pw)
    {
        String x = null;

        x = Base64Coder.decodeString(pw);
        x = VigenereCipherBean.DeCipher(x,"walle");
        return x;
    }

}
