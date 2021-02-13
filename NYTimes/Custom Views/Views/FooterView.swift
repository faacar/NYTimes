//
//  FooterView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 30.01.2021.
//

import UIKit

class FooterView: UIView {
    
    lazy var apiButton = UIButton()
    let url = "https://developer.nytimes.com/"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        
        let logoImage = UIImage(named: Images.copyRightImages)

        apiButton.setImage(logoImage, for: .normal)
        apiButton.setTitle("", for: .normal)
        apiButton.sizeToFit()
        apiButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        apiButton.backgroundColor = .orange
        
        addSubview(apiButton)
        apiButton.translatesAutoresizingMaskIntoConstraints = false
        apiButton.contentMode = .center
        
        NSLayoutConstraint.activate([
            //apiButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            //apiButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            apiButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            apiButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            apiButton.topAnchor.constraint(equalTo: topAnchor),
            apiButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    @objc func buttonAction(sender: UIButton!) {
        UIApplication.shared.open(URL(string: url)!)
    }
    
}
