// ----------------------------
//
// BHKeychainSwift.swift
// Created by Ben Honig of iPhonig
//
// ----------------------------

import UIKit
import Security


/**
A collection of helper functions for saving text and data in the keychain.
*/
public class BHKeychainSwift {
    
    public enum BHKeychainKeyType{
        case Public
        case Private
        case Password
    }
    
    public class func storeKeyOfType(type: BHKeychainKeyType, keyData: String, accountName: String, applicationTag: String) -> Bool{
        
        if type == BHKeychainKeyType.Public{
            generateQuery(BHKeychainKeyType.Public, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }else if type == BHKeychainKeyType.Private{
            generateQuery(BHKeychainKeyType.Private, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }else if type == BHKeychainKeyType.Password{
            generateQuery(BHKeychainKeyType.Password, keyData: keyData, accountName: accountName, applicationTag: applicationTag)
        }
        
        return false
    }
    
    //MARK: Generate Query
    class func generateQuery(type: BHKeychainKeyType, keyData: String, accountName: String, applicationTag: String) -> Dictionary<String, AnyObject>{
        
        var keyDataAsData = keyData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) as NSData!
        
        if type == BHKeychainKeyType.Public{
            
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecValueData as String : keyDataAsData
            ]
            
            SecItemDelete(query as CFDictionaryRef)
            let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
            
            println("\(status == noErr)")
            
            return query
            
        }else if type == BHKeychainKeyType.Private{

            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecValueData as String : keyDataAsData
            ]
            
            SecItemDelete(query as CFDictionaryRef)
            let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
            
            println("\(status == noErr)")
            
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
            println("\(status == noErr)")
            
            return query
        }
    }
    
    //MARK: Get Key
    public class func get(type: BHKeychainKeyType, accountName: String, applicationTag: String) -> NSData?{
        if type == BHKeychainKeyType.Public{
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecReturnData as String : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne
            ]
            
            var dataTypeRef :Unmanaged<AnyObject>?
            
            let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
            
            if status == noErr {
                return (dataTypeRef?.takeRetainedValue() as! NSData)
            } else {
                return nil
            }

        }else if type == BHKeychainKeyType.Private{
            let query = [
                kSecClass as String : kSecClassKey as String,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked as String,
                kSecAttrApplicationTag as String : applicationTag,
                kSecAttrApplicationLabel as String : accountName,
                kSecReturnData as String : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne
            ]
            
            var dataTypeRef :Unmanaged<AnyObject>?
            
            let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
            
            if status == noErr {
                return (dataTypeRef?.takeRetainedValue() as! NSData)
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
            
            var dataTypeRef :Unmanaged<AnyObject>?
            
            let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
            
            if status == noErr {
                return (dataTypeRef?.takeRetainedValue() as! NSData)
            } else {
                return nil
            }
        }
    }
}