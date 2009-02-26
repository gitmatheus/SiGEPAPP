/*
 * @(#)DAO.java 0.01 19/02/09
 *
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * 
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * | Guilherme   | 19/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 */
//~--- JDK imports ------------------------------------------------------------
package br.edu.fei.sigepapp.interfaces;

import java.util.List;

/**
 * Esta interface contém os protótipos para implementas as classes
 *
 * @version 0.01
 * @author Guilherme Wachs Lopes
 */
public interface DAO<E extends Object> {

    /**
     * Função responsável pela consulta no banco de dados
     * @return Uma lista contendo os dados obtidos
     */
    public List<E> seleciona(String query);

    /**
     * Função responsável pela adição de uma tupla no banco de dados
     * @param objAdicionar Objeto à ser adicionado
     * @return True se foi adicionado com sucesso.
     */
    public boolean adiciona(E objAdicionar);

    /**
     * Função responsável pela eliminação de uma tupla no banco de dados
     * @param objDeletar Objeto à ser deletado
     * @return True se foi deletado com sucesso.
     */
    public boolean deleta(E objDeletar);

    /**
     * Função responsável pela atualização de um registro no banco de dados.
     * @param objAtualiza Objeto à ser atualizado
     * @return True se foi deletado com sucesso.
     */
    public boolean atualiza(E objAtualiza);
}
