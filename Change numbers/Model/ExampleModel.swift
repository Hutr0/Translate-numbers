//
//  Number.swift
//  Change numbers
//
//  Created by Леонид Лукашевич on 17.02.2021.
//

import Foundation

struct ExampleModel {
    let unitsRus: Dictionary<Int,String> = [1: "аз", 2: "веди", 3: "глаголь", 4: "добро", 5: "есть", 6: "зело", 7: "земля", 8: "иже", 9: "фита"]
    
    let tensRus: Dictionary<Int,String> = [10: "и", 20:"како", 30: "люди", 40: "мыслете", 50: "наш", 60: "кси", 70: "он", 80: "покой", 90: "червь"]
    
    let hundredsRus: Dictionary<Int,String> = [100: "рцы", 200: "слово", 300: "твердь", 400: "ук", 500: "ферт", 600: "ха", 700: "пси", 800: "о", 900: "цы"]
    
    
    
    let units: Dictionary<String,Int> = ["null": 0, "ein": 1, "eins": 1, "zwan": 2, "zwei": 2, "drei": 3, "vier": 4, "funf": 5, "sechs": 6, "sieb": 7,"sieben": 7, "acht": 8, "neun": 9]
    
    
    
    let tens: Dictionary<String,Int> = ["ein": 10, "eins": 10, "zwan": 20, "zwei": 20, "drei": 30, "vier": 40, "funf": 50, "sechs": 60, "sieb": 70,"sieben": 70, "acht": 80, "neun": 90]
    
    let uniqueTens: Dictionary<String,Int> = ["zehn": 10, "elf": 11, "zwolf": 12, "dreizehn": 13,  "vierzehn": 14, "funfzehn": 15, "sechzehn": 16, "siebzehn": 17, "achtzehn": 18, "neunzehn": 19]
    
    
    
    let hundreds: Dictionary<String,Int> = ["einhundert": 100, "zweihundert": 200, "dreihundert": 300,  "vierhundert": 400, "funfhundert": 500, "sechshundert": 600, "siebenhundert": 700, "achthundert": 800 , "neunhundert": 900 ]
    
    let unitHundreds: Dictionary<String,Int> = ["ein": 1, "zwei": 2, "drei": 3,  "vier": 4, "funf": 5, "sechs": 6, "sieben": 7, "acht": 8, "neun": 9]
}
