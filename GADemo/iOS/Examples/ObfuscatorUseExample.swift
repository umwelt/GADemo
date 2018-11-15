//
//  ObfuscatorUseExample.swift
//  GADemo
//
//  Created by BMGH SRL on 15/11/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation


class ObfuscatorUseExample {
    
    func secureAndRetrieveData()  {
        
        let storable = SecureWrapper()

        let restoreToken = storable.storeValue("umwelt.hugo@gmail.com")

        
        if let _restoreToken = restoreToken {
            let restores = storable.restoreValue(_restoreToken)
        }
        
        
    }
   
    
}
