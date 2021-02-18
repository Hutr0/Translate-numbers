//
//  ViewModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

class ViewModel {
    
    var numberModel: NumberModel?
    

    func startTranslating(_ string: String) {
        if string.lowercased().contains("hundert") {
            
            numberModel = NumberModel()
            let checkHundreds = CheckHundreds()
            let checkTens = CheckTens()
            let checkUnits = CheckUnits()
            
            var word: [Character] = []
            var previousWord: [Character] = []
            var previousCharacter: Character = " "
            var index: Int = 0
            
            for character in string {
                if character != " " {
                    
                    // Пофиксить 101
                    // Пофиксить не подряд идущие символы
                    
                    word.append(character)
                }
                if character == " " || index == string.count - 1 {
                    if previousCharacter != " " {
                        
                        if checkHundreds.checked == false {
                            let result = checkHundreds.checkHundreds(word, numberModel!)
                            if result != nil {
                                numberModel!.currentHundred = result
                            }
                            if checkHundreds.isHundred == false && String(word).lowercased() == "hundert" {
                                let result = checkHundreds.checkUnitHundreds(previousWord, numberModel!)
                                if result != nil {
                                    numberModel!.currentHundred = result
                                }
                            }
                        } else {
                            if checkUnits.checked == false && checkTens.uniqueChecked == false {
                                let result = checkTens.checkUniqueTens(word: word, numberModel!)
                                if result != nil {
                                    numberModel!.currentTen = result
                                }
                            }
                            if checkTens.checked == false && String(word).lowercased() == "und" {
                                let result = checkUnits.checkUnits(previousWord: previousWord, numberModel!)
                                if result != nil {
                                    numberModel!.currentUnit = result
                                }
                            }
                        }
                        
                        if checkTens.isUniqueTen == false && checkUnits.checked == true && String(word).lowercased() == "zig" {
                            let result = checkTens.checkTens(previousWord: previousWord, numberModel!)
                            if result != nil {
                                numberModel!.currentTen = result
                            }
                        }
                        previousWord = word
                        word = []
                    }
                }
                previousCharacter = character
                index += 1
            }
            print("\(numberModel!.currentHundred ?? -1) : \(numberModel!.currentTen ?? -1) : \(numberModel!.currentUnit ?? -1)")
            // ОШИБКА
        }
    }
}
