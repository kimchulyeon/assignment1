//
//  UserDefaultsManager.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/29/23.
//

import Foundation

enum UserDefaultsKeys: String {
    case boardDisplayName
    case boardID
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    func saveStringData(data: String?, key: UserDefaultsKeys) {
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func getStringData(key: UserDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
}
