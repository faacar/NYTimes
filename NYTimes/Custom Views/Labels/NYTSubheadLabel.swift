//
//  NYTSubheadLabel.swift
//  NYTimes
//
//  Created by Ahmet Acar on 24.01.2021.
//

import UIKit

class NYTSubheadLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .semibold)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        text = "Test text"
        textColor = .systemGray2
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor = 0.65
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
