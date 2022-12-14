//
//  SignUpVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class SignUpVC: BaseVC {

    @IBOutlet private weak var firstNameTF: UITextField!
    @IBOutlet private weak var lastNameTF: UITextField!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var ageTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var confirmationPasswordTF: UITextField!

    weak var viewModel: SignUpViewModelProtocol!
    
    init(viewModel: SignUpViewModelProtocol) {
        super.init(baseViewModel: viewModel)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        do {
            _ = try validateFirstUserName()
            _ = try validateLastUserName()
            _ = try validateEmail()
            _ = try validateAge()
            _ = try validatePassword()

        } catch {
            self.showMessage(message: error.localizedDescription, type: .error)
        }
    }
    
}

extension SignUpVC {
    
    func validateFirstUserName() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .name)
            .validated(value: firstNameTF.text ?? "")
        return valid
    }
    func validateLastUserName() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .name)
            .validated(value: lastNameTF.text ?? "")
        return valid
    }
    
    func validateEmail() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .email)
            .validated(value: emailTF.text ?? "")
        return valid
    }
    func validateAge() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .age)
            .validated(value: ageTF.text ?? "")
        return valid
    }
    func validatePassword() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .password)
            .validated(value: passwordTF.text ?? "")
        return valid
    }
 
}
