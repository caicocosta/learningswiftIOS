//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by Caico Saler Oliveira Costa on 27/10/21.
//

import UIKit

class TaxesViewController: UIViewController {

    @IBOutlet weak var lbDolar: UILabel!
    @IBOutlet weak var lbStateTaxes: UILabel!
    @IBOutlet weak var lbIOF: UILabel!
    @IBOutlet weak var lbIOFDescription: UILabel!
    @IBOutlet weak var swCreditCard: UISwitch!
    @IBOutlet weak var lbReal: UILabel!
    @IBOutlet weak var lbStateTaxDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTaxes()
    }
    
    @IBAction func changeIOF(_ sender: UISwitch) {
        calculateTaxes()
    }
    
    func calculateTaxes() {
        lbStateTaxDescription.text = "Imposto do estado (\(tc.getFormatedValue(of: tc.stateTax, withCurrency:"")))"
        lbIOFDescription.text = "IOF (\(tc.getFormatedValue(of: tc.iof, withCurrency: ""))"
        lbDolar.text = tc.getFormatedValue(of: tc.shoppingValue, withCurrency: "US$ ")
        lbIOF.text = tc.getFormatedValue(of: tc.iofValue, withCurrency: "US$ ")
        lbStateTaxes.text = tc.getFormatedValue(of: tc.stateTaxValue, withCurrency: "US$ ")
        let real = tc.calculate(usingCreditCard: swCreditCard.isOn)
        lbReal.text = tc.getFormatedValue(of: real, withCurrency: "R$ ")
        
    }
    

}
