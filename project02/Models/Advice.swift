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
    
    init?(id: Int?, text: String?, sound: String?, stat: Int?) {
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
        super.init()
    }
    
    init(id: Int, text: String, sound: String, stat: Int) {
        self.id = id
        self.text = text
        self.sound = sound
        self.stat = stat
        super.init()
    }
    
    override init() {
        self.id = 0
        self.text = ""
        self.sound = ""
        self.stat = 0
        super.init()
    }
    
    convenience init(text: String) {
        self.init()
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
        id <- map["id"]
        text <- map["text"]
        sound <- map["sound"]
        stat <- map["stat"]
    }
}
