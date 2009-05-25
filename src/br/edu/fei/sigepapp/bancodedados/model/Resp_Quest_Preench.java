/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Resp_Quest_Preench {
long cd_quest_preench;
long cd_pergunta;
long cd_resposta;

    public Resp_Quest_Preench() {
    }

    public Resp_Quest_Preench(long cd_quest_preench, long cd_pergunta, long cd_resposta) {
        this.cd_quest_preench = cd_quest_preench;
        this.cd_pergunta = cd_pergunta;
        this.cd_resposta = cd_resposta;
    }

    public long getCd_pergunta() {
        return cd_pergunta;
    }

    public void setCd_pergunta(long cd_pergunta) {
        this.cd_pergunta = cd_pergunta;
    }

    public long getCd_quest_preench() {
        return cd_quest_preench;
    }

    public void setCd_quest_preench(long cd_quest_preench) {
        this.cd_quest_preench = cd_quest_preench;
    }

    public long getCd_resposta() {
        return cd_resposta;
    }

    public void setCd_resposta(long cd_resposta) {
        this.cd_resposta = cd_resposta;
    }
    

}
