//
//  Utils.swift
//  MovieMate
//
//  Created by Fredson Silva on 21/07/24.
//

import UIKit

struct Utils {
    typealias Size = Padding
    
    struct SavedColors {
        static let titleAdaptiveColor = UIColor(named: "titleAdaptiveColor")
    }
    
    enum Padding {
        static let micro: CGFloat = 2.0
        static let tiny: CGFloat = 4.0
        static let smaller: CGFloat = 10.0
        static let small: CGFloat = 12.0
        static let medium: CGFloat = 16.0
        static let big: CGFloat = 20.0
        static let large: CGFloat = 24.0
        static let extraLarge: CGFloat = 32.0
        static let superLarge: CGFloat = 40.0
        static let superExtraLarge: CGFloat = 48.0
    }
}


