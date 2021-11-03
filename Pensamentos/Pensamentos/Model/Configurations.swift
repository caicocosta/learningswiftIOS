//
//  Configurations.swift
//  Pensamentos
//
//  Created by Caico Saler Oliveira Costa on 03/11/21.
//

import Foundation

enum UserDefaultsKeys: String {
    case timeIntervals = "timeinterval"
    case colorSchema = "colorschema"
    case autoRefresh = "autorefresh"
}

class Configuration {
    
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var timerInterval: Double {
        get {
            return defaults.double(forKey: UserDefaultsKeys.timeIntervals.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.timeIntervals.rawValue)
        }
    }
    
    var colorSchema: Int {
        get {
            return defaults.integer(forKey: UserDefaultsKeys.colorSchema.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.colorSchema.rawValue)
        }
    }
    
    var autoRefresh: Bool {
        get {
            return defaults.bool(forKey: UserDefaultsKeys.autoRefresh.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.autoRefresh.rawValue)
        }
    }
    
    private init() {
        if defaults.double(forKey: UserDefaultsKeys.timeIntervals.rawValue) == 0 {
            defaults.set(8.0, forKey: UserDefaultsKeys.timeIntervals.rawValue)
        }
    }
    
}
