//
//  Networkerror.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation
import Moya
import Alamofire

enum NetworkError: Error {
    case notConnected
    case cancelled
    case generic(Error)
    case clientError
    case unauthorized
    case serverResponseError
}

class ErrorHandling {
    
    static func resolve(error: Error) -> NetworkError {
        if let alamofireError = (error as? MoyaError)?.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError,
           let underlyingError = alamofireError.underlyingError as NSError?,
           [NSURLErrorNotConnectedToInternet, NSURLErrorDataNotAllowed].contains(underlyingError.code) {
            return .notConnected
        }
        print((error as NSError))
        print((error as NSError).code)
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet, .cannotConnectToHost, .networkConnectionLost: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
    static func resolve(statusCode: Int) -> NetworkError {

        switch statusCode {
            // Successful response
        case 401:
            return .unauthorized
        case 400...499:
            return .clientError
        case 500...599:
            return .serverResponseError
      
        default:
            return .cancelled
        }
    }
    
}
