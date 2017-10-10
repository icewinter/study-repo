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
    func loadingError(error: Error)
}

class AdviceServiceRemoteServer {
 
    var advices: [Advice]?
    weak var delegate: AdviceServiceRemoteServerProtocol?
    
    func loadAdvices() {
        
        let URL = "http://fucking-great-advice.ru/api/latest/5"
        delegate?.loadingStarted()
        
        Alamofire.request(URL).responseArray(completionHandler: { [weak self] (response: DataResponse<[Advice]>) in
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success:
                if let adviceArray = response.result.value {
                    strongSelf.advices = adviceArray
                    strongSelf.delegate?.loadingFinished()
                }
            case .failure(let error):
                strongSelf.delegate?.loadingError(error: error)
            }
        })
    }
    
}
