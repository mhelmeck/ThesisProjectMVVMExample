//
//  DetailViewController.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {
    // MARK: - Public properties
    public var viewModel: DetailViewModel! {
        didSet {
            viewModel.isLoaded = true
        }
    }
    
    // MARK: - Private properties
    @IBOutlet private weak var forecastView: ForecastUIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var previewButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: - Init
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // INFO: - To refactor, may be dangerous
        guard viewModel.isLoaded else {
            return
        }
        
        bind(viewModel: viewModel)
    }
    
    // MARK: - Private methods
    @IBAction private func previewButtonTapped(_ sender: Any) {
        perform(animation: {
            self.forecastView.alpha = 0
        }, withCompletion: {
            self.viewModel.userPressedButton(buttonType: .preview)
        })

        perform(animation: {
            self.forecastView.alpha = 1
        }, withCompletion: nil)
    }
    
    @IBAction private func nextButtonTapped(_ sender: Any) {
        perform(animation: {
            self.forecastView.alpha = 0
        }, withCompletion: {
            self.viewModel.userPressedButton(buttonType: .next)
        })

        perform(animation: {
            self.forecastView.alpha = 1
        }, withCompletion: nil)

        dateLabel.text = "".uppercased()
    }

    private func setupView() {
        previewButton.setTitle("Preview", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        
        [previewButton, nextButton].forEach {
            $0?.setTitleColor(.white, for: .normal)
            
            $0?.backgroundColor = .customBlue
            $0?.setBackground(color: .gray, forState: .disabled)
            $0?.layer.cornerRadius = 4.0
            
            $0?.isEnabled = false
        }
    }
    
    private func bind(viewModel: DetailViewModel) {
        super.title = viewModel.cityName
        
        viewModel.updatePreviewButton = { [weak self] isEnabled in
            self?.previewButton.isEnabled = isEnabled
        }
        
        viewModel.updateNextButton = { [weak self] isEnabled in
            self?.nextButton.isEnabled = isEnabled
        }
        
        viewModel.updateForecastView = { [weak self] viewModel in
            self?.forecastView.viewModel = viewModel
        }
        
        viewModel.forecastIndex = 0
    }
    
    private func perform(animation: @escaping () -> Void,
                         withCompletion completion: (() -> Void)?) {
        UIView.animate(
            withDuration: 0.75,
            delay: 0.0,
            options: .curveEaseOut,
            animations: { animation() },
            completion: { _ in completion?() }
        )
    }
    private func updateView(withForecast forecast: Forecast) {

    }
}
