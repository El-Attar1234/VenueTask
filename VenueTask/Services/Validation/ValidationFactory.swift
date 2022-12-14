//
//  ValidationFactory.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation

import Foundation

// MARK: - ValidatorType
enum ValidatorType {
    case firstName
    case lastName
    case email
    case age
    case password
}

// MARK: - ValidatorConvertible
protocol ValidatorConvertible {
    @discardableResult
    func validated(value: String) throws -> String
}

// MARK: - ValidatorError
class ValidationError: LocalizedError {
    
    var message: String
    
    var errorDescription: String? {
        return message
    }
    
    init(_ message: String) {
        self.message = message
    }
}

// MARK: - VaildatorFactory
enum ValidatorFactory {
    
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .firstName: return FirstNameValidator()
        case .lastName: return LastNameValidator()
        case .age: return AgeValidator()
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    
    func validated(value: String) throws -> String {
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let isValid = emailPredicate.evaluate(with: value)
        if isValid {
            return value
        } else {
            throw ValidationError("Email Should be Valid")
        }
    }
    
}
struct AgeValidator: ValidatorConvertible {
    
    func validated(value: String) throws -> String {
        // Regex ehic restricts password to 8 character minimum, 1 lowercase letter or upper case, 1 number, 1 special char
        //            let passwordFormat   = "(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]||.*[A-Z]).{8,}"
        let age   = Int(value) ?? 0
        let isValid = age >= 18
        if isValid {
            return value
        } else {
            throw ValidationError("Age Should be equal 18 or above")
        }
    }
}
struct FirstNameValidator: ValidatorConvertible {
    
    func validated(value: String) throws -> String {
        let isValid = value.count >= 3
        if isValid {
            return value
        } else {
            throw ValidationError("First Name must be equal or more than three chars")
        }
    }
}
struct LastNameValidator: ValidatorConvertible {
    
    func validated(value: String) throws -> String {
        let isValid = value.count >= 3
        if isValid {
            return value
        } else {
            throw ValidationError("Last Name must be equal or more than three chars")
        }
    }
}
struct PasswordValidator: ValidatorConvertible {
    
    func validated(value: String) throws -> String {
        // Regex ehic restricts password to 8 character minimum, 1 lowercase letter or upper case, 1 number, 1 special char
        //            let passwordFormat   = "(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]||.*[A-Z]).{8,}"
        let passwordFormat         = "(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]||.*[A-Z]).{8,}"
        let passwordPredicate      = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        let isValid = passwordPredicate.evaluate(with: value)
        if isValid {
            return value
        } else {
            throw ValidationError("Password should be 8 characters long with Alphanumeric and Special Characters")
        }
    }
    
}
