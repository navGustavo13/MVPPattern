//
//  Prenter.swift
//  MVPDesignPattern
//
//  Created by gustavo.salazar on 25/05/22.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject{
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter{
    weak var delegate: PresenterDelegate?
    
    public func getUsers(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.delegate?.presentUsers(users: users)
            }
            catch{
                print(error)
            }
            
        })
        
        task.resume()
    }
    
    public func SetViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    public func didTap(user: User){
      /*  delegate?.presentAlert(title: user.name, message: "\(user.name) has an email of \(user.email) & a username of \(user.username) ")*/
        let title = user.name
        let message = "\(user.name) has an email of \(user.email) & a username of \(user.username)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",style: .cancel,handler: nil))
        delegate?.present(alert,animated:true)
    }
}
