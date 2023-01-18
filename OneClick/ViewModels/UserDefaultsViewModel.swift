//
//  DefaultsViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 18.01.2023.
//

import Foundation

class UserDefaultsViewModel: ObservableObject {
    @Published var timerDuration: Int!
    
    init() {
        timerDuration = getValue(for: .timerDuration, defaultValue: 5)
    }
    
    public func SetTimerDuration(_ duration: Int) {
        UserDefaults.standard.set(duration, forKey: UserDefaultsKeys.timerDuration.rawValue)
        timerDuration = duration
    }
}


// MARK: - getValue
//
// Gets a value associated with the specified key,
// or the specified default value if the key was not found.
//
extension UserDefaultsViewModel {
    private func getValue(for key: UserDefaultsKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    private func getValue(for key: UserDefaultsKeys, defaultValue: Int) -> Int {
        let value: Int = UserDefaults.standard.integer(forKey: key.rawValue)
        
        return value == 0 ? defaultValue : value
    }
    
    private func getValue(for key: UserDefaultsKeys, defaultValue: String) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? defaultValue
    }
}
