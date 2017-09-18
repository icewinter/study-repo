//
//  FavoriteAdvicesViewModel.swift
//  project02
//
//  Created by Andrey Dubov on 11.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

enum SortOrder {
    case ASC
    case DESC
}
 
class FavoriteAdvicesViewModel {
    
    var advices: [Advice] = [Advice]()
    private var sortOrder: SortOrder? = nil
    private var service = AdviceServiceUserDefaults()
    
    func loadAdvices() {
        advices = service.loadAdvices()
    }
    
    func removeAdvice(index: Int) {
        service.removeAdvice(index: index)
        advices.remove(at: index)
    }
    
    func sortAdvices() {
        guard let order = sortOrder else {
            advices.sort(by: { (item1: Advice, item2: Advice) -> Bool in
                return item1.text < item2.text
            })
            sortOrder = .ASC
            return
        }
        if order == .ASC {
            advices.sort(by: { (item1: Advice, item2: Advice) -> Bool in
                return item1.text > item2.text
            })
            sortOrder = .DESC
        } else {
            if order == .DESC {
                advices.sort(by: { (item1: Advice, item2: Advice) -> Bool in
                    return item1.text < item2.text
                })
                sortOrder = .ASC
            }
        }
    }
}
