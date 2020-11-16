//
//  LoginVC.swift
//  AcmeTrading
//
//  Created by Zivato Limited on 15/11/2020.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var alertMessage: UITextView!
    @IBOutlet var userNameLbl: UITextField!
    @IBOutlet var passwordLbl: UITextField!
    
    

    
    @IBAction func login(_ sender: Any) {
        userLogin(username: userNameLbl.text ?? "", password: passwordLbl.text ?? "")
    }
    
    func showAlertResponse(isError: Bool, message: String) {
        
        DispatchQueue.main.async { // UIView.alpha must be used from main thread only
            self.alertMessage.alpha = 1
            self.alertMessage.text = message
        
        if isError {
            self.alertMessage.backgroundColor = Constants.Interface.errorRed
        } else {
            self.alertMessage.backgroundColor = Constants.Interface.successGreen
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.3) {
                self.alertMessage.alpha = 0
            }
            
            if !isError {
                
                self.performSegue(withIdentifier: "goToList", sender: self)

            }
        }
        }
    }
    
    func userLogin(username: String, password: String) {
        
        let validUsername = LoginValidator().isUserNameValid(username: username)
        let validPassword = LoginValidator().isUserNameValid(username: username)
        
        
        
        var validCredentials = false
        if validUsername && validPassword {
            validCredentials = true
        } else {
            validCredentials = false
        }

        if validCredentials {
        
        let params = ["username":username, "password":password] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: Constants.API.dummyLogin)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                   
                        if httpResponse.statusCode == 200 {
                            
                                if let results = json["data"] as? [String:Any] {
                                                                        
                                    if let authToken = results["auth_token"] as? String {
                                        if let refreshToken = results["refresh_token"] as? String {
                                            if let successMessage = results["user_message"] as? String {
                                                Constants.User.authToken = authToken
                                                Constants.User.refreshToken = refreshToken
                                                print(successMessage)
                                                //success login
                                                self.showAlertResponse(isError: false, message: successMessage)
                                                
                                            }
                                        }
                                    }
                                }
                            } else {
                                
                                if let results = json["data"] as? [String:Any] {
                                    print(results)
                                    
                                    if let errorMessage = results["user_message"] as? String {

                                        print(errorMessage)
                                        //display error message
                                        self.showAlertResponse(isError: true, message: errorMessage)

                                    }
                                }
                                
                            }
                    }
                }
                    
            } catch {
                print("error")
            }
            
        })
        
        task.resume()
            
        } else {
            
            if !validUsername {
            self.showAlertResponse(isError: true, message: "Your username is invalid")
            } else if !validPassword {
            self.showAlertResponse(isError: true, message: "Your password is invalid")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        userNameLbl.setLeftPaddingPoints(Constants.Interface.textfeldInset)
        passwordLbl.setLeftPaddingPoints(Constants.Interface.textfeldInset)
        alertMessage.textContainerInset = UIEdgeInsets(top: Constants.Interface.textfeldInset, left: Constants.Interface.textfeldInset, bottom: Constants.Interface.textfeldInset, right: Constants.Interface.textfeldInset)
        

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
