//
//  Constants.swift
//  AcmeTrading
//
//  Created by Zivato Limited on 15/11/2020.
//

import Foundation
import UIKit


struct Constants {
    
    struct API {
        static let dummyLogin = "https://ho0lwtvpzh.execute-api.us-east-1.amazonaws.com/DummyLogin" //POST
        static let dummyProfileList = "https://ypznjlmial.execute-api.us-east-1.amazonaws.com/DummyProfileList" //GET
    }
    
    struct User {
        static var authToken = ""
        static var refreshToken = ""
    }
    
    struct Interface {
        static let textfeldInset: CGFloat = 16.0
        static let errorRed = UIColor(red: 190.0/255.0, green: 69.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        static let successGreen = UIColor(red: 103.0/255.0, green: 201.0/255.0, blue: 176.0/255.0, alpha: 1.0)
    }
    
    

    
}

class ProfileListItem {
    var name: String = ""
    var starLevel: Int = 0
    var distanceFromUser: String = ""
    var numRatings: Int = 0
    var profileImageUrl: String = ""
}


