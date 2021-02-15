//
//  CompanyInfoView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 14.02.2021.
//

import UIKit

class CompanyInfoView: UIView {

    let companylogoImageView = UIImageView(frame: .zero)
    let companyNameLabel = NYTBodyLabel(textAlignment: .center, fontSize: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(logoName: String, companyName: String) {
        super.init(frame: .zero)
        
        companylogoImageView.image = UIImage(named: logoName)
        companyNameLabel.text = companyName
        
        configureUI()
    }
    
    private func configureUI() {
        
        companylogoImageView.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(companylogoImageView)
        addSubview(companyNameLabel)
        
        NSLayoutConstraint.activate([
            companylogoImageView.heightAnchor.constraint(equalToConstant: 40),
            companylogoImageView.widthAnchor.constraint(equalToConstant: 40),
            companylogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companylogoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            
            companyNameLabel.heightAnchor.constraint(equalToConstant: 30),
            companyNameLabel.widthAnchor.constraint(equalToConstant: 40),
            companyNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companyNameLabel.topAnchor.constraint(equalTo: companylogoImageView.bottomAnchor)
            
        ])
    }
}
