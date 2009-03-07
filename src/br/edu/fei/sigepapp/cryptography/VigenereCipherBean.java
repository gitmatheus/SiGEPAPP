package br.edu.fei.sigepapp.cryptography;

/**
 *
 * @author Matheus
 */


public class VigenereCipherBean {

  public VigenereCipherBean() {
  }

  public static final String Cipher(String secret, String key) {
    String encrypted = "";

 
    for(int i=0; i<secret.length(); i++)
    {

      String currKey = String.valueOf(key.charAt(i%(key.length())));


      int hash = currKey.hashCode()-31;

    
      int n = secret.charAt(i) + hash;
      if(n>126) n-= 95;

 
      encrypted += (char)n;
    }

    return encrypted;
  }

  
  public static final String DeCipher(String encrypted, String key) {
    String secret = "";

  
    for(int i=0; i<encrypted.length(); i++)
    {

      String currKey = String.valueOf(key.charAt(i%(key.length())));

  
      int hash = currKey.hashCode()-31;

    
      int n = encrypted.charAt(i) - hash;
      if(n<32) n+= 95;

  
      secret += (char)n;
    }

    return secret;
  }

}
