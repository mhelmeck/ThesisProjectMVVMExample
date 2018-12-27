//
//  ShowMapViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import MapKit
import UIKit

public class ShowMapViewController: UIViewController {
    // MARK: - Public properties
    public var viewModel: ShowMapViewModel!
    
    // MARK: - Private properties
    @IBOutlet private weak var mapView: MKMapView!
    private var annotationView = MKPointAnnotation()
    
    // MARK: - Init
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadView()
    }
    
    // MARK: - Private methods
    private func reloadView() {
        setupLocation()
        setupAnnotation()
    }
    
    private func setupLocation() {
        let center = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                            longitude: viewModel.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func setupAnnotation() {
        annotationView.coordinate = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                                           longitude: viewModel.longitude)
        
        mapView.addAnnotation(annotationView)
    }
}
