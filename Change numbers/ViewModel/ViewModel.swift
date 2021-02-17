//
//  ViewModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

class ViewModel {
    
    var numberModel = NumberModel()
    
    var hunderedModel = HundredModel()
    var tenModel = TenModel()
    var unitModel = UnitModel()
    
    func startTranslating(_ string: String) {
        if string.lowercased().contains("hundert") {
            
            hunderedModel = HundredModel()
            
            var word: [Character] = []
            var previousWord: [Character] = []
            var previousCharacter: Character?
                
            for character in string {
                if character != " " {
                    
                    // Пофиксить баг с пробелом
                    
                    word.append(character)
                } else {
                    if previousCharacter != " " && previousCharacter != nil {
                        
                        if hunderedModel.checked == false {
                            
                            if hunderedModel.isHundred == false {
                                numberModel.currentHundred = hunderedModel.checkHundreds(word, numberModel)
                            }
                            
                            if hunderedModel.isHundred == false && String(word).lowercased() == "hundert" {
                                numberModel.currentHundred = hunderedModel.checkUnitHundreds(previousWord, numberModel)
                            }
                        }
                        
                        if hunderedModel.isHundred == true || hunderedModel.isUnitHundred == true {
                            checkNext(word, previousWord)
                            
                            if tenModel.checked == false {
                                checkCheckNext(word, previousWord)
                            }
                            if unitModel.checked == false {
                                    print("123")
                            }
                        }
                        
                        
                        
                    }
                    previousWord = word
                    word = []
                }
                previousCharacter = character
            }
            if hunderedModel.isHundred == false && hunderedModel.isUnitHundred == false {
                // ОШИБКА
            }
        }
        
        print("First: \(numberModel.currentHundred), second: \(numberModel.currentTen), third: \(numberModel.currentUnit)")
    }
    
    func checkNext(_ word: [Character], _ previousWord: [Character]) {
        if String(word).lowercased() == "und" {
            numberModel.currentUnit = unitModel.checkUnits(word, previousWord, numberModel)
            
            // ОШИБКА
        } else {
            numberModel.currentTen = tenModel.checkTens(word, previousWord, numberModel)
            
            // ОШИБКА
        }
    }
    
    func checkCheckNext(_ word: [Character], _ previousWord: [Character]) {
        if String(word).lowercased() == "zig" {
            numberModel.currentTen = tenModel.checkCheckTens(word, previousWord, numberModel)
        }
    }
}
