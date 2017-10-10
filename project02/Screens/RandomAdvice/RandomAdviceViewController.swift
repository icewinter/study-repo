//
//  RandomAdviceViewController.swift
//  project02
//
//  Created by Andrey Dubov on 09.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import UIKit

class RandomAdviceViewController: UIViewController, AdviceModelViewProtocol {
    
    @IBOutlet weak var label: UILabel!
    
    var viewModel = RandomAdviceViewModel()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func onNextAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getNextAdvice()?.text
    }
    
    @IBAction func onPrevAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getPrevAdvice()?.text
    }
    
    @IBAction func onRandomAdviceButtonTapped(_ sender: Any) {
        label.text = viewModel.getRandomAdvice()?.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        viewModel.delegate = self
        viewModel.loadAdvices()
    }
    
    // MARK: - the model view callbacks
    
    func loadingStarted() {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func loadingFinished() {
        activityIndicator.stopAnimating()
        label.text = viewModel.getRandomAdvice()?.text
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func loadingError(error: Error) {
        showAlertDialog(title: "", message: error.localizedDescription, positiveButtonText: "OK")
    }
    
    // MARK: - rest ones
    
    func showAlertDialog (title: String, message: String, positiveButtonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: positiveButtonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
}
