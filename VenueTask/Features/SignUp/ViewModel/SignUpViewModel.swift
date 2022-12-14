//
//  SignUpViewModel.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation
import CoreData

protocol SignUpViewModelProtocol: AnyObject, BaseViewModelProtocol {
    var onSuccessSaving: (() -> Void)? { get set }
    
    func signUp(firstName: String,
                lastName: String,
                email: String,
                age: String,
                password: String)
}
class SignUpViewModel: BaseViewModel, SignUpViewModelProtocol {
    var onSuccessSaving: (() -> Void)?
    
    // MARK: - Properties
    lazy var coreDataStack = CoreDataStack(modelName: "VenueTask")
    
    func signUp(firstName: String,
                lastName: String,
                email: String,
                age: String,
                password: String) {
        if !isExistUser(email: email) {
            let user = User(context: coreDataStack.managedContext)
            user.firstName = firstName
            user.lastName = lastName
            user.age = age
            user.email = email
            user.password = password
            coreDataStack.saveContext()
            self.hideLoader?()
            self.showMessage?("User Saved Successfully", .success)
            onSuccessSaving?()
            
        }
        
    }
    func isExistUser(email: String) -> Bool {
        self.showLoader?()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let savedCount = try coreDataStack.managedContext.count(for: fetchRequest)
            if savedCount == 0 {
                return false
            } else {
                self.hideLoader?()
                self.showMessage?("User Already exists", .error)
                return true
            }
            
        } catch let error as NSError {
            self.hideLoader?()
            self.showMessage?("Error fetching: \(error), \(error.userInfo)", .error)
        }
       return true
    }
    
}
