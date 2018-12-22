//
//  ForecastUIView.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public class ForecastUIView: UIView {
    // MARK: - Public properties
    public var viewModel: ForecastViewModel! {
        didSet {
            bind(viewModel: viewModel)
        }
    }
    
    // MARK: - Private properties
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var typeTitle: UILabel!
    @IBOutlet private weak var typeValue: UILabel!
    
    @IBOutlet private weak var minTempTitle: UILabel!
    @IBOutlet private weak var minTempValue: UILabel!
    
    @IBOutlet private weak var maxTempTitle: UILabel!
    @IBOutlet private weak var maxTempValue: UILabel!
    
    @IBOutlet private weak var windSpeedTitle: UILabel!
    @IBOutlet private weak var windSpeedValue: UILabel!
    
    @IBOutlet private weak var windDirectionTitle: UILabel!
    @IBOutlet private weak var windDirectionValue: UILabel!
    
    @IBOutlet private weak var rainfallTitle: UILabel!
    @IBOutlet private weak var rainfallValue: UILabel!
    
    @IBOutlet private weak var pressureTitle: UILabel!
    @IBOutlet private weak var pressureValue: UILabel!

    // Init
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Private methods
    private func setupView() {
        imageView.contentMode = .scaleAspectFit
        
        setupLabels()
    }
    
    private func setupLabels() {
        backgroundColor = .white
        
        [typeTitle,
         minTempTitle,
         maxTempTitle,
         windSpeedTitle,
         windDirectionTitle,
         rainfallTitle,
         pressureTitle].forEach {
            $0?.textColor = .gray
        }
        
        typeTitle.text = "Type: ".uppercased()
        minTempTitle.text = "Min temperature: ".uppercased()
        maxTempTitle.text = "Max temperature: ".uppercased()
        windSpeedTitle.text = "Wind speed: ".uppercased()
        windDirectionTitle.text = "Wind direction: ".uppercased()
        rainfallTitle.text = "Rainfall: ".uppercased()
        pressureTitle.text = "Pressure: ".uppercased()
        
        [typeValue,
         minTempValue,
         maxTempValue,
         windSpeedValue,
         windDirectionValue,
         rainfallValue,
         pressureValue].forEach {
            $0?.text = ""
            $0?.textColor = .customPurple
        }
    }
    
    private func bind(viewModel: ForecastViewModel) {
        imageView.image = UIImage(named: viewModel.iconName)
        typeValue.text = viewModel.typeTextValue
        minTempValue.text = viewModel.minTempTextValue
        maxTempValue.text = viewModel.maxTempTextValue
        windSpeedValue.text = viewModel.windSpeedTextValue
        windDirectionValue.text = viewModel.windDirectionTextValue
        rainfallValue.text = viewModel.rainfallTextValue
        pressureValue.text = viewModel.pressureTextValue
    }
}
