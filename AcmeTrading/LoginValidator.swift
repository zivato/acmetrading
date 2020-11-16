//
//  LoginValidator.swift
//  AcmeTrading
//
//  Created by Zivato Limited on 15/11/2020.
//

import Foundation

class LoginValidator {
    
    func isUserNameValid(username: String) -> Bool {
        var returnValue = true
        if username.isEmpty || username.count < 6 {
            returnValue = false
        }
        return returnValue
    }
    
    func isPasswordValid(password: String) -> Bool {
        var returnValue = true
        if password.isEmpty || password.count < 6 {
            returnValue = false
        }
        return returnValue
    }
    
}
