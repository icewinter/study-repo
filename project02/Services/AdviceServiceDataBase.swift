//
//  AdviceServiceDataBase.swift
//  project02
//
//  Created by Andrey Dubov on 14.10.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation
import RealmSwift

protocol AdviceServiceDataBaseProtocol : class {
    func loadingStarted()
    func loadingFinished()
    func error(error: Error)
    func removed()
    func updated()
    func added()
    
}

class AdviceServiceDataBase {
    
    weak var delegate: AdviceServiceDataBaseProtocol?
    var advices: [Advice] {
        get {
            return adviceArray
        }
    }
    private var adviceArray: [Advice] = [Advice]()
    private let serialQueue = DispatchQueue(label: "com.orgname.project02.serialQueue01")
    
    func loadAdvices() {
        serialQueue.async(execute: { [weak self] () -> Void in
            guard let strongSelf = self else {
                return
            }
            // update UI
            DispatchQueue.main.sync(execute: { () -> Void in
                strongSelf.delegate?.loadingStarted()
            })
            // read advices from the database
            do {
                let realm = try Realm()
                let adviceRealmArray = realm.objects(AdviceRealm.self)
                strongSelf.adviceArray = [Advice]()
                for adviceRealm in adviceRealmArray {
                    let advice = Advice(adviceRealm: adviceRealm)
                    strongSelf.adviceArray.append(advice)
                }
            } catch let error {
                // update UI
                DispatchQueue.main.sync(execute: { () -> Void in
                    strongSelf.delegate?.error(error: error)
                })
            }
            // update UI
            DispatchQueue.main.sync(execute: { () -> Void in
                strongSelf.delegate?.loadingFinished()
            })
        })
    }
    
    func updateAdvice(advice: Advice) {
        serialQueue.async(execute: { [weak self] () -> Void in
            guard let strongSelf = self else {
                return
            }
            do {
                let realm = try Realm()
                try realm.write {
                    let advice: AdviceRealm = AdviceRealm(advice: advice)
                    realm.add(advice, update: true)
                }
            } catch let error {
                // update UI
                DispatchQueue.main.sync(execute: { () -> Void in
                    strongSelf.delegate?.error(error: error)
                })
            }
            // update UI
            DispatchQueue.main.sync(execute: { () -> Void in
                strongSelf.delegate?.updated()
            })
        })
    }
    
    func addAdvice(advice: Advice) {
        serialQueue.async(execute: { [weak self] () -> Void in
            guard let strongSelf = self else {
                return
            }
            do {
                let realm = try Realm()
                let incrementedId = try strongSelf.incrementAdviceRealmId()
                try realm.write {
                    let advice: AdviceRealm = AdviceRealm(advice: advice)
                    advice.id = incrementedId
                    realm.add(advice)
                }
                
            } catch let error {
                // update UI
                DispatchQueue.main.sync(execute: { () -> Void in
                    strongSelf.delegate?.error(error: error)
                })
            }
            // update UI
            DispatchQueue.main.sync(execute: { () -> Void in
                strongSelf.delegate?.added()
            })
        })
    }
    
    func removeAdvice(advice: Advice) {
        serialQueue.async(execute: { [weak self] () -> Void in
            guard let strongSelf = self else {
                return
            }
            do {
                let realm = try Realm()
                try realm.write {
                    let advice: AdviceRealm = AdviceRealm(advice: advice)
                    realm.delete(realm.objects(AdviceRealm.self).filter("id=%@",advice.id))
                }
            } catch let error {
                // update UI
                DispatchQueue.main.sync(execute: { () -> Void in
                    strongSelf.delegate?.error(error: error)
                })
            }
            // update UI
            DispatchQueue.main.sync(execute: { () -> Void in
                strongSelf.delegate?.removed()
            })
        })
    }
    
    private func incrementAdviceRealmId() throws -> Int {
        let realm = try Realm()
        return (realm.objects(AdviceRealm.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
}
