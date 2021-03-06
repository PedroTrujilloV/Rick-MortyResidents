//
//  UIColor+Palette.swift
//  Rick&MortyResidents
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation
import UIKit

extension UIColor {
    public static var brandColor: UIColor {
        return UIColor(named: "brandColor") ?? systemRed
    }
    
    public static var nameTextColor: UIColor {
        return UIColor(named: "nameTextColor") ?? systemGray
    }
    
    public static var descriptionTextColor: UIColor {
        return UIColor(named: "descriptionTextColor") ?? systemGray2
    }
    
    public static var cellImageBackgroundColor: UIColor {
        return UIColor(named: "cellImageBackgroundColor") ?? systemBackground
    }
    
    public static var cellBackgroundColor: UIColor {
        return UIColor(named: "cellBackgroundColor") ?? tertiarySystemBackground
    }
    
    public static var glowColor: UIColor {
        return UIColor(named: "glowColor") ?? systemYellow
    }
        
}
