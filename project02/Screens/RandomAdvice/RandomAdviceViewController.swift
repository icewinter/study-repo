//
//  RandomAdviceViewController.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import UIKit

class RandomAdviceViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var viewModel = RandomAdviceViewModel()
    
    @IBAction func onNextAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getNextAdvice().text
    }
    
    @IBAction func onPrevAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getPrevAdvice().text
    }
    
    @IBAction func onRandomAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getRandomAdvice().text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadAdvices()
        label.text = viewModel.getRandomAdvice().text
    }
    
}
