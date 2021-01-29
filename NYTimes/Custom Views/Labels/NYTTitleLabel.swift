//
//  NYTTitleLabel.swift
//  NYTimes
//
//  Created by Ahmet Acar on 24.01.2021.
//

import UIKit

class NYTTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .semibold)
        configure()
    }
    
    private func configure() {
        text = "Test text"
        textColor = .label
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
