//
//  ViewController.swift
//  KeychainSwiftExample
//
//  Created by Ben Honig on 8/30/15.
//  Copyright (c) 2015 iPhonig, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textToDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //save as public key
    @IBAction func savePublicKey(sender: UIButton) {
        var textToSave = textField.text
        BHKeychainSwift.storeKeyOfType(BHKeychainSwift.BHKeychainKeyType.Public, keyData: textToSave, accountName: "username", applicationTag: "com.appname.key.public")
    }
    
    //retrieve public key
    @IBAction func retrievePublicKey(sender: UIButton) {
        let rawPublicKey = BHKeychainSwift.get(BHKeychainSwift.BHKeychainKeyType.Private, accountName: "username", applicationTag: "com.appname.key.public")
        //convert key data to string
        let string = NSString(data: rawPublicKey!, encoding: NSUTF8StringEncoding)
        textToDisplay.text = string as? String
    }
    
    //save as private key
    @IBAction func savePrivateKey(sender: UIButton) {
        var textToSave = textField.text
        BHKeychainSwift.storeKeyOfType(BHKeychainSwift.BHKeychainKeyType.Private, keyData: textToSave, accountName: "username", applicationTag: "com.appname.key.private")

    }
    
    //retrieve private key
    @IBAction func retrievePrivateKey(sender: UIButton) {
        let rawPrivateKey = BHKeychainSwift.get(BHKeychainSwift.BHKeychainKeyType.Private, accountName: "username", applicationTag: "com.appname.key.private")
        //convert key data to string
        let string = NSString(data: rawPrivateKey!, encoding: NSUTF8StringEncoding)
        textToDisplay.text = string as? String
    }
    
    //save as password
    @IBAction func savePassword(sender: UIButton) {
        var textToSave = textField.text
        BHKeychainSwift.storeKeyOfType(BHKeychainSwift.BHKeychainKeyType.Password, keyData: textToSave, accountName: "username", applicationTag: "com.appname.user.password")
    }
    
    //retrieve password
    @IBAction func retrievePassword(sender: UIButton) {
        let dataPasscode = BHKeychainSwift.get(BHKeychainSwift.BHKeychainKeyType.Password, accountName: "username", applicationTag: "com.appname.user.password")
        
        let string = NSString(data: dataPasscode!, encoding: NSUTF8StringEncoding)
        textToDisplay.text = string as? String
    }


}

