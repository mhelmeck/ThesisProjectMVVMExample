//
//  MainTableViewCell.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public protocol MainTableViewCellDelegate: class {
    func mainTableViewCellDidTapNavigationButton(_ cell: MainTableViewCell)
}

public class MainTableViewCell: UITableViewCell {
    // Properties
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    weak public var delegate: MainTableViewCellDelegate?
    public var viewModel: MainTableCellViewModel! {
        didSet {
            bind(viewModel: viewModel)
        }
    }
    
    // Init
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Public methods
    @IBAction public func navigationButtonTapped(_ sender: Any) {
        delegate?.mainTableViewCellDidTapNavigationButton(self)
    }
    
    // Private methods
    private func setupView() {
        self.selectionStyle = .none
    }
    
    private func bind(viewModel: MainTableCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        tempLabel.text = viewModel.temperature
        iconImageView.image = UIImage(named: viewModel.iconName)
    }
}
