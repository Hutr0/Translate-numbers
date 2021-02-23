//
//  ViewModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

class ViewModel {
    
    var resultString: String = ""
    
    func getNumber(_ string: String) {
        if string.lowercased().contains("hundert") {
            
            var numberModel = NumberModel()
            let checkHundreds = CheckHundreds()
            let checkTens = CheckTens()
            let checkUnits = CheckUnits()
            
            var word: [Character] = []
            var previousWord: [Character] = []
            var previousCharacter: Character = " "
            var index: Int = 1
            var check: Bool?
            
            for character in string {
                if character != " " {
                    word.append(character)
                }
                if character == " " || index == string.count {
                    if previousCharacter != " " {
                        
                        if checkHundreds.checked == false {
                            let result = checkHundreds.checkHundreds(word)
                            if result != nil {
                                numberModel.currentHundred = result
                                check = true
                            }
                            if checkHundreds.isHundred == false && String(word).lowercased() == "hundert" {
                                let result = checkHundreds.checkUnitHundreds(previousWord)
                                if result != nil {
                                    numberModel.currentHundred = result
                                    check = true
                                }
                                //                                if checkHundreds.isUnitHundred != true {
                                //                                    numberModel.currentHundred = 100
                                //                                    checkHundreds.checked = true
                                //                                    check = true
                                //                                    continue
                                //                                }
                            }
                        } else {
                            // Один раз проверяет уникальный десяток 
                            if checkUnits.checked == false && checkTens.uniqueChecked == false {
                                let result = checkTens.checkUniqueTens(word: word)
                                if result != nil {
                                    numberModel.currentTen = result
                                    numberModel.isUniqueTen = true
                                    check = true
                                }
                            }
                            
                            if checkTens.checked == false && String(word).lowercased() == "und" {
                                let result = checkUnits.checkUnits(previousWord: previousWord)
                                if result != nil {
//                                    if index == string.count {
//                                        // MARK: ОШИБКА недопустимая 'und'
//                                        ErrorDetectionModel.model.error.invalidUnd = true
//                                        return
//                                    }
                                    numberModel.currentUnit = result
                                    check = true
                                }
                            } else if checkTens.checked == false && checkUnits.checked == false && index == string.count { // Переделать index
                                let result = checkUnits.checkUnits(previousWord: word)
                                if result != nil {
                                    numberModel.currentUnit = result
                                    numberModel.isUniqueUnit = true
                                    check = true
                                }
                            }
                        }
                        
                        if checkTens.isUniqueTen == false && String(word).lowercased() == "zig" {
                            let result = checkTens.checkTens(previousWord: previousWord)
                            if result != nil {
                                numberModel.currentTen = result
                                check = true
                            }
                        }
                        
//                        if previousWord == [] && checkHundreds.checked != true {
//                            check = false
//                        } else if checkHundreds.isUnitHundred == true ||
//                                    (String(previousWord).lowercased().contains("hundert") && checkHundreds.checked == true) ||
//                                    (String(previousWord).lowercased() == "und" && checkUnits.checked == true) {
//                            check = false
//                        }
//                        if check == nil && String(word).lowercased() != "hundert" && String(word).lowercased() != "und" && String(word).lowercased() != "zig" {
//                            // MARK: ОШИБКА неразрешённое слово
//                            ErrorDetectionModel.model.error.unresolvedWord = true
//                            return
//                        }
                        
                        previousWord = word
                        word = []
                    }
                }
                
//                if previousCharacter == " " && character != " " {
//                    if String(previousWord).lowercased() == "zig" {
//                        // MARK: ОШИБКА after zig
//                        ErrorDetectionModel.model.error.afterZig = true
//                        return
//                    } else if numberModel.isUniqueTen == true && String(previousWord).lowercased() == String(checkTens.uniqueTen).lowercased() {
//                        // MARK: ОШИБКА after uniqueTen
//                        ErrorDetectionModel.model.error.invalidAfterTen = true
//                        return
//                        // Ошибка previousWord, потому что если будет 2 лишних символа, то будет ошибка
//                    } else if numberModel.isUniqueUnit == true && String(previousWord).lowercased() == String(checkUnits.uniqueUnit).lowercased() {
//                        // MARK: ОШИБКА after uniqueUnit
//                        ErrorDetectionModel.model.error.invalidAfterUnit = true
//                        return
//                }
//            }
            
            previousCharacter = character
            index += 1
            check = nil
        }
        print("\(numberModel.currentHundred ?? -1) : \(numberModel.currentTen ?? -1) : \(numberModel.currentUnit ?? -1)")
        
        //            if numberModel.isUniqueHundred == true && previousWord != [] && index == string.count {
        //                ErrorDetectionModel.model.error.invalidHundert = true
        //                return
        //            }
        //
        //            if numberModel.isUniqueTen != true && numberModel.isUniqueUnit != true && numberModel.isUniqueHundred != true && index == string.count {
        //                if numberModel.currentUnit == nil {
        //                    // MARK: ОШИБКА unit
        //                    ErrorDetectionModel.model.error.invalidUnit = true
        //                    return
        //                }
        //                if numberModel.currentTen == nil {
        //                    // MARK: ОШИБКА ten
        //                    ErrorDetectionModel.model.error.invalidTen = true
        //                    return
        //                }
        //            }
        
        translateNumber(numberModel)
    } else {
    // MARK: ОШИБКА hundert
    ErrorDetectionModel.model.error.invalidHundert = true
    return
    }
}

private func translateNumber(_ num: NumberModel) {
    
    let array = ExampleModel()
    
    let startHundred = num.currentHundred
    let startTen = num.currentTen
    let startUnit = num.currentUnit
    
    for hundred in array.hundredsRus {
        if startHundred == hundred.key {
            resultString = hundred.value
        }
    }
    
    if num.isUniqueUnit == true {
        for unit in array.unitsRus {
            if startUnit == unit.key {
                resultString.append(" " + unit.value)
            }
        }
    } else {
        if num.isUniqueTen != true {
            for ten in array.tensRus {
                if startTen == ten.key {
                    resultString.append(" " + ten.value)
                }
            }
            for unit in array.unitsRus {
                if startUnit == unit.key {
                    resultString.append(" " + unit.value)
                }
            }
        } else {
            if startTen == nil { return }
            
            let stringValue = String(startTen!)
            let tenValue = stringValue[stringValue.startIndex].toString.toInt * 10
            let unitValue = stringValue[stringValue.index(after: stringValue.startIndex)].toString.toInt
            
            for ten in array.tensRus {
                if tenValue == ten.key {
                    resultString.append(" " + ten.value)
                }
            }
            for unit in array.unitsRus {
                if unitValue == unit.key {
                    resultString.append(" " + unit.value)
                }
            }
        }
    }
}
}

extension String {
    var toInt: Int { return Int(self)! }
}

extension Character {
    var toString: String { return String(self) }
}

