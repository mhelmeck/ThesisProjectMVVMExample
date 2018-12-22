//
//  MapViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import MapKit
import UIKit

public class MapViewController: UIViewController {
    // Properties
    @IBOutlet private weak var mapView: MKMapView!
    private var annotationView = MKPointAnnotation()
    private var isViewModelInjected = false
    
    public var viewModel: MapViewModel! {
        didSet {
            isViewModelInjected = true
        }
    }
    
    // Init
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard isViewModelInjected else {
            return
        }
        
        reloadView()
    }
    
    // Private methods
    public func reloadView() {
        setupLocation()
        setupAnnotation()
    }
    
    private func setupLocation() {
        let center = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                            longitude: viewModel.longitude)
        let span = MKCoordinateSpan(latitudeDelta: viewModel.latitudeDelta,
                                    longitudeDelta: viewModel.longitudeDelta)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func setupAnnotation() {
        annotationView.coordinate = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                                           longitude: viewModel.longitude)
        
        mapView.addAnnotation(annotationView)
    }
}
