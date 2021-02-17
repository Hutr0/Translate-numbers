//
//  IsHundred.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

 class HundredModel {
    var checked: Bool = false
    var isHundred: Bool = false
    var isUnitHundred: Bool = false
    
    func checkHundreds(_ word: [Character], _ number: NumberModel) -> Int {
        for hundred in number.hundreds {
            if hundred.key.lowercased() == String(word).lowercased() {
                self.isHundred = true
                self.checked = true
                return hundred.value
            }
        }
        
        // ОШИБКА
        return 0
    }
    
    func checkUnitHundreds(_ word: [Character], _ number: NumberModel) -> Int{
        for unit in number.unitHundreds {
            if unit.key.lowercased() == String(word).lowercased() {
                self.isUnitHundred = true
                self.checked = true
                return unit.value * 100
            }
        }
        
        // ОШИБКА
        return 0
    }
}
