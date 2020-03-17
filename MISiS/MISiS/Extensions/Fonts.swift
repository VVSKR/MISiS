//
//  Fonts.swift
//  MISiS
//
//  Created by Vova SKR on 16.03.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class Fonts {

    private static let sfProTextLightFont = "SFProText-Light"
    private static let sfProTextRegularFont = "SFProText-Regular"
    private static let sfProTextSemiboldFont = "SFProText-Semibold"
    private static let sfProDisplayRegularFont = "SFProDisplay-Regular"

    static let title2Font = UIFont(name: sfProDisplayRegularFont, size: 22) ?? UIFont.boldSystemFont(ofSize: 20)
    static let headlineFont = UIFont(name: sfProTextSemiboldFont, size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    static let bodyFont = UIFont(name: sfProTextLightFont, size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    static let calloutFont = UIFont(name: sfProTextSemiboldFont, size: 16) ?? UIFont.boldSystemFont(ofSize: 17)
    static let subheadFont = UIFont(name: sfProTextLightFont, size: 15) ?? UIFont.systemFont(ofSize: 13)
    static let footnoteFont = UIFont(name: sfProTextRegularFont, size: 13) ?? UIFont.systemFont(ofSize: 13)
    static let caption2Font = UIFont(name: sfProTextRegularFont, size: 11) ?? UIFont.systemFont(ofSize: 11)
}
