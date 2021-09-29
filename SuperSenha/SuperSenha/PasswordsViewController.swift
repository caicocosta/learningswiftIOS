//
//  PasswordsViewController.swift
//  SuperSenha
//
//  Created by Caico Saler Oliveira Costa on 29/09/21.
//

import UIKit

class PasswordsViewController: UIViewController {

    @IBOutlet weak var tvPasswords: UITextView!
    var numberOfPasswords = 1
    var numberOfCharacters = 10
    var useLetters: Bool!
    var useNumbers: Bool!
    var userCapitalLetters: Bool!
    var userSpecialCharacters: Bool!
    
    var passwordGenerator: PasswordGenerator!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Total de senhas: \(numberOfPasswords)"
        
        passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters, useLetters: useLetters, useNumbers: useNumbers, useCapitalLetters: userCapitalLetters, useSpecialCharacters: userSpecialCharacters)
        
        generatePassowords()
    }
    
    func generatePassowords(){
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0))
        tvPasswords.text = ""
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }
    }
    @IBAction func generate(_ sender: UIButton) {
        generatePassowords()
    }
    
}
