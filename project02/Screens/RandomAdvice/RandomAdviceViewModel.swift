//
//  RandomAdviceViewModel.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import Foundation

protocol AdviceModelViewProtocol : class {
    func loadingStarted()
    func loadingFinished()
    func loadingError(error:Error)
}

class RandomAdviceViewModel : AdviceServiceRemoteServerProtocol {
    
    private var adviceIndex: Int = 0
    private var service = AdviceServiceRemoteServer()
    weak var delegate: AdviceModelViewProtocol?
    
    // MARK: - the model view interface
    
    func loadAdvices() {
        service.delegate = self
        service.loadAdvices()
    } 
    
    func getNextAdvice() -> Advice? {
        guard let advices = service.advices else {
            return nil
        }
        let newValue = adviceIndex + 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : 0
        return advices[adviceIndex]
    }
    
    func getPrevAdvice() -> Advice? {
        guard let advices = service.advices else {
            return nil
        }
        let newValue = adviceIndex - 1
        adviceIndex = (newValue >= 0 && newValue < advices.count) ? newValue : (advices.count + newValue)
        return advices[adviceIndex]
    }
    
    func getRandomAdvice() -> Advice? {
        guard let advices = service.advices else {
            return nil
        }
        adviceIndex = Int(arc4random_uniform(UInt32(advices.count)))  // get random index
        return advices[adviceIndex]
    }
    
    // MARK: - the service callbacks
    
    func loadingStarted() {
        delegate?.loadingStarted()
    }
    
    func loadingFinished() {
        delegate?.loadingFinished()
    }
    
    func loadingError(error: Error) {
        delegate?.loadingError(error: error)
    }
    
}
