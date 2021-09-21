//
//  ViewController.swift
//  IMC
//
//  Created by Caico Saler Oliveira Costa on 20/09/21.
//

import UIKit

class ViewController: UIViewController {

   
    
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfHeigtht: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var ivResult: UIImageView!
    @IBOutlet weak var viResult: UIView!
    
    var imc = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculate(_ sender: Any) {
        if let weight = Double(tfWeight.text!), let height = Double(tfHeigtht.text!) {
            imc = weight / (height*height)
            showResults()
        } else {
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showResults(){
        var result = ""
        var image = ""
        
        switch imc {
            case 0..<16:
                result = "Magresa"
                image = "abaixo"
            case 16..<18.5:
                result = "Abaixo do peso"
                image = "abaixo"
            case 18.5..<25:
                result = "Peso ideal"
                image = "ideal"
            case 25..<30:
                result = "Sobrepeso"
                image = "sobre"
            default:
                result = "Obesidade"
                image = "obesidade"
        }
        
        lbResult.text = "\(Int(imc)): \(result)"
        ivResult.image = UIImage(named: image)
        viResult.isHidden = false
        view.endEditing(true)
    }
    
}

