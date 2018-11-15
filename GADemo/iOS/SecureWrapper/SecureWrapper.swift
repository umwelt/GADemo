//
//  SecureWrapper.swift
//  GADemo
//
//  Created by BMGH SRL on 14/11/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

// Defines types of hash string outputs available
public enum HashOutputType {
    // standard hex string output
    case hex
    // base 64 encoded string output
    case base64
}

// Defines types of hash algorithms available
public enum HashType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    
    var length: Int32 {
        switch self {
        case .md5: return CC_MD5_DIGEST_LENGTH
        case .sha1: return CC_SHA1_DIGEST_LENGTH
        case .sha224: return CC_SHA224_DIGEST_LENGTH
        case .sha256: return CC_SHA256_DIGEST_LENGTH
        case .sha384: return CC_SHA384_DIGEST_LENGTH
        case .sha512: return CC_SHA512_DIGEST_LENGTH
        }
    }
}



final class SecureWrapper {
    
    private var  cipher  = [UInt8]("2b49e346-ea62-4291-a407-086d6cdabc04".utf8)
    private var storedValue = [UInt8]()
    private var encrypted = [UInt8]()
    private var keyToken: SecuredToken!

    struct SecuredToken {
        let token: String!
        let validUntil: Double!
        let storedValue: [UInt8]!
    }
    
    private func secureToken(_ value: String) -> String? {
        
        let validUntil = Date(timeIntervalSinceNow: 30).timeIntervalSince1970
        let storedValue = encription(value: [UInt8](value.utf8))
        
        if let refreshToken = UUID().uuidString.hashed(.md5) {
            keyToken = SecuredToken(token: refreshToken, validUntil: validUntil, storedValue: storedValue)
            return refreshToken
        }
        
        return nil
        
    }
    
    private func encription(value: [UInt8]) -> [UInt8] {
        var encrypted = [UInt8]()
        // encrypt bytes
        for (i, t) in value.enumerated() {
            encrypted.append(t ^ cipher[i])
        }
        
        return encrypted
    }
    
    private func decryption() -> [UInt8] {
        var decrypted = [UInt8]()
        // decrypt bytes
        for (i, t) in keyToken.storedValue.enumerated() {
            decrypted.append(t ^ cipher[i])
        }
        
        return decrypted
    }
    
    private func isValidToken(keyToken: SecuredToken) -> Bool {
        return keyToken.validUntil > Date().timeIntervalSince1970
    }
    
    
    /// Public
    func storeValue(_ value: String) -> String? {
        return secureToken(value)
    }
    
    func restoreValue(_ token: String) -> String? {
        
        guard let _keyToken = keyToken else {
            /// token has expired
            return nil
        }
        
        if _keyToken.token != token {
             /// token does not match
            return nil
        }
        
        if isValidToken(keyToken: _keyToken) {
             return String(bytes: decryption(), encoding: String.Encoding.utf8)
        }
        
        return nil
        
    }
    

    

    


}
