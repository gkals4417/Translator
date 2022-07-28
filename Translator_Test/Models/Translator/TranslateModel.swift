//
//  TranslateModel.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/24.
//

import Foundation

// MARK: - Welcome
struct WelcomeTranslate: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let type, service, version: String
    let result: TransResult

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case service = "@service"
        case version = "@version"
        case result
    }
}

// MARK: - Result
struct TransResult: Codable {
    let srcLangType, tarLangType, translatedText: String
}
