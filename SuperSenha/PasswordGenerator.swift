//
//  PasswordGenerator.swift
//  SuperSenha
//
//  Created by Caico Saler Oliveira Costa on 29/09/21.
//

import Foundation

class PasswordGenerator {
    var numberOfCharacters: Int
    var useLetters: Bool
    var useNumbers: Bool
    var useCapitalLetters: Bool
    var useSpecialCharacters: Bool
    
    var passwords: [String] = []
    
    private let letters = "abcdefghijklmnopqrstuvwxyz"
    private let specialCharacters = "!@#$%ˆ&*()_-+=˜|[]{}';:?/<>.,"
    private let numbers = "1234567890"
    
    init(numberOfCharacters: Int, useLetters: Bool, useNumbers: Bool, useCapitalLetters: Bool, useSpecialCharacters: Bool) {
            
        var numChars = min(numberOfCharacters, 16)
        numChars = max(numChars, 1)
        
        self.numberOfCharacters = numChars
        self.useLetters = useLetters
        self.useNumbers = useNumbers
        self.useCapitalLetters = useCapitalLetters
        self.useSpecialCharacters = useSpecialCharacters
    }
    
    func generate(total: Int) -> [String]{
        passwords.removeAll()
        var universe = ""
        
        if useLetters {
            universe += letters
        }
        
        if useNumbers {
            universe += numbers
        }
        
        if useSpecialCharacters {
            universe += specialCharacters
        }
        
        if useCapitalLetters {
            universe += letters.uppercased()
        }
        
        let arrayUniverse = Array(universe)
        
        while passwords.count < total {
            var password = ""
            for _ in 1...numberOfCharacters {
                let index = Int(arc4random_uniform(UInt32(arrayUniverse.count)))
                password += String(arrayUniverse[index])
            }
            passwords.append(password)
        }
        
        return passwords
    }
}
