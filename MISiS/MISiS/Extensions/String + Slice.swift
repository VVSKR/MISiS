//
//  Substring.swift
//  MISiS
//
//  Created by Vova SKR on 15.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

extension String {
    func slice(from: String, to: String, with options: String.CompareOptions = []) -> String? {
        return (range(of: from, options: options)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
