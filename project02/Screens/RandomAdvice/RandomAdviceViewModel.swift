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
    
    private var adviceIndex: Int = 0
    
    private var service: AdviceService =  AdviceService()
    
    func loadAdvices() {
        advices = service.loadAdvices()
    } 
    
    func getNextAdvice() -> Advice {
        let newValue = adviceIndex + 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : 0
        return advices[adviceIndex]
    }
    
    func getPrevAdvice() -> Advice {
        let newValue = adviceIndex - 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : (advices.count + newValue)
        return advices[adviceIndex]
    }
    
    func getRandomAdvice() -> Advice {
        // get random index
        adviceIndex = Int(arc4random_uniform(UInt32(self.advices.count)))
        return advices[adviceIndex]
    }
    
}
