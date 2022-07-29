//
//  NameTranslateModel.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/24.
//

import Foundation

// MARK: - Welcome
struct WelcomeNameTranslate: Codable {
    let aResult: [AResult]
}

// MARK: - AResult
struct AResult: Codable {
    let sFirstName: String
    let aItems: [AItem]
}

// MARK: - AItem
struct AItem: Codable {
    let name, score: String
}
