/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.cryptography;

/**
 *
 * @author Matheus
 */


public class VigenereCipherBean {

  /** Creates a new instance of VigenereCipherBean */
  public VigenereCipherBean() {
  }

  /**
   * Encrypt a String using the Vigenere Algorithm
   * @param secret the string that needs to be encrypted
   * @param key the key used for the encryption
   * @return the encrypted string
   */
  public static final String Cipher(String secret, String key) {
    String encrypted = "";

    // Loop through all characters of the secret
    for(int i=0; i<secret.length(); i++)
    {
      // Get the current character of the key
      String currKey = String.valueOf(key.charAt(i%(key.length())));

      // Get the numeric value of the current key character
      int hash = currKey.hashCode()-31;

      // Shift the character of the secret; rotate if necessary
      int n = secret.charAt(i) + hash;
      if(n>126) n-= 95;

      // Append to the ciphered string
      encrypted += (char)n;
    }

    return encrypted;
  }

  /**
   * Decrypt a String using the Vigenere Algorithm
   * @param encrypted the encrypted string that needs to be decrypted
   * @param key the key used for the encryption
   * @return the decrypted string
   */
  public static final String DeCipher(String encrypted, String key) {
    String secret = "";

    // Loop through all characters of the encrypted string
    for(int i=0; i<encrypted.length(); i++)
    {
      // Get the current character of the key
      String currKey = String.valueOf(key.charAt(i%(key.length())));

      // Get the numeric value of the current key character
      int hash = currKey.hashCode()-31;

      // Shift the character of the encrypted string; rotate if necessary
      int n = encrypted.charAt(i) - hash;
      if(n<32) n+= 95;

      // Append to the de-ciphered secret
      secret += (char)n;
    }

    return secret;
  }

}
