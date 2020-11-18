//
//  ProfileListVC.swift
//  AcmeTrading
//
//  Created by Zivato Limited on 15/11/2020.
//


import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var distanceAway: UILabel!
    @IBOutlet var cellHolderBg: UIView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var starRating: UILabel!
}

class ProfileListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var profileListItems = [ProfileListItem]()
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var rowHeight = 193.0
        
        if indexPath.row == 0 {
            rowHeight = 253.0
        } else {
            rowHeight = 193.0
        }
        
        return CGFloat(rowHeight)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.profileListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var reuseIdentifier = "cell"
        if indexPath.row == 0 {
            reuseIdentifier = "topCell"
        } else {
            reuseIdentifier = "cell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        
        cell.cellHolderBg.layer.borderWidth = 0.2
        cell.cellHolderBg.layer.borderColor = UIColor.darkGray.cgColor
        
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOpacity = 0.5
        cell.shadowView.layer.shadowOffset = CGSize.zero
        cell.shadowView.layer.shadowRadius = 10
        
        cell.titleLbl.text = ""
        cell.distanceAway.text = ""
        cell.profileImage.image = nil
        
        let title = self.profileListItems[indexPath.row].name
        cell.titleLbl.text = title
        
        let distance = self.profileListItems[indexPath.row].distanceFromUser
        cell.distanceAway.text = distance
        
        let starLevel = self.profileListItems[indexPath.row].starLevel
        let starEmoji = self.getStars(value: starLevel)
        
        let numRatings = self.profileListItems[indexPath.row].numRatings
        cell.starRating.text = "\(starEmoji)" + " (" + "\(numRatings))"
        
        let imageURLStr = self.profileListItems[indexPath.row].profileImageUrl
        if let imageURL = URL(string: imageURLStr) {
            cell.tag = indexPath.row
            let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    if cell.tag == indexPath.row{
                        cell.profileImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    func getProfiles(authToken: String) {
        
        var request = URLRequest(url: URL(string: Constants.API.dummyProfileList)!)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        
                        if httpResponse.statusCode == 200 {
                            
                            if let results = json["data"] as? [String:Any] {
                                
                                
                                
                                if let profiles = results["profiles"] as? [[String:Any]] {
                                    print(profiles)
                                    for profile in profiles {
                                        guard let name = profile["name"] else {
                                            return
                                        }
                                        
                                        guard let star = profile["star_level"] else {
                                            return
                                        }
                                        
                                        guard let distance = profile["distance_from_user"] else {
                                            return
                                        }
                                        
                                        guard let numRatings = profile["num_ratings"] else {
                                            return
                                        }
                                        
                                        guard let profileImgUrl = profile["profile_image"] else {
                                            return
                                        }
                                        
                                        let listItem = ProfileListItem()
                                        listItem.name = name as! String
                                        listItem.starLevel = star as! Int
                                        listItem.distanceFromUser = distance as! String
                                        listItem.numRatings = numRatings as! Int
                                        listItem.profileImageUrl = profileImgUrl as! String
                                        self.profileListItems.append(listItem)
                                        
                                        if self.profileListItems.count == results.count {
                                            DispatchQueue.main.async {
                                                self.profileListItems = self.profileListItems.sorted { $0.starLevel > $1.starLevel }
                                                
                                                self.tableView.reloadData()
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                            }
                        } else {
                            
                            if let results = json["data"] as? [String:Any] {
                                
                                if let errorMessage = results["user_message"] as? [String:Any] {
                                    
                                    if let message = errorMessage["message"] as? String {
                                        
                                        print(errorMessage)
                                        self.showErrorAlert(errorMessage: message)
                                    }
                                    
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getProfiles(authToken: Constants.User.authToken)
        addLogoToNav()
        
    }
    
    func getStars(value: Int) -> String{
        var stars = ""
        
        let starLevel = value
        
        if starLevel == 1 {
            stars = "⭐"
        } else if starLevel == 2 {
            stars = "⭐⭐"
        } else if starLevel == 3 {
            stars = "⭐⭐⭐"
        } else if starLevel == 4 {
            stars = "⭐⭐⭐⭐"
        } else if starLevel == 5 {
            stars = "⭐⭐⭐⭐⭐"
        }
        return stars
    }
    
    func addLogoToNav() {
        let logo = UIImage(named: "AcmeLogo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    func showErrorAlert(errorMessage: String) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.getProfiles(authToken: Constants.User.authToken)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

