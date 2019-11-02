//
//  Storage.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 10/26/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

@propertyWrapper
struct Storage<T>
{
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T)
    {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T
    {
        get
        {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set
        {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
