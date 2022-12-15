//
//  SignUpVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class SignUpVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet private weak var firstNameTF: UITextField!
    @IBOutlet private weak var lastNameTF: UITextField!
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var ageTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var confirmationPasswordTF: UITextField!
    @IBOutlet private weak var showHideConfirmationPasswordButton: UIButton!
    @IBOutlet private weak var showHidePasswordButton: UIButton!
    
    // MARK: - Properties
    weak var viewModel: SignUpViewModelProtocol!
    var isSecurePassword = true
    var isSecureConfirmationPassword = true
    
    // MARK: - ViewLifeCycle
    init(viewModel: SignUpViewModelProtocol) {
        super.init(baseViewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func showhidepasswordButtonTapped(_ sender: Any) {
        isSecurePassword.toggle()
        if isSecurePassword {
            showHidePasswordButton.setImage(Asset.Images.show.image, for: .normal)
        } else {
            showHidePasswordButton.setImage(Asset.Images.hide.image, for: .normal)
        }
        passwordTF.isSecureTextEntry = isSecurePassword
    }
    
    @IBAction func showhideConfirmationPasswordButtonTapped(_ sender: Any) {
        isSecureConfirmationPassword.toggle()
        if isSecureConfirmationPassword {
            showHideConfirmationPasswordButton.setImage(Asset.Images.show.image, for: .normal)
        } else {
            showHideConfirmationPasswordButton.setImage(Asset.Images.hide.image, for: .normal)
        }
        confirmationPasswordTF.isSecureTextEntry = isSecureConfirmationPassword
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        do {
            _ = try validateFirstUserName()
            _ = try validateLastUserName()
            _ = try validateEmail()
            _ = try validateAge()
            _ = try validatePassword()
            
            let password = passwordTF.text ?? ""
            let confirmPass = confirmationPasswordTF.text ?? ""
            
            if password == confirmPass {
                let firstName = firstNameTF.text ?? ""
                let lastName = lastNameTF.text ?? ""
                let email = emailTF.text ?? ""
                let age = ageTF.text ?? ""
                viewModel.signUp(firstName: firstName,
                                 lastName: lastName,
                                 email: email,
                                 age: age,
                                 password: password)
                
            } else {
                self.showMessage(message: "Confirm Password isn't identical to password", type: .error)
            }
            
        } catch {
            self.showMessage(message: error.localizedDescription, type: .error)
        }
    }
    
}

extension SignUpVC {
    
    func setupBinding() {
        viewModel.onSuccessSaving = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func validateFirstUserName() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .firstName)
            .validated(value: firstNameTF.text ?? "")
        return valid
    }
    func validateLastUserName() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .lastName)
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

