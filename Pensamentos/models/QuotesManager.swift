//
//  QuotesManager.swift
//  Pensamentos
//
//  Created by Bruno Vieira Souza on 13/10/21.
//

import Foundation

//CLASSE CRIADA PARA GERENCIAR MEUS ARQUIVOS JSON

class QuotesManager {
    
    let quotes: [Quote] // aqui criamos uma variavel de array do tipo Quote. que guardara todas (frases, autores e imagens)
    
    init() { // inicializamos esta classe
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")! //aqui criamos uma var para transformar em URL o caminho do json que se encontra dentro do nosso arquivo Bundle.
        let jsonData = try! Data(contentsOf: fileURL) // aqui criamos uma var para transformar esse caminho em dados, que nao conseguimos utilizar ainda
        let jsonDecoder = JSONDecoder() // aqui criamos uma variavel para receber o metodo JSONDecoder
        quotes = try! jsonDecoder.decode([Quote].self, from: jsonData) // nosso ARRAY DE QUOTES recebe a variavel criada acima JSONDECODER.decode(esse e o metodo da classe JsonDecoder) e entre () informa o que sera decodificado que no caso sera o array de [Quote]  .self, from: de onde sera decodificado. que sera nossa variavel jsonData que criaos acima.
    }
    
    func getRandomQuote() -> Quote { // aqui criamos um metodo para sortear um QUOTE qualquer aleatorio
        let index = Int(arc4random_uniform(UInt32(quotes.count))) // usamos numero randomicos para sortear um numero entre 0 e o numero de quotes do meu Json
        return quotes[index] // aqui eu retorno um quotes[index sorteado acima], dessa forma uma Quote aleatoria, contendo frase, autor e image
        
    }
    
 
}
