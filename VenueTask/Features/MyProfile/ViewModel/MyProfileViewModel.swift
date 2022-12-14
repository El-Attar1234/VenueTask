//
//  MyProfileViewModel.swift
//  VenueTask
//
//  Created by Ibtikar on 15/12/2022.
//

import CoreData
enum MyOwnProfileItems: Int, CaseIterable {
    
    static var allItems: [MyOwnProfileItems] = MyOwnProfileItems.allCases.map({ $0 })
    
    case fullName
    case age
    case email
    
    func title() -> String {
        switch self {
        case .fullName:
            return "Full Name:"
        case .age:
            return "Age:"
        case .email:
            return "Email:"
        }
    }
}

protocol MyProfileViewModelProtocol: AnyObject, BaseViewModelProtocol {
    
    var onSuccessFetching: ((User) -> Void)? { get set }
    
    func viewDidLoad()
}
class MyProfileViewModel: BaseViewModel, MyProfileViewModelProtocol {
    var onSuccessFetching: ((User) -> Void)?
    
    // MARK: - Properties
    lazy var coreDataStack = CoreDataStack(modelName: "VenueTask")
    
    func viewDidLoad() {
        self.showLoader?()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let savedEmail = PersistenceManager.getUserEmail() ?? ""
        fetchRequest.predicate = NSPredicate(format: "email == %@", savedEmail)
        do {
            let savedUser = try coreDataStack.managedContext.fetch(fetchRequest)[0]
            self.hideLoader?()
            self.onSuccessFetching?(savedUser)
            
        } catch let error as NSError {
            self.hideLoader?()
            self.showMessage?("Error fetching: \(error), \(error.userInfo)", .error)
        }
    }
}
