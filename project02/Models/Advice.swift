//
//  Advice.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation
import ObjectMapper

class Advice: NSObject, NSCoding, Mappable {
    
    var id: Int = 0
    var text: String = ""
    var sound: String = ""
    var stat: Int = 0
    
    private let transformToInt = TransformOf<Int, String>(fromJSON: { (id: String?) -> Int? in
        if let id = id {
            if let result = Int(id) {
                return result
            } else {
                return 0
            }
        } else {
            return 0
        }
    }, toJSON: { (id: Int?) -> String? in
        if let id = id {
            return String(id)
        } else {
            return ""
        }
    })

    init?(id: Int?, text: String?, sound: String?, stat: Int?) {
        super.init()
        guard let _id = id else {
            return nil
        }
        guard let _sound = sound else {
            return nil
        }
        guard let _text = text else {
            return nil
        }
        guard let _stat = stat else {
            return nil
        }
        self.id = _id
        self.text = _text
        self.sound = _sound
        self.stat = _stat
    }
    
    init(id: Int, text: String, sound: String, stat: Int) {
        super.init()
        self.id = id
        self.text = text
        self.sound = sound
        self.stat = stat
    }
    
    override init() {
        super.init()
        self.id = 0
        self.text = ""
        self.sound = ""
        self.stat = 0
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(adviceRealm: AdviceRealm) {
        self.init()
        id = adviceRealm.id
        text = adviceRealm.text
        sound = adviceRealm.sound
        stat = adviceRealm.stat
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let text = aDecoder.decodeObject(forKey: "text") as! String
        let sound = aDecoder.decodeObject(forKey: "sound") as! String
        let stat = aDecoder.decodeInteger(forKey: "stat")
        self.init(id: id, text: text, sound: sound, stat: stat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(sound, forKey: "sound")
        aCoder.encode(stat, forKey: "stat")
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], transformToInt)
        text <- map["text"]
        sound <- map["sound"]
        stat <- (map["stat"], transformToInt)
    }
}
