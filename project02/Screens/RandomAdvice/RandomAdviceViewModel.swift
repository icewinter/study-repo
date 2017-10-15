//
//  RandomAdviceViewModel.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

protocol RandomAdviceViewModelProtocol : class {
    func loadingStarted()
    func loadingFinished()
    func error(error:Error)
}

class RandomAdviceViewModel : AdviceServiceRemoteServerProtocol {
    
    weak var delegate: RandomAdviceViewModelProtocol?
    private var advices: [Advice] = [Advice]()
    private var adviceIndex: Int = 0
    private var service = AdviceServiceRemoteServer()
    
    // MARK: - the model view interface
    
    func loadAdvices() {
        service.delegate = self
        service.loadAdvices()
    } 
    
    func getNextAdvice() -> Advice? {
        guard advices.isEmpty == false else {
            return nil
        }
        let newValue = adviceIndex + 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : 0
        return advices[adviceIndex]
    }
    
    func getPrevAdvice() -> Advice? {
        guard advices.isEmpty == false else {
            return nil
        }
        let newValue = adviceIndex - 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : (advices.count + newValue)
        return advices[adviceIndex]
    }
    
    func getRandomAdvice() -> Advice? {
        guard advices.isEmpty == false else {
            return nil
        }
        adviceIndex = Int(arc4random_uniform(UInt32(advices.count)))
        return advices[adviceIndex]
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
    
}
