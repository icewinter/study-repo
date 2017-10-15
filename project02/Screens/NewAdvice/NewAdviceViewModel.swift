//
//  NewAdviceViewModel.swift
//  project02
//
//  Created by Andrey Dubov on 10.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

class NewAdviceViewModel {
 
    private var service = AdviceServiceDataBase()
    
    func addNewAdvice(advice: Advice) {
        service.addAdvice(advice: advice)
    } 
}
