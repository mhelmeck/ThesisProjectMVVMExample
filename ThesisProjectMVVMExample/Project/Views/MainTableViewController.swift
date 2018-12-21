//
//  MainTableViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 09/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public class MainTableViewController: UITableViewController {
    // Properties
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        
        return view
    }()
    
    private var viewModel: MainTableViewModel!
    
    // Setup
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainTableViewModel(dataManager: DataManager())
        bind(viewModel: viewModel)
        
        registerCell()
        setupTableView()
        
        viewModel.fetchInitialData()
    }
    
    private func bind(viewModel: MainTableViewModel) {
        viewModel.updateView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.updateSeparatorStyle = { [weak self] separatorStyle in
            switch separatorStyle {
            case .singleLine:
                self?.tableView.separatorStyle = .singleLine
            case .none:
                self?.tableView.separatorStyle = .none
            }
        }
        
        viewModel.updateActivityIndicator = { [weak self] isLoading in
            isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func registerCell() {
        let nib = UINib(nibName: MainTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    private func setupTableView() {
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = .none
    }
    
    // Actions
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PushDetailsSegue" {
//            guard let viewController = segue.destination as? DetailViewController else {
//                return
//            }
//
//            let city = dataManager.cityCollection[selectedIndex]
//            viewController.forecastCollection = city.forecastCollection
//            viewController.cityName = city.name
//        }
//
//        if segue.identifier == "PushAddCitySegue" {
//            guard let viewController = segue.destination as? AddCityViewController else {
//                return
//            }
//
//            viewController.dataManager = dataManager
//        }
//
//        if segue.identifier == "PushMapSegue" {
//            guard let viewController = segue.destination as? MapViewController else {
//                return
//            }
//
//            let city = dataManager.cityCollection[selectedIndex]
//            viewController.lat = city.coordinates.lat
//            viewController.lon = city.coordinates.lon
//        }
    }
}

public extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.identifier,
            for: indexPath) as? MainTableViewCell else {
                fatalError("Failed to dequeue reusable cell")
        }
        
        cell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressedCell(at: indexPath.row)
        
        performSegue(withIdentifier: "PushDetailsSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.rowHeight)
    }
}

extension MainTableViewController: MainTableViewCellDelegate {
    public func mainTableViewCellDidTapNavigationButton(_ cell: MainTableViewCell) {
        viewModel.selectedIndex = tableView.indexPath(for: cell)?.row ?? 0
        performSegue(withIdentifier: "PushMapSegue", sender: nil)
    }
}
