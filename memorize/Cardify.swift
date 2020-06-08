//
//  Cradify.swift
//  memorize
//
//  Created by sriram on 08/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    private let cornerRadius : CGFloat = 10.0
    private let lineWidth: CGFloat = 3
    private let multiplier: CGFloat = 0.6
    var theme : Themes.Theme
    var isFaceUp : Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                content
                
            }
        else {
                
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(self.theme.themeColor)
                
                
        }

        }
        
        
    }
}

extension View {
    func cardify(theme: Themes.Theme, isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(theme: theme, isFaceUp: isFaceUp))
    }
}
