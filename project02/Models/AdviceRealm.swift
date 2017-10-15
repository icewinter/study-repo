//
//  AdviceRealm.swift
//  project02
//
//  Created by Andrey Dubov on 10.10.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class AdviceRealm : Object, Mappable {
    
    dynamic var id: Int = 0
    dynamic var text: String = ""
    dynamic var sound: String = ""
    dynamic var stat: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        sound <- map["sound"]
        stat <- map["stat"]
    }
    
    convenience init(advice: Advice) {
        self.init()
        id = advice.id
        text = advice.text
        sound = advice.sound
        stat = advice.stat
    }
}
