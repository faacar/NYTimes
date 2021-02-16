//
//  NYTStackView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 11.02.2021.
//

import UIKit

class NYTStackView: UIStackView {
    
    let leftLabel = NYTTitleLabel(fontSize: 14)
    let rightLabel = NYTBodyLabel(textAlignment: .left, fontSize: 17)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    init(leftLabel leftStringLabel: String, rightLabel rightStringLabel: String) {
        super.init(frame: .zero)
        
        leftLabel.text = leftStringLabel
        rightLabel.text = rightStringLabel
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = Colors.backgroundColor
        leftLabel.backgroundColor = .systemBackground
        rightLabel.backgroundColor = .systemBackground
        
        axis = .vertical
        addSubview(rightLabel)
        addSubview(leftLabel)
        NSLayoutConstraint.activate([
        
            topAnchor.constraint(equalTo: self.topAnchor),
            leadingAnchor.constraint(equalTo: self.leadingAnchor),
            trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heightAnchor.constraint(equalToConstant: 26),
            
            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor), //
            leftLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/10), //
            leftLabel.topAnchor.constraint(equalTo: self.topAnchor),
            leftLabel.heightAnchor.constraint(equalToConstant: 20),
            
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightLabel.topAnchor.constraint(equalTo: self.topAnchor),
            rightLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
