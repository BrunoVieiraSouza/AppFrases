//
//  Quote.swift
//  Pensamentos
//
//  Created by Bruno Vieira Souza on 13/10/21.
//

import Foundation

// CLASSE CRIADA PARA REPRESENTAR MINHAS CHAVES DENTRO DO JSON E HERDAR A CLASSE CODABLE

// representa um pensamento struct

struct Quote: Codable {
    
    let quote: String
    let author: String
    let image: String
    
}
