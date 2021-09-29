//
//  ViewController.swift
//  SuperSenha
//
//  Created by Caico Saler Oliveira Costa on 27/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swCapitalLetters: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passwordsViewController = segue.destination as! PasswordsViewController
        if let numberOfPassowords = Int(txTotalPasswords.text!) {
            passwordsViewController.numberOfPasswords = numberOfPassowords
        }
        
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            passwordsViewController.numberOfCharacters = numberOfCharacters
        }
        
        passwordsViewController.useLetters = swLetters.isOn
        passwordsViewController.useNumbers = swNumbers.isOn
        passwordsViewController.userCapitalLetters = swCapitalLetters.isOn
        passwordsViewController.userSpecialCharacters = swSpecialCharacters.isOn
        
        view.endEditing(true)
    }


}

