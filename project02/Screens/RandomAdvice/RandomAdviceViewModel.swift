//
//  RandomAdviceViewModel.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

class RandomAdviceViewModel {
    
    var advices: [Advice] = [Advice]()
    
    private var service: AdviceService =  AdviceService()
    
    func loadAdvices() {
        advices = service.loadAdvices()
    }
    
    func getRandomAdvice() -> Advice {
        // get random index
        let adviceNumber = Int(arc4random_uniform(UInt32(self.advices.count)))
        return advices[adviceNumber]
    }
    
}
