//
//  HandednessData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct HandednessData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var shoots: String?
    
    private enum CodingKeys : String, CodingKey
    {
        case shoots = "shoots"
    }
}
