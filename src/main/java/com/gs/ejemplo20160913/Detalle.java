/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gs.ejemplo20160913;

import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author erios
 */
@XmlRootElement
public class Detalle {
    
    private int secuencial;
    private double monto;

    /**
     * @return the secuencial
     */
    public int getSecuencial() {
        return secuencial;
    }

    /**
     * @param secuencial the secuencial to set
     */
    public void setSecuencial(int secuencial) {
        this.secuencial = secuencial;
    }

    /**
     * @return the monto
     */
    public double getMonto() {
        return monto;
    }

    /**
     * @param monto the monto to set
     */
    public void setMonto(double monto) {
        this.monto = monto;
    }
}
