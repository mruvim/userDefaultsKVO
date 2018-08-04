//
//  UserDefaultsExtensions.swift
//  UserDefaultsObserve
//
//  Created by Ruvim Miksanskiy on 8/4/18.
//  Copyright © 2018 Ruvim Miksanskiy. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Key {
        static let demoCount = "demoCount"
    }
}

extension UserDefaults {
    @objc dynamic var demoCount:Int {
        return integer(forKey: Key.demoCount)
    }
}
