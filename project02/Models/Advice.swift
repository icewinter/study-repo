//
//  Advice.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

struct Advice {
    
    var id: UInt
    var text: String
    var sound: String
    var stat: UInt
    
    init? (id: UInt?, text: String?, sound: String?, stat: UInt?) {
        
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
}
