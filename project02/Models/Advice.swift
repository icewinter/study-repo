//
//  Advice.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

class Advice: NSObject, NSCoding {
    
    var id: Int
    var text: String
    var sound: String
    var stat: Int
    
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
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let text = aDecoder.decodeObject(forKey: "text") as! String
        let sound = aDecoder.decodeObject(forKey: "sound") as! String
        let stat = aDecoder.decodeInteger(forKey: "stat")
        self.init(id: id, text: text, sound: sound, stat: stat)
    }
    
    convenience init(text: String) {
        self.init(id: 0, text: text, sound: "", stat: 0)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(sound, forKey: "sound")
        aCoder.encode(stat, forKey: "stat")
    }
}
