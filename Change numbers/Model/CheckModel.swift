//
//  IsHundred.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

let example = ExampleModel()

class CheckHundreds {
    var checked: Bool = false
    var isHundred: Bool = false
    var isUnitHundred: Bool = false
    
    func checkHundreds(_ word: [Character]) -> Int? {
        for hundred in example.hundreds {
            if hundred.key.lowercased() == String(word).lowercased() {
                self.isHundred = true
                self.checked = true
                return hundred.value
            }
        }
        
        // ОШИБКА
        return nil
    }
    
    func checkUnitHundreds(_ word: [Character]) -> Int? {
        for hundred in example.unitHundreds {
            if hundred.key.lowercased() == String(word).lowercased() {
                self.isUnitHundred = true
                self.checked = true
                return hundred.value * 100
            }
        }
        
        // ОШИБКА
        return nil
    }
}

class CheckTens {
    var checked: Bool = false
    var isUniqueTen: Bool = false
    var uniqueChecked: Bool = false
    var uniqueTen: String = ""
    
    func checkUniqueTens(word: [Character]) -> Int? {
        for uniqueTen in example.uniqueTens {
            if uniqueTen.key.lowercased() == String(word).lowercased() {
                self.isUniqueTen = true
                self.checked = true
                self.uniqueTen = uniqueTen.key
                return uniqueTen.value
            }
        }
        uniqueChecked = true
        
        // ОШИБКА
        return nil
    }
    
    func checkTens(previousWord word: [Character]) -> Int? {
        for ten in example.tens {
            if ten.key.lowercased() == String(word).lowercased() {
                self.checked = true
                return ten.value
            }
        }
        
        // ОШИБКА
        return nil
    }
}

class CheckUnits {
    //private var uniqueUnit: String = ""
    var checked: Bool = false
    //var getUniqueUnit: String { get { return uniqueUnit } }
    
    func checkUnits(previousWord word: [Character]) -> Int? {
        for unit in example.units {
            if unit.key.lowercased() == String(word).lowercased() {
               // uniqueUnit = unit.key
                self.checked = true
                return unit.value
            }
        }
        
        // ОШИБКА
        return nil
    }
}
