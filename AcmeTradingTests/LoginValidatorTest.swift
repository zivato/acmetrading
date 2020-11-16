//
//  LoginValidatorTest.swift
//  AcmeTradingTests
//
//  Created by Zivato Limited on 15/11/2020.
//

import XCTest
@testable import AcmeTrading

class LoginValidatorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginValidator_WhenValidUsername_ShouldReturnTrue() {
        
        //Arrange
        let sut = LoginValidator()
        
        //Act
        let isUsernameValid = sut.isUserNameValid(username: "benswift1")
        
        //Asset
        XCTAssertTrue(isUsernameValid, "isUserNameValid() should have returned TRUE for a valid username but returned FALSE")
    }
    
    func testLoginValidator_WhenValidPassword_ShouldReturnTrue() {
        
        //Arrange
        let sut = LoginValidator()
        
        //Act
        let isPasswordValid1 = sut.isPasswordValid(password: "password")
        
        //Asset
        XCTAssertTrue(isPasswordValid1, "isPasswordValid1: isPasswordValid() should have returned TRUE for a valid password but returned FALSE")
       
    }

}
