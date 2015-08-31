# BHKeychainSwift
A wrapper that contains helper functions for saving text and data in the keychain.

![ss](https://raw.githubusercontent.com/iPhonig/BHKeychainSwift/master/KeychainSwiftExample/ss.png)

Key Features
============

- Save and retrieve sensitive data such as public keys, private keys, and passwords to the keychain in Swift.
- Great for apps that work with API's and need to securely save user data.

Usage
============

- Add BHKeychainSwift to your project
- Call method on UIImageView or UIButton just like you would normally call any method.
- CocoaPods support coming soon!

```
//Save a public key 
BHKeychainSwift.storeKeyOfType(BHKeychainSwift.BHKeychainKeyType.Public, keyData: "text to save here", accountName: "enter account name or email for example", applicationTag: "com.appname.key.public")

//Retrieve public key
let rawPublicKey = BHKeychainSwift.get(BHKeychainSwift.BHKeychainKeyType.Private, accountName: "same account name that was used to save the key", applicationTag: "com.appname.key.public")
//convert keychain data to string
let string = NSString(data: rawPublicKey!, encoding: NSUTF8StringEncoding)
//unwrap string
var unwrappedString = string as? String
println("\(unwrappedString)")

//Same steps go for private keys!

//Save as password
BHKeychainSwift.storeKeyOfType(BHKeychainSwift.BHKeychainKeyType.Password, keyData: "password", accountName: "enter account name or email for example", applicationTag: "com.appname.user.password")

//Retrieve password
let dataPasscode = BHKeychainSwift.get(BHKeychainSwift.BHKeychainKeyType.Password, accountName: "username", applicationTag: "com.appname.user.password")
//convert keychain data to string like we did before 
let stringPass = NSString(data: dataPasscode!, encoding: NSUTF8StringEncoding)
//unwrap string
var unwrappedString = stringPass as? String
println("\(unwrappedString)")
