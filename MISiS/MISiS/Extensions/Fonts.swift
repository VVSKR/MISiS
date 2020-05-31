//
//  Fonts.swift
//  MISiS
//
//  Created by Vova SKR on 16.03.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import UIKit

class Fonts {

    private static let sfProTextLightFont = "Webnar-Light"
    private static let webnarRegularFont = "Webnar-Regular"
    private static let webnarDemiboldFont = "Webnar-DemiBold"
    private static let webnarBoldFont = "Webnar-Bold"
    

    static let lightFont = UIFont(name: sfProTextLightFont, size: 15) ?? UIFont.systemFont(ofSize: 13)
    static let regularFont = UIFont(name: sfProTextLightFont, size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
    static let demiBldFont = UIFont(name: webnarDemiboldFont, size: 17)  ?? UIFont.boldSystemFont(ofSize: 17)
    static let boldFont = UIFont(name: webnarBoldFont, size: 22) ?? UIFont.boldSystemFont(ofSize: 20)
}
