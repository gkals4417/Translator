//
//  Constant.swift
//  Translator_Test
//
//  Created by Hamin Jeong on 2022/07/26.
//

import Foundation
import UIKit

public struct TransAPI {
    static let transBasicURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let clientID = "_RnmnlfxEnDvEEJy9lf2"
    static let clientSecret = "bGHVTHRMGd"
}


public struct DetectAPI {
    static let detectBasicURL = "https://openapi.naver.com/v1/papago/detectLangs"
    static let clientID = "_RnmnlfxEnDvEEJy9lf2"
    static let clientSecret = "bGHVTHRMGd"
}

public struct NameTransAPI {
    static let nameTransBasicURL = "https://openapi.naver.com/v1/krdict/romanization"
    static let clientID = "_RnmnlfxEnDvEEJy9lf2"
    static let clientSecret = "bGHVTHRMGd"
}

public struct NameTransCell {
    static let cellIdentifier = "NameCell"
}

public struct ColorConstant {
    static let backgroundColor: UIColor = UIColor(red: 205/255, green: 240/255, blue: 234/255, alpha: 1)
    static let textFieldBackGroundColor: UIColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.5)
    static let textColor: UIColor = UIColor(red: 247/255, green: 219/255, blue: 240/255, alpha: 1)
    static let selectBackGroundColor: UIColor = UIColor(red: 190/255, green: 174/255, blue: 226/255, alpha: 1)
}
