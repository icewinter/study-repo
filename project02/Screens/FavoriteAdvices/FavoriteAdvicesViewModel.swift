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

protocol FavoriteAdvicesViewModelProtocol : class {
    func loadingStarted()
    func loadingFinished()
    func error(error: Error)
    func updateUI(after operation: ServiceOperation)
}

struct AdviceState {
    var selected: Bool = false
    var updateable: Bool = false
    var removeable: Bool  = false
}

class FavoriteAdvicesViewModel: AdviceServiceDataBaseProtocol {
    
    weak var delegate: FavoriteAdvicesViewModelProtocol?
    var advices: [Advice] = [Advice]()
    private var advicesState: [Int:AdviceState] = [:]
    private var sortOrder: SortOrder? = nil
    private var service = AdviceServiceDataBase()
    
    func loadAdvices() {
        service.delegate = self
        service.loadAdvices()
    }
    
    func sortAdvices() {
        guard advices.isEmpty == false else {
            return
        }
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
    
    func removeAdvice(index: Int) {
        guard advices.isEmpty == false else {
            return
        }
        let advice = advices[index]
        var adviceState = AdviceState()
        adviceState.removeable = true
        advicesState.updateValue(adviceState, forKey: index)
        service.removeAdvice(advice: advice)
    }
    
    // MARK: - the service callbacks
    
    func loadingStarted() {
        delegate?.loadingStarted()
    }
    
    func loadingFinished() {
        guard service.advices.isEmpty == false else {
            delegate?.loadingFinished()
            return
        }
        advices = [Advice]()
        advices.append(contentsOf: service.advices)
        delegate?.loadingFinished()
    }
    
    func error(error: Error) {
        delegate?.error(error: error)
    }
    
    func removed() {
        let removeableAdvice = advicesState.filter({ (advice: (id: Int, state: AdviceState)) -> Bool in
            return advice.state.removeable == true
        }).first
        guard let removeableAdviceIndex = removeableAdvice?.key else {
            return
        }
        advicesState[removeableAdviceIndex]?.removeable = false
        advices.remove(at: removeableAdviceIndex)
        delegate?.updateUI(after: .removeAdvice)
    }
    
    func added() {
        delegate?.updateUI(after: .addAdvice)
    }
    
    func updated() {
        delegate?.updateUI(after: .updateAdvice)
    }
}
