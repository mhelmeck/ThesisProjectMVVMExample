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
            setupView()
        }
    }
    
    // Init
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Methods
    @IBAction public func navigationButtonTapped(_ sender: Any) {
        delegate?.mainTableViewCellDidTapNavigationButton(self)
    }
    
    private func setupView() {
        self.selectionStyle = .none
        
        cityNameLabel.text = viewModel.cityName
        tempLabel.text = viewModel.temp
        iconImageView.image = UIImage(named: viewModel.iconImageName)
    }
}
