//
//  CityCellView.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public protocol CityCellViewDelegate: class {
    func cityCellViewDidTapNavigationButton(_ cell: CityCellView)
}

public class CityCellView: UITableViewCell {
    // MARK: - Private properties
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    // MARK: - Public properties
    weak public var delegate: CityCellViewDelegate?
    public var viewModel: CityCellViewModel! {
        didSet {
            bind(viewModel: viewModel)
        }
    }
    
    // MARK: - Init
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    // MARK: - Public methods
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction public func navigationButtonTapped(_ sender: Any) {
        delegate?.cityCellViewDidTapNavigationButton(self)
    }
    
    // MARK: - Private methods
    private func setupView() {
        self.selectionStyle = .none
    }
    
    private func bind(viewModel: CityCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        tempLabel.text = viewModel.temperature
        iconImageView.image = UIImage(named: viewModel.iconName)
    }
}
