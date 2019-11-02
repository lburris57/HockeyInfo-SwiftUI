//
//  FaceoffData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct FaceoffData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var faceoffWins: Int = 0
    var faceoffLosses: Int = 0
    var faceoffPercent: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case faceoffWins = "faceoffWins"
        case faceoffLosses = "faceoffLosses"
        case faceoffPercent = "faceoffPercent"
    }
}
