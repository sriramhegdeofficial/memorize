//
//  Themes.swift
//  memorize
//
//  Created by sriram on 07/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import SwiftUI

struct Themes {
    
    static  var allThemes : [Theme] = []
        
    struct Theme {
        let themeName : String
        let themeColor: Color
        let themeContent : [String]
    }
    
     var selectedTheme : Theme
    
    init(selectedThemeIndex: Int) {
        Themes.allThemes = []
        Themes.allThemes.append(Theme(themeName: "halloween", themeColor: Color.orange, themeContent: ["👻", "👹","😈","💩","👽"]))
        Themes.allThemes.append(Theme(themeName: "smiley", themeColor: Color.green, themeContent: ["😀", "😃","😄","😁","😆"]))
        Themes.allThemes.append(Theme(themeName: "letters", themeColor: Color.pink, themeContent: ["K", "L","M","Z","U"]))
        selectedTheme = Themes.allThemes[0]
        for index in 0..<Themes.allThemes.count {
            if index == selectedThemeIndex {
                selectedTheme = Themes.allThemes[index]
            }
            
        }
    }
}
