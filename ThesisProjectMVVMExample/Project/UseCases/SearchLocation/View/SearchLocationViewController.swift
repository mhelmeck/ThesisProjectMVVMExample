//
//  SearchLocationViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import MapKit
import UIKit

public class SearchLocationViewController: UIViewController {
    // MARK: - Public properties
    public var viewModel: SearchLocationViewModel!

    // MARK: - Private properties
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searchCurrentButton: UIButton!
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var currentLocationLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        
        return view
    }()
    
    // MARK: - Init
    override public func viewDidLoad() {
        super.viewDidLoad()
    
        setupCoreLocation()
        
        setupView()
        bind(viewModel: viewModel)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.clearData()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private methods
    @IBAction private func searchButtonTapped(_ sender: Any) {
        viewModel.userPressedSearchButton()
    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        viewModel.userPressedCancelButton()
    }
    
    @IBAction private func searchCurrentButtonTapped(_ sender: Any) {
        viewModel.userPressedCurrentButton()
    }
    
    private func setupCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupView() {
        tableView.separatorStyle = .singleLine
        
        setupTextField()
        setupButtons()
    }
    
    private func setupTextField() {
        searchField.delegate = self
        searchField.layer.cornerRadius = 4
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.gray.cgColor
        
        searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupButtons() {
        [cancelButton, searchButton, searchCurrentButton].forEach {
            $0?.setTitleColor(.white, for: .normal)
            $0?.backgroundColor = .customBlue
            $0?.layer.cornerRadius = 4.0
        }
        
        cancelButton.setTitle("Cancel", for: .normal)
        searchButton.setTitle("Search", for: .normal)
        searchCurrentButton.setTitle("Current", for: .normal)
        
        searchCurrentButton.setBackground(color: .gray, forState: .disabled)
        searchCurrentButton.isEnabled = false
    }
    
    private func bind(viewModel: SearchLocationViewModel) {
        viewModel.updateView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.updateTitle = { [weak self] title in
            self?.currentLocationLabel.text = title
        }
        
        viewModel.updateCurrentButton = { [weak self] isEnabled in
            self?.searchCurrentButton.isEnabled = isEnabled
        }
        
        viewModel.updateLoadingState = { [weak self] isLoading in
            guard let self = self else {
                return
            }
            
            if isLoading {
                self.view.addSubview(self.activityIndicatorView)
                self.activityIndicatorView.center = self.view.center
                self.activityIndicatorView.backgroundColor = UIColor.white
                
                self.activityIndicatorView.startAnimating()
                self.tableView.isHidden = true
                
                self.searchField.resignFirstResponder()
            } else {
                self.activityIndicatorView.stopAnimating()
                self.tableView.isHidden = false
            }
        }
        
        viewModel.closeView = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        viewModel.phrase = textField.text ?? ""
    }
}

extension SearchLocationViewController: UITextFieldDelegate {
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        searchField.layer.borderColor = UIColor.customBlue.cgColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        searchField.layer.borderColor = UIColor.gray.cgColor
    }
}

extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") else {
            fatalError("Failed to dequeue reusable cell")
        }
        
        let cellViewModel = viewModel.getLocationCellViewModel(at: indexPath.row)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = cellViewModel.cityName
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressedCell(at: indexPath.row)
    }
}

extension SearchLocationViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let currentLocation = locations.last, viewModel != nil else {
            return
        }
        
        viewModel.updateCurrentLocation(latitude: currentLocation.coordinate.latitude,
                                        longitude: currentLocation.coordinate.longitude)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location with error: \(error)")
    }
}
