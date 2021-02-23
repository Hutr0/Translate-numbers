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
    
    var invalidUnit: Bool = false { didSet {currentError = .invalidUnit} }
    var invalidTen: Bool = false { didSet {currentError = .invalidTen} }
    var invalidHundert: Bool = false { didSet {currentError = .invalidHundert} }
    var invalidUnd: Bool = false { didSet {currentError = .invalidUnd} }
    var unresolvedWord: Bool = false { didSet {currentError = .unresolvedWord} }
    var afterZig: Bool = false { didSet {currentError = .afterZig} }
    var invalidAfterTen: Bool = false { didSet {currentError = .invalidAfterTen} }
    var invalidAfterUnit: Bool = false { didSet {currentError = .invalidAfterUnit} }
    
    private enum typeOfErrors {
        case invalidUnit
        case invalidTen
        case invalidHundert
        case invalidUnd
        case unresolvedWord
        case afterZig
        case invalidAfterTen
        case invalidAfterUnit
        case non
    }
    
    private let stringError: [typeOfErrors: String] = [.invalidUnit: "Единица введена неверно", .invalidTen: "Десяток введён неверно", .invalidHundert: "Сотня введена неверно", .invalidUnd: "Недопустимое 'und'", .unresolvedWord: "Число введено неверно", .afterZig: "Имеются симовлы после 'zig'", .invalidAfterTen: "Имеются симовлы после десятка", .invalidAfterUnit: "Имеются символы после единицы"]
    
    private var currentError: typeOfErrors = .non
    
    func getStringError() -> String? {
        guard currentError != .non, let stringError = stringError[currentError] else { return nil }
        return stringError
    }
}


