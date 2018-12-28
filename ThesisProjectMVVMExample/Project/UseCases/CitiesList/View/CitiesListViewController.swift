//
//  CitiesListViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 09/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public class CitiesListViewController: UITableViewController {
    // MARK: - Private properties
    private var viewModel: CitiesListViewModel = CitiesListViewModel()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        
        return view
    }()
    
    // MARK: - Init
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupTableView()
        bind(viewModel: viewModel)
        
        viewModel.fetchInitialData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private methods
    private func registerCell() {
        let nib = UINib(nibName: CityCellView.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityCellView .identifier)
    }
    
    private func setupTableView() {
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = .none
    }
    
    private func bind(viewModel: CitiesListViewModel) {
        viewModel.updateTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.updateSeparatorStyle = { [weak self] style in
            switch style {
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
    
    // MARK: - Public methods
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushCityDetailsSegue" {
            guard let viewController = segue.destination as? CityDetailsViewController else {
                return
            }

            viewController.viewModel = viewModel.getCityDetailsViewModel()
        }

        if segue.identifier == "PushSearchLocationSegue" {
            guard let viewController = segue.destination as? SearchLocationViewController else {
                return
            }

            viewController.viewModel = viewModel.getSearchLocationViewModel()
        }

        if segue.identifier == "PushShowMapSegue" {
            guard let viewController = segue.destination as? ShowMapViewController else {
                return
            }
            
            viewController.viewModel = viewModel.getShowMapViewModel()
        }
    }
}

public extension CitiesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityCellView.identifier,
            for: indexPath) as? CityCellView else {
                fatalError("Failed to dequeue reusable cell")
        }
        
        cell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressedCell(at: indexPath.row)
        
        performSegue(withIdentifier: "PushCityDetailsSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension CitiesListViewController: CityCellViewDelegate {
    public func cityCellViewDidTapNavigationButton(_ cell: CityCellView) {
        guard let row = tableView.indexPath(for: cell)?.row else {
            return
        }
        
        viewModel.userPressedNaviagationButton(at: row)
        performSegue(withIdentifier: "PushShowMapSegue", sender: nil)
    }
}
