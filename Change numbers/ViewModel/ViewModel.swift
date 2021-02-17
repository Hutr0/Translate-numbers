//
//  ViewModel.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

class ViewModel {
    
    var number = Number()
    var checkHundreds = CheckHundreds()
    
    func startTranslating(_ string: String) {
        if string.lowercased().contains("hundert") {
            
            var word: [Character] = []
            var previousWord: [Character] = []
            var previousCharacter: Character?
                
            for character in string {
                if character != " " {
                    
                    // Пофиксить баг с пробелом
                    
                    word.append(character)
                } else {
                    if previousCharacter != " " && previousCharacter != nil {
                        
                        if checkHundreds.isHundred == false {
                            checkHundreds(word)
                        }
                        
                        if checkHundreds.isHundred == false && String(word).lowercased() == "hundert" {
                            checkUnitHundreds(previousWord)
                        }
                        
                        if checkHundreds.isHundred == true || checkHundreds.isUnitHundred == true {
                            
                        } else {
                            // ОШИБКА
                        }
                    }
                    previousWord = word
                    word = []
                }
                previousCharacter = character
            }
        }
    }
    
//    func check(_ word: [Character]) {
//        checkHundreds(word)
//    }
    
    func checkHundreds(_ word: [Character]) {
        for hundred in number.hundreds {
            if hundred.key.lowercased() == String(word).lowercased() {
                number.hundred = hundred.value
                checkHundreds.isHundred = true
                print("1")
                return
            }
        }
        // ОШИБКА
    }
    
    func checkUnitHundreds(_ word: [Character]) {
        for unit in number.unitHundreds {
            if unit.key.lowercased() == String(word).lowercased() {
                number.hundred = unit.value * 100
                checkHundreds.isUnitHundred = true
                print(number.hundred!)
                return
            }
        }
        
        // ОШИБКА
    }
}
