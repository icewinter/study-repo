//
//  AdviceService.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

class AdviceService {
    
    func loadAdvices() -> [Advice] {
        
        var advices: [Advice]
        // get json file url
        let jsonFileUrl = Bundle.main.url(forResource: "advices", withExtension: "json")
        guard let url = jsonFileUrl else {
            return [Advice]()
        }
        do {
            // get json file data
            let data = try Data(contentsOf: url)
            // get json file object
            let jsonObject: [[String:String]]? = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:String]]
            guard let json = jsonObject else {
                return [Advice]()
            }
            // extract all advices into the array
            advices = json.map({ (advice:[String:String]) -> Advice? in
                let id = Int(advice["identifier"] ?? "")
                let text = advice["text"]
                let sound = advice["sound"]
                let stat = Int(advice["stat"] ?? "")
                return Advice(id: id, text: text, sound: sound, stat: stat)
            }).filter({ (advice: Advice?) -> Bool in
                return advice != nil ? true : false
            }).map({ (advice: Advice?) -> Advice in
                return advice!
            })
        } catch {
            return [Advice]()
        }
        return advices
    }
    
}
