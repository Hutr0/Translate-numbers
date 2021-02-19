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
            var index: Int = 0
            
            for character in string {
                if character != " " {
                    word.append(character)
                }
                if character == " " || index == string.count - 1 {
                    if previousCharacter != " " {
                        
                        if checkHundreds.checked == false {
                            let result = checkHundreds.checkHundreds(word)
                            if result != nil {
                                numberModel.currentHundred = result
                            }
                            if checkHundreds.isHundred == false && String(word).lowercased() == "hundert" {
                                if index == string.count - 1 {
                                    numberModel.currentHundred = 100
                                    continue
                                }
                                let result = checkHundreds.checkUnitHundreds(previousWord)
                                if result != nil {
                                    numberModel.currentHundred = result
                                }
                            }
                        } else {
                            if checkUnits.checked == false && checkTens.uniqueChecked == false {
                                let result = checkTens.checkUniqueTens(word: word)
                                if result != nil {
                                    numberModel.currentTen = result
                                    numberModel.isUniqueTen = true
                                }
                            }
                            if checkTens.checked == false && String(word).lowercased() == "und" {
                                let result = checkUnits.checkUnits(previousWord: previousWord)
                                if result != nil {
                                    numberModel.currentUnit = result
                                }
                            } else if checkTens.checked == false && index == string.count - 1 {
                                let result = checkUnits.checkUnits(previousWord: word)
                                if result != nil {
                                    numberModel.currentUnit = result
                                    numberModel.isUniqueUnit = true
                                }
                            }
                        }
                        
                        if checkTens.isUniqueTen == false && checkUnits.checked == true && String(word).lowercased() == "zig" {
                            let result = checkTens.checkTens(previousWord: previousWord)
                            if result != nil {
                                numberModel.currentTen = result
                            }
                        }
                        previousWord = word
                        word = []
                    }
                }
                previousCharacter = character
                index += 1
            }
            print("\(numberModel.currentHundred ?? -1) : \(numberModel.currentTen ?? -1) : \(numberModel.currentUnit ?? -1)")
            // ОШИБКА
            
            translateNumber(numberModel)
        }
    }
    
    private func translateNumber(_ num: NumberModel) {
        
        let array = ArrayModel()
        
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
                // ОШИБКА
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

