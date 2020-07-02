//
//  Cradify.swift
//  memorize
//
//  Created by sriram on 08/06/20.
//  Copyright © 2020 iWeds. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    private let cornerRadius : CGFloat = 10.0
    private let lineWidth: CGFloat = 3
    private let multiplier: CGFloat = 0.6
    var theme : Themes.Theme
    
    var rotation : Double
    
    
    var isFaceUp : Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool, theme: Themes.Theme) {
        rotation = isFaceUp ? 0 : 180
        self.theme = theme
    }
    
    var animatableData: Double {
        get { return rotation}
        set {
            rotation = newValue
        }
    }
    
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.lineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: self.cornerRadius).fill(self.theme.themeColor)
                .opacity(isFaceUp ? 0 : 1)
                                        
                
        

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        
        
    }
}

extension View {
    func cardify(isFaceUp: Bool, theme: Themes.Theme) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, theme: theme))
    }
}
