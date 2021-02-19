//
//  ErrorDetectionModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 19.02.2021.
//

import Foundation

class ErrorDetectionModel {
    private init() {}
    static var model = ErrorDetectionModel()
    
    var error = ErrorManager()
}

struct ErrorManager {
    
    var errorNumber: Bool = false { didSet {currentError = .errorNumber} }
    var invalidUnd: Bool = false { didSet {currentError = .invalidUnd} }
    var invalidTen: Bool = false { didSet {currentError = .invalidTen} }
    
    private enum typeOfErrors {
        case errorNumber
        case invalidUnd
        case invalidTen
        case non
    }
    
    private let stringError: [typeOfErrors: String] = [.errorNumber: "Число введено неверно", .invalidUnd: "Недопустимое 'und'", .invalidTen: "Ошибка десятка"]
    
    private var currentError: typeOfErrors = .non
    
    func getStringError() -> String? {
        guard currentError != .non, let stringError = stringError[currentError] else { return nil }
        return stringError
    }
}


