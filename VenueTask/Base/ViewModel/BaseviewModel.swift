//
//  BaseviewModel.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation

protocol BaseViewModelProtocol {
    var showLoader: (() -> Void)? { get set }
    var hideLoader: (() -> Void)? { get set }
    var showMessage: ((String, AlretMessageType) -> Void)? { get set }
}

class BaseViewModel: BaseViewModelProtocol {
    var showLoader: (() -> Void)?
    var hideLoader: (() -> Void)?
    var showMessage: ((String, AlretMessageType) -> Void)?
}
