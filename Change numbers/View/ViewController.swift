//
//  ViewController.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Cocoa

class ViewController: NSViewController {
    
    let viewModel = ViewModel()

    @IBOutlet weak var numberTextField: NSTextField!
    @IBOutlet weak var resultLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func translateButtonAction(_ sender: NSButton) {
    }
}

