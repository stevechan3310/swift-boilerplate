//
//  ViewController.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 12/19/19.
//  Copyright © 2019 COMPANY_NAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLanguage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    // MARK: UIButton Action
    @IBAction func inAppLocalizationDemo(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_to_inapplocalizationdemo", sender: self)
    }
}

