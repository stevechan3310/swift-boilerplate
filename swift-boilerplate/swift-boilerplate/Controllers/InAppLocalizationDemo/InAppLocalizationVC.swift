//
//  InAppLocalizationVC.swift
//  swift-boilerplate
//
//  Created by Steve Chan on 2/12/20.
//  Copyright © 2020 COMPANY_NAME. All rights reserved.
//

import UIKit

import Localize_Swift

class InAppLocalizationVC: UIViewController {
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var btnTranslate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UIButton Action
    
    @IBAction func translate(_ sender: Any) {
        Localize.setCurrentLanguage("ms")
        
        lblText.text = lblText.text?.localized()
        btnText.setTitle(btnText.titleLabel?.text?.localized(), for: UIControl.State.normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
