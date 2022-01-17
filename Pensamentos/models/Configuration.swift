//
//  Configuration.swift
//  Pensamentos
//
//  Created by Bruno Vieira Souza on 13/10/21.
//

import Foundation

// CLASS CRIADA PARA CUIDAR DO MEU USERDEFAULLT

class Configuration {
    
    
    // enum criado para informar as chaves do meu USERDEFAULT
    enum UseDefaultsKeys: String {
        case timeInterval = "timeInterval"
        case colorScheme = "colorScheme"
        case autorefresh = "autorefresh"
    }
    
    
    // CRIANDO UMA VAR DEFAULTS PARA USERDEFAULT.STANDERD
    let defaults = UserDefaults.standard
    
    // CRIANDO UMA VARIAVEL JA ESTANCIADA DA MINHA CLASSE PARA NAO PERMETIR ESTANCIA EM OUTRAS CLASSES
    // QUANDO EU CHAMAR Configuration.shared em outra classe, ela ja esta instanciada
    static var shared: Configuration = Configuration()
    
    
    // CRIAMOS UMA VARIAVEL COMPUTADA PARA GET(RETORNAR INFORMACOES) E SET(PARA INSERIR INFORMACOES NELA)
    var timeInterval: Double { // ESSA VARIAVEL "TIMEITERVAL" VAI AMARZEANAR O VALOR DO TEMPO QUE A IMG VAI FICAR NA TELA ATRAVES DO SLIDER
        get {
            return defaults.double(forKey: UseDefaultsKeys.timeInterval.rawValue) // usamos a variavel criada acima defaults(tipo UserDefault.standard) para me retornar um Double e minha forKey e meu Enum.rawvalue
        }
        set {
            defaults.set(newValue, forKey: UseDefaultsKeys.timeInterval.rawValue) // usamos para setar os valores escolhido pelo usuario. "newValue": representa o novo valor setado e forKey eh minha chave
        }
    }
    
    var colorScheme: Int {
        get {
            return defaults.integer(forKey: UseDefaultsKeys.colorScheme.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UseDefaultsKeys.colorScheme.rawValue)
        }
    }
    
    var autorefresh: Bool {
        get {
            return defaults.bool(forKey: UseDefaultsKeys.autorefresh.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UseDefaultsKeys.autorefresh.rawValue)
        }
    }
    
    
    
    
    
    
    private init() { // inicializamos private para outras classes nao terem acesso a inicializar esta classe.
        if defaults.double(forKey: UseDefaultsKeys.timeInterval.rawValue) == 0 { // aqui falo caso meu valor do UserDefault trazido for 0 (ou seja a primeira vez que ele retornara)
            defaults.set(8.0, forKey: UseDefaultsKeys.timeInterval.rawValue) // ele setara na variavel timeInterval o valor inicar de 8.0 segundos
        }
        
    }
    
}
