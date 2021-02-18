//
//  ViewModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

class ViewModel {
    
    var numberModel = NumberModel()
    var checkHundreds = CheckHundreds()
    var checkTens = CheckTens()
    var checkUnits = CheckUnits()
    
    func startTranslating(_ string: String) {
        if string.lowercased().contains("hundert") {
            
            var word: [Character] = []
            var previousWord: [Character] = []
            var previousCharacter: Character?
            
            for character in string {
                if character != " " {
                    
                    // Пофиксить баг с пробелом
                    // Пофиксить баг с многократным использованием
                    // Пофиксить 101
                    // Пофиксить не подряд идущие символы
                    
                    word.append(character)
                } else {
                    if previousCharacter != " " && previousCharacter != nil {
                        
                        if checkHundreds.checked == false {
                            let result = checkHundreds.checkHundreds(word, numberModel)
                            if result != nil {
                                numberModel.currentHundred = result
                            }
                            if checkHundreds.isHundred == false && String(word).lowercased() == "hundert" {
                                let result = checkHundreds.checkUnitHundreds(previousWord, numberModel)
                                if result != nil {
                                    numberModel.currentHundred = result
                                }
                            }
                        } else {
                            if checkUnits.checked == false {
                                let result = checkTens.checkUniqueTens(word: word, numberModel)
                                if result != nil {
                                    numberModel.currentTen = result
                                }
                            }
                            if checkTens.checked == false && String(word).lowercased() == "und" {
                                let result = checkUnits.checkUnits(previousWord: previousWord, numberModel)
                                if result != nil {
                                    numberModel.currentUnit = result
                                }
                            }
                        }
                        
                        if checkTens.isUniqueTen == false && checkUnits.checked == true && String(word).lowercased() == "zig" {
                            let result = checkTens.checkTens(previousWord: previousWord, numberModel)
                            if result != nil {
                                numberModel.currentTen = result
                            }
                        }
                    }
                    previousWord = word
                    word = []
                }
                previousCharacter = character
            }
            print("\(numberModel.currentHundred ?? -1) : \(numberModel.currentTen ?? -1) : \(numberModel.currentUnit ?? -1)")
            // ОШИБКА
        }
    }
}

//    func checkNext(_ word: [Character], _ previousWord: [Character]) {
//        if String(word).lowercased() == "und" {
//            numberModel.currentUnit = unitModel.checkUnits(word, previousWord, numberModel)
//
//            // ОШИБКА
//        } else {
//            numberModel.currentTen = tenModel.checkTens(word, previousWord, numberModel)
//
//            // ОШИБКА
//        }
//    }
//
//    func checkCheckNext(_ word: [Character], _ previousWord: [Character]) {
//        if String(word).lowercased() == "zig" {
//            numberModel.currentTen = tenModel.checkCheckTens(word, previousWord, numberModel)
//        }
//    }
//}
