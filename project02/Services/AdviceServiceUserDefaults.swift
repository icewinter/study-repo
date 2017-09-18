//
//  AdviceServiceUserDefaults.swift
//  project02
//
//  Created by Andrey Dubov on 11.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

fileprivate let keyName: String = "advices"

class AdviceServiceUserDefaults {
    
    private var userDefaults: UserDefaults = UserDefaults.standard
    
    func loadAdvices() -> [Advice] {
        guard let decoded  = userDefaults.object(forKey: keyName) as? Data else {
            return [Advice]()
        }
        guard let decodedAdvices = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Advice] else {
            return [Advice]()
        }
        return decodedAdvices
    }
    
    func addNewAdvice(advice: Advice) {
        // get array of all advices and put a new one into it
        var advices: [Advice] = loadAdvices()
        advices.append(advice)
        // save the array of advices
        saveAdvices(advices: advices)
    }
    
    func removeAdvice(index: Int) {
        // get array of all advices and remove one of them
        var advices: [Advice] = loadAdvices()
        advices.remove(at: index)
        // save the array of advices
        saveAdvices(advices: advices)
    }
    
    private func saveAdvices(advices: [Advice]) {
        // save the array of advices
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: advices)
        userDefaults.set(encodedData, forKey: keyName)
        userDefaults.synchronize()
    }
    
}
