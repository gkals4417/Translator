//
//  Detector.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/28.
//

import Foundation

struct Detector{

    let languageKeys = ["한국어", "일본어", "중국어 간체", "중국어 번체", "힌디어", "영어", "스페인어", "프랑스어", "독일어", "포르투갈어", "베트남어", "인도네시아어", "페르시아어", "아랍어", "미얀마어", "태국어", "러시아어", "이탈리아어", "알수없음"]
    let languageValues = ["ko", "ja", "zh-CN", "zh-TW", "hi", "en", "es", "fr", "de", "pt", "vi", "id", "fa", "ar", "mm", "th", "ru", "it", "unk"]

    func detecFunc(detectTerm: String) -> String {
        var keys: String = ""
        switch detectTerm {
        case "ko":
            keys = "한국어"
        case "ja":
            keys = "일본어"
        case "zh-CN":
            keys = "중국어 간체"
        case "zh-TW":
            keys = "중국어 번체"
        case "hi":
            keys = "힌디어"
        case "en":
            keys = "영어"
        case "es":
            keys = "스페인어"
        case "fr":
            keys = "프랑스어"
        case "de":
            keys = "독일어"
        case "pt":
            keys = "포르투갈어"
        case "vi":
            keys = "베트남어"
        case "id":
            keys = "인도네시아어"
        case "fa":
            keys = "페르시아어"
        case "ar":
            keys = "아랍어"
        case "mm":
            keys = "미얀마어"
        case "th":
            keys = "태국어"
        case "ru":
            keys = "러시아어"
        case "it":
            keys = "이탈리아어"
        case "unk":
            keys = "알수 없음"
        default:
            break
        }
        return keys
    }
}
