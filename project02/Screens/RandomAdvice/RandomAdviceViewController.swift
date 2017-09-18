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
    
    @IBAction func onRandomAdviceButtonTapped(_ sender: Any) {
        // show random advice text on the label
        label.text = viewModel.getRandomAdvice().text
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load all available advices
        viewModel.loadAdvices()
    }
    
}
