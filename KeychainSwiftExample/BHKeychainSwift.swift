// ----------------------------
//
// BHKeychainSwift.swift
// Created by Ben Honig of iPhonig
//
// ----------------------------

import UIKit
import Security
import LocalAuthentication

/**
A collection of helper functions for saving text and data in the keychain.
*/

public class BHKeychainSwift {
    
    public enum KeychainKeyType{
        case Public
        case Private
        case Password
    }
    
    /**
    Store Key
    
    - Parameters:
    - type: KeyKeyType such as Public, Private, Password
    - keyData: the text to store
    - accountName: the name of the user of the app usually
    - applicationTag: the identifying tag for the data e.g. 'com.appname.key.public'
    */
    public class func storeKeyOfType(type: KeychainKeyType, keyData: String, accountName: String, applicationTag: String) -> Bool{
        
        if type == KeychainKeyType.Public{
            generateQuery(KeychainKeyType.Public, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }else if type == KeychainKeyType.Private{
            generateQuery(KeychainKeyType.Private, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }else if type == KeychainKeyType.Password{
            generateQuery(KeychainKeyType.Password, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }
        
        return false
    }
    
    //gerneate the query for store or get
    private class func generateQuery(type: KeychainKeyType, keyData: String, accountName: String, applicationTag: String) -> Dictionary<String, AnyObject>{
        
        let keyDataAsData = keyData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) as NSData!
        
        if type == KeychainKeyType.Public{
            
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecValueData as String : keyDataAsData
            ]
            
            SecItemDelete(query as CFDictionaryRef)
            let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
            
            print("\(status == noErr)")
            
            return query
            
        }else if type == KeychainKeyType.Private{
            
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecValueData as String : keyDataAsData
            ]
            
            SecItemDelete(query as CFDictionaryRef)
            let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
            
            print("\(status == noErr)")
            
            return query
            
        }else{
            //password
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : accountName,
                kSecAttrService as String : applicationTag,
                kSecValueData as String   : keyDataAsData
            ]
            
            SecItemDelete(query as CFDictionaryRef)
            
            let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
            print("\(status == noErr)")
            
            return query
        }
    }
    
    /**
    Get Key
    
    - Parameters:
    - type: KeyKeyType such as Public, Private, Password
    - accountName: the name of the user of the app usually
    - applicationTag: the identifying tag for the data e.g. 'com.appname.key.public'
    */
    public class func get(type: KeychainKeyType, accountName: String, applicationTag: String) -> NSData?{
        
        if type == KeychainKeyType.Public{
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecReturnData as String : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne
            ]
            
            var retrievedData: NSData?
            var extractedData: AnyObject?
            let status = SecItemCopyMatching(query, &extractedData)
            
            if (status == errSecSuccess) {
                retrievedData = extractedData as? NSData
                return retrievedData!
            }
            
        }else if type == KeychainKeyType.Private{
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecReturnData as String : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne
            ]
            
            var dataTypeRef: AnyObject?
            
            let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
            
            if status == noErr {
                return (dataTypeRef as! NSData)
            } else {
                return nil
            }
            
        }else{
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : accountName,
                kSecAttrService as String : applicationTag,
                kSecReturnData as String  : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne ]
            
            var retrievedData: NSData?
            var extractedData: AnyObject?
            let status = SecItemCopyMatching(query, &extractedData)
            
            if (status == errSecSuccess) {
                retrievedData = extractedData as? NSData
                return retrievedData!
            }else{
                return nil
            }
        }
        return nil
    }
}