//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Caico Saler Oliveira Costa on 03/11/21.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var swAuthorRefresh: UISwitch!
    @IBOutlet weak var slTimerInterval: UISlider!
    @IBOutlet weak var lbTimerInterval: UILabel!
    @IBOutlet weak var scColorSchema: UISegmentedControl!
    
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name("Refresh"), object: nil, queue: nil, using: { (notification) in
            self.formatView()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView() {
        swAuthorRefresh.setOn(config.autoRefresh, animated: false)
        slTimerInterval.setValue(Float(config.timerInterval), animated: false)
        scColorSchema.selectedSegmentIndex = config.colorSchema
        changeTimeIntervalLabel(with: config.timerInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        lbTimerInterval.text = "Mudar após \(Int(value)) segundos"
    }
    
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func changeTimerInterval(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeIntervalLabel(with: value)
        config.timerInterval = value
    }
    
    @IBAction func changeColorSchema(_ sender: UISegmentedControl) {
        config.colorSchema = sender.selectedSegmentIndex
    }
}
