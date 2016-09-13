/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gs.ejemplo20160913;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

/**
 *
 * @author erios
 */
public class Main {
    
    public static String jaxbObjectToXML(Cabecera customer, boolean pretty) {
        String xmlString = "";
        try {
            JAXBContext context = JAXBContext.newInstance(Cabecera.class);
            Marshaller m = context.createMarshaller();
            if(pretty){
                m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE); // To format XML
            }
            StringWriter sw = new StringWriter();
            m.marshal(customer, sw);
            xmlString = sw.toString();

        } catch (JAXBException e) {
            e.printStackTrace();
        }

        return xmlString;
    }
    
    public static void main(String[] args){
        
        Cabecera cabecera = new Cabecera();
        cabecera.setNumero("00001");
        cabecera.setFecha(new Date());
        
        ArrayList<Detalle> detalle = new ArrayList<>();
        Detalle bean = new Detalle();
        bean.setSecuencial(1);
        bean.setMonto(10.00);
        detalle.add(bean);
        Detalle bean2 = new Detalle();
        bean2.setSecuencial(2);
        bean2.setMonto(6.95);
        detalle.add(bean2);
        cabecera.setDetalle(detalle);
        
        String xmlInString = "";
        
        xmlInString = Main.jaxbObjectToXML(cabecera,true);
        
        System.out.println(xmlInString);
    }
}
