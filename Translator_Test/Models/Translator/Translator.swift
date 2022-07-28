//
//  Translator.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/28.
//

import Foundation

struct Translator {
    
    let languageKeys = ["한국어", "영어", "일본어", "중국어 간체", "중국어 번체", "베트남어", "인도네시아어", "태국어", "독일어", "러시아어", "스페인어", "이탈리아어", "프랑스어"]
    let languageValues = ["ko", "en", "ja", "zh-CN", "zh-TW", "vi", "id", "th", "de", "ru", "es", "it", "fr"]
    
    func getSrcIndex(tempSrcIndex: Int) -> String {
        var temp: String = ""
        switch tempSrcIndex {
        case 0:
            temp = "ko"
        case 1:
            temp = "en"
        case 2:
            temp = "ja"
        case 3:
            temp = "zh-CN"
        case 4:
            temp = "zh-TW"
        case 5:
            temp = "vi"
        case 6:
            temp = "id"
        case 7:
            temp = "th"
        case 8:
            temp = "de"
        case 9:
            temp = "ru"
        case 10:
            temp = "es"
        case 11:
            temp = "it"
        case 12:
            temp = "fr"
        default:
            break
        }
        return temp
    }
    
    func getTargetIndex(tempTargetIndex: Int) -> String {
        var temp: String = ""
        switch tempTargetIndex {
        case 0:
            temp = "ko"
        case 1:
            temp = "en"
        case 2:
            temp = "ja"
        case 3:
            temp = "zh-CN"
        case 4:
            temp = "zh-TW"
        case 5:
            temp = "vi"
        case 6:
            temp = "id"
        case 7:
            temp = "th"
        case 8:
            temp = "de"
        case 9:
            temp = "ru"
        case 10:
            temp = "es"
        case 11:
            temp = "it"
        case 12:
            temp = "fr"
        default:
            break
        }
        return temp
    }
    
}
