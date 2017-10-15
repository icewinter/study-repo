//
//  NewAdviceViewController.swift
//  project02
//
//  Created by Andrey Dubov on 10.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import UIKit

class NewAdviceViewController: UIViewController {
    
    @IBOutlet weak var newAdviceTextField: UITextField!
    
    var viewModel = NewAdviceViewModel()

    @IBAction func onAddButtonTapped(_ sender: Any) {
        guard let adviceText = newAdviceTextField.text else {
            return
        }
        let advice: Advice = Advice(text: adviceText)
        viewModel.addNewAdvice(advice: advice)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        // self.unwind(for: UIStoryboardSegue, towardsViewController: UIViewController)
        dismiss(animated: true, completion: nil)
    }

}
