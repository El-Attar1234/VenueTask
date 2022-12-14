//
//  BaseView.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import SwiftMessages
import MBProgressHUD

protocol BaseView {
    func showIndicator()
    func hideIndicator()
    func showMessage(message: String, type: AlretMessageType)
}

enum AlretMessageType {
    case success
    case error
}

class BaseVC: UIViewController {
    
    private var loadingView: MBProgressHUD!
    private var baseViewModel: BaseViewModelProtocol!
    
    init(baseViewModel: BaseViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.baseViewModel = baseViewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.setupNavBar()
        dismissKeyBoard()
        self.setupBindings()
    }
    
    private func dismissKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
  
    private func setupBindings() {
        
        baseViewModel.showLoader = { [weak self]  in
            guard let self = self else { return }
            self.showIndicator()
        }
        baseViewModel.hideLoader = { [weak self]  in
            guard let self = self else { return }
            self.hideIndicator()
        }
        
        baseViewModel.showMessage = { [weak self] (message, type) in
            guard let self = self else { return }
            self.showMessage(message: message, type: type)
        }
        
    }
    
}

extension BaseVC: BaseView {
    func showMessage(message: String, type: AlretMessageType) {
        switch type {
        case .success:
            self.showSucessMessage(message: message)
        case .error:
            self.showError(message: message)
        }
    }
    
    func showIndicator() {
        if loadingView != nil {
            loadingView = nil
        }
        loadingView = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingView.mode = MBProgressHUDMode.indeterminate
    }
    
    func hideIndicator() {
        if loadingView != nil {
            loadingView.hide(animated: true)
            loadingView = nil
        }
    }
}
extension BaseVC {
 private func showError(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.button?.isHidden = true
        view.configureTheme(.error)
        view.configureDropShadow()
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        view.configureContent(title: "", body: message)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        SwiftMessages.show(config: config, view: view)
    }
    
   private func showSucessMessage(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.button?.isHidden = true
        view.configureTheme(.success)
        view.configureDropShadow()
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        view.configureContent(title: "", body: message)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        SwiftMessages.show(config: config, view: view)
    }
}
