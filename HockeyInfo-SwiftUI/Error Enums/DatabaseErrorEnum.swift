//
//  DatabaseErrorEnum.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

enum DatabaseErrorEnum: Error
{
    case saveToDatabase
    case readFromDatabase
}
