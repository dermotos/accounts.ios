//
//  AccountTypes.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

public enum Currency : RawRepresentable, CustomStringConvertible {
    
    case euro
    case usDollar
    // Limting to two currencies for the sake of brevity
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "EUR": self = .euro
        case "USD": self = .usDollar
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .euro: return "EUR"
        case .usDollar: return "USD"
        }
    }
    
    public var description: String {
        switch self {
        case .euro: return "Euro"
        case .usDollar: return "US Dollar"
        }
    }
}

public enum AccountType: RawRepresentable, CustomStringConvertible {
    
    case payment
    case saving
    case creditCard
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "PAYMENT": self = .payment
        case "SAVING": self = .saving
        case "CREDITCARD" : self = .creditCard
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .payment: return "PAYMENT"
        case .saving: return "SAVING"
        case .creditCard: return "CREDITCARD"
        }
    }
    
    public var description: String {
        switch self {
        case .payment: return "Payment Account"
        case .saving: return "Saving Account"
        case .creditCard: return "Credit Card"
        }
    }
}


public enum AccountProviderError : Error {
    case loadingError(String?)
    case parsingError(String?)
}

typealias AccountProviderResult = (Bool, AccountProviderError?, [AccountProtocol]?) -> ()
