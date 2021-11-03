//
//  Quotes.swift
//  Pensamentos
//
//  Created by Caico Saler Oliveira Costa on 03/11/21.
//

import Foundation

struct Quote: Codable {
    
    let quote: String
    let author: String
    let image: String
    
    var quotedFormatted: String {
        return " ‟" + quote + "” "
    }
    
    var authorFormatted: String {
        return "- " + author + " -"
    }
}
