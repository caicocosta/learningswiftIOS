//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Caico Saler Oliveira Costa on 27/10/21.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var tfIOF: UITextField!
    @IBOutlet weak var tfStateTexas: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfDolar.text = tc.getFormatedValue(of: tc.dolar, withCurrency: "")
        tfIOF.text = tc.getFormatedValue(of: tc.iof, withCurrency: "")
        tfStateTexas.text = tc.getFormatedValue(of: tc.stateTax, withCurrency: "")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setValues() {
        tc.dolar = tc.convertToDouble(tfDolar.text!)
        tc.iof = tc.convertToDouble(tfIOF.text!)
        tc.stateTax = tc.convertToDouble(tfStateTexas.text!)
    }
}


extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        setValues()
    }
}
