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
    // Limting to single currency for the sake of the example
    
    public typealias RawValue = String
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "EUR": self = .euro
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .euro: return "EUR"
        }
    }
    
    public var description: String {
        switch self {
        case .euro: return "Euro"
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
        case .payment: return "Payment"
        case .saving: return "Saving"
        case .creditCard: return "Credit Card"
        }
    }
}


public enum AccountProviderError : Error {
    case loadingError(String?)
    case parsingError(String?)
}

public typealias AccountProviderResult = (Bool, AccountProviderError?, [AccountProtocol]?) -> ()
