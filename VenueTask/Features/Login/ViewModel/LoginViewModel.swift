//
//  LoginViewModel.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation
import CoreData

protocol LoginViewModelProtocol: AnyObject, BaseViewModelProtocol {
    var onSuccessLogIned: (() -> Void)? { get set }
    
    func login(email: String,
               password: String)
}
class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    var onSuccessLogIned: (() -> Void)?
    
    // MARK: - Properties
    lazy var coreDataStack = CoreDataStack(modelName: "VenueTask")
    
    func login(email: String,
               password: String) {
        if isValidUser(email: email, password: password) {
            PersistenceManager.save(email: email)
            PersistenceManager.authenticated(value: true)
            self.showMessage?("User Logined Successfully", .success)
            onSuccessLogIned?()
            
        }
        
    }
    func isValidUser(email: String, password: String) -> Bool {
        self.showLoader?()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let emailPredicate = NSPredicate(format: "email == %@", email)
        let passwordPredicate = NSPredicate(format: "password == %@", password)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [emailPredicate, passwordPredicate])
        
        do {
            let savedCount = try coreDataStack.managedContext.count(for: fetchRequest)
            if savedCount == 0 {
                self.hideLoader?()
                self.showMessage?("Email or Password Not Valid", .error)
                return false
            } else {
                self.hideLoader?()
                return true
            }
            
        } catch let error as NSError {
            self.hideLoader?()
            self.showMessage?("Error fetching: \(error), \(error.userInfo)", .error)
        }
       return true
    }
    
}
