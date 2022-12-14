//
//  LoginVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class LoginVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var showPasswordButton: UIButton!
    @IBOutlet private weak var emailTF: UITextField!
    
    // MARK: - Outlets
    weak var viewModel: LoginViewModelProtocol!
    var isSecurePassword = true
    
    // MARK: - ViewLifeCycle
    init(viewModel: LoginViewModelProtocol) {
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
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func showHidePassword(_ sender: Any) {
        isSecurePassword.toggle()
        if isSecurePassword {
            showPasswordButton.setImage(Asset.Images.show.image, for: .normal)
        } else {
            showPasswordButton.setImage(Asset.Images.hide.image, for: .normal)
        }
        passwordTF.isSecureTextEntry = isSecurePassword
    }
    
    @IBAction func loginActionTapped(_ sender: Any) {
        do {
            print(passwordTF.text ?? "")
            _ = try validateEmail()
            _ = try validatePassword()
            
            let email = emailTF.text ?? ""
            let password = passwordTF.text ?? ""
            viewModel.login(email: email,
                            password: password)
            
        } catch {
            self.showMessage(message: error.localizedDescription, type: .error)
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let signUpVC = SceneContainer.signUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
extension LoginVC {
    func setupBinding() {
        viewModel.onSuccessLogIned = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let homeVc = SceneContainer.embedVCInNavController(SceneContainer.getHomeVc())
                AppManager.shared.setRootView(viewController: homeVc)
                
            }
            
        }
    }
    func validateEmail() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .email)
            .validated(value: emailTF.text ?? "")
        return valid
    }
    func validatePassword() throws -> String {
        let valid = try ValidatorFactory
            .validatorFor(type: .password)
            .validated(value: passwordTF.text ?? "")
        return valid
    }
}

