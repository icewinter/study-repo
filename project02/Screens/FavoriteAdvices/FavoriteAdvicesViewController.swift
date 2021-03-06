//
//  FavoriteAdvicesViewController.swift
//  project02
//
//  Created by Andrey Dubov on 11.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import UIKit

class FavoriteAdvicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FavoriteAdvicesViewModelProtocol {

    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var viewModel = FavoriteAdvicesViewModel()
    
    @IBAction func sortAdvicesButtonTapped(_ sender: Any) {
        viewModel.sortAdvices()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.delegate = self
        viewModel.loadAdvices()
        tableView.reloadData()
    }
    
    // MARK: - tableView data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.advices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.advices.count > indexPath.row else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdviceTableViewCell.cellReuseIdentifier, for: indexPath) as? AdviceTableViewCell else {
            return UITableViewCell()
        }
        cell.adviceTextLabel.text = viewModel.advices[indexPath.row].text
        return cell
    }
    
    // MARK: - tableView delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = viewModel.advices[indexPath.row].text
        showAlertDialog(title: "", message: message, positiveButtonText: "OK")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete
            viewModel.removeAdvice(index: indexPath.row)
        }
    }
    
    // MARK: - the model view callbacks
    
    func loadingStarted() {
        activityIndicator.startAnimating()
    }
    
    func loadingFinished() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func error(error: Error) {
        showAlertDialog(title: "", message: error.localizedDescription, positiveButtonText: "OK")
    }
    
    func updateUI(after: ServiceOperation) {
        switch after {
        default:
            tableView.reloadData()
        }
    }
    
    // MARK: - rest ones
    
    func setupTableView() {
        tableView.register(UINib(nibName: AdviceTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AdviceTableViewCell.cellReuseIdentifier)
        tableView.estimatedRowHeight = 64.0
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    func showAlertDialog (title: String, message: String, positiveButtonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: positiveButtonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
