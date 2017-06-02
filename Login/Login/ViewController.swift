//
//  ViewController.swift
//  Login
//
//  Created by Bryan Gough on 2017-06-01.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destination.title = userName.text
        
        guard let sender = sender as? UIButton else {return}

        if sender == ForgetPasswordButton {
            segue.destination.navigationItem.title = "Forgot Password"
        } else if sender == ForgetUsernameButton {
            segue.destination.navigationItem.title = "Forgot Username"
        } else {
            segue.destination.navigationItem.title = userName.text
        }
        
    }

    @IBOutlet var ForgetUsernameButton: UIButton!
    @IBOutlet var ForgetPasswordButton: UIButton!
    @IBAction func forgetUsernameTouch(_ sender: Any) {
        performSegue(withIdentifier: "ToLanding", sender: sender as! UIButton)
    }
    
    @IBAction func forgetPasswordTouch(_ sender: Any) {
        performSegue(withIdentifier: "ToLanding", sender: ForgetPasswordButton)
    }
}

