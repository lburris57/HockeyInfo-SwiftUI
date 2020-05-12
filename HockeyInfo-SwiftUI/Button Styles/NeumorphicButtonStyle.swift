//
//  NeumorphicButtonStyle.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 5/12/20.
//  Copyright © 2020 Larry Burris. All rights reserved.
//
import SwiftUI

struct NeumorphicButtonStyle: ButtonStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
            .background(
                Group
                {
                    if configuration.isPressed
                    {
                        Capsule()
                            
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 3)
                            .background(Color.gray)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: -2, y: -2)
                            .clipShape(Capsule())
                    }
                    else
                    {
                        Capsule()
                            .fill(Color.black)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                            .shadow(color: Color.black.opacity(0.7), radius: 2, x: -2, y: -2)
                    }
            })
    }
}
