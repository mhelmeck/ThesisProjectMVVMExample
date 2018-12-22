//
//  AddCityViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import MapKit
import UIKit

public class AddCityViewController: UIViewController {
    // MARK: - Public properties
    public var viewModel: AddCityViewModel!

    // MARK: - Private properties
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searchCurrentButton: UIButton!
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var currentLocationLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private var activityIndicatorView: UIActivityIndicatorView!
    
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
    
    // Actions
    @IBAction private func searchButtonTapped(_ sender: Any) {
        viewModel.userPressedSearchButton()
    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        viewModel.userPressedCancelButton()
    }
    
    @IBAction private func searchCurrentButtonTapped(_ sender: Any) {
        viewModel.userPressedCurrentButton()
    }
    
    // MARK: - Private methods
    private func setupCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupView() {
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
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
    
    private func bind(viewModel: AddCityViewModel) {
        viewModel.updateView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.closeView = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        viewModel.updateTitle = { [weak self] title in
            self?.currentLocationLabel.text = title
        }
        
        viewModel.updateCurrentButton = { [weak self] isEnabled in
            self?.searchCurrentButton.isEnabled = isEnabled
        }
        
        viewModel.updateIsSavingNewCity = { [weak self] isSaving in
            guard let self = self else {
                return
            }
            
            if isSaving {
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
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        viewModel.phrase = textField.text ?? ""
    }
}

// MARK: - UITextFieldDelegate
extension AddCityViewController: UITextFieldDelegate {
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCityCell") else {
            fatalError("Error")
        }
        
        let cellViewModel = viewModel.getAddCityCellViewModel(at: indexPath.row)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = cellViewModel.cityName
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressedCell(at: indexPath.row)
    }
}

// MARK: - CLLocationManagerDelegate
extension AddCityViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let currentLocation = locations.last, viewModel != nil else {
            return
        }
        
        viewModel.updateLocation(latitude: currentLocation.coordinate.latitude,
                                 longitude: currentLocation.coordinate.longitude)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location with error: \(error)")
    }
}
