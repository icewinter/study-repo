//
//  AdviceServiceRemoteServer.swift
//  project02
//
//  Created by Andrey Dubov on 02.10.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift

protocol AdviceServiceRemoteServerProtocol : class {
    func loadingStarted()
    func loadingFinished()
    func error(error: Error)
}

class AdviceServiceRemoteServer {
 
    weak var delegate: AdviceServiceRemoteServerProtocol?
    var advices: [Advice] {
        get {
            return adviceArray
        }
    }
    private var adviceArray: [Advice] = [Advice]()
    private let serialQueue01 = DispatchQueue(label: "com.orgname.project02.serialQueue01")
    
    func loadAdvices() {
        
        let URL = "http://fucking-great-advice.ru/api/latest/5"
        // make request to a remote server
        Alamofire.request(URL).responseArray(completionHandler: { [weak self] (response: DataResponse<[Advice]>) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.serialQueue01.async(execute: { () -> Void in
                // update UI
                DispatchQueue.main.sync(execute: { () -> Void in
                    strongSelf.delegate?.loadingStarted()
                })
                // handle an answer from the remote server
                switch response.result {
                case .success:
                    if let adviceArray = response.result.value {
                        strongSelf.adviceArray = adviceArray
                        // save into the database
                        do {
                            let realm = try Realm()
                            try realm.write {
                                for advice in adviceArray {
                                    let advice: AdviceRealm = AdviceRealm(advice: advice)
                                    realm.add(advice, update: true)
                                }
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
                    }
                case .failure(let error):
                    // update UI
                    DispatchQueue.main.sync(execute: { () -> Void in
                        strongSelf.delegate?.error(error: error)
                    })
                }
            })
        })
    }

}
