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
        if let customFont = UIFont(name: Fonts.domineRegular, size: fontSize) {
            self.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        text = "No text"
        textColor = .systemGray
        adjustsFontSizeToFitWidth = false
        font = UIFont.preferredFont(forTextStyle: .body)
        //minimumScaleFactor = 0.65
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

