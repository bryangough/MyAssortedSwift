//
//  SettingView.swift
//  CameraWithLevel
//
//  Created by Bryan Gough on 2017-05-03.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    var defaults:UserDefaults?
    
    @IBOutlet var varianceBar: UISlider!
    @IBAction func varianeChange(_ sender: UISlider) {
        var currentValue = Float(sender.value)
        print("\(currentValue)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        varianceBar.value = GlobalVariables.variance;
        defaults = UserDefaults.standard
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}
