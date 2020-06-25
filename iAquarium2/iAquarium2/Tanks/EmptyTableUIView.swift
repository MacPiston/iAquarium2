//
//  EmptyTableUIView.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 23/06/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation
import UIKit

class EmptyTableUIView: UIView {
    lazy var arrowSymbol: UIImageView = {
        let arrowSymbol = UIImageView()
        arrowSymbol.image = UIImage(systemName: "arrow.up")
        arrowSymbol.translatesAutoresizingMaskIntoConstraints = false
        return arrowSymbol
    }()
    
    lazy var arrowText: UILabel = {
       let arrowText = UILabel()
        arrowText.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        arrowText.text = "Add New Tank"
        arrowText.textAlignment = .center
        arrowText.translatesAutoresizingMaskIntoConstraints = false
        return arrowText
    }()
    
    lazy var arrowView: UIView = {
        let arrowView = UIView()
        arrowView.layer.shadowColor = UIColor.gray.cgColor
        arrowView.layer.shadowOffset = CGSize(width: 0, height: 10)
        arrowView.layer.shadowOpacity = 1
        arrowView.layer.shadowRadius = 10
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        arrowView.addSubview(arrowText)
        arrowView.addSubview(arrowSymbol)
        return arrowView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(arrowView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
        arrowText.topAnchor.constraint(equalTo: arrowView.topAnchor),
        arrowText.bottomAnchor.constraint(equalTo: arrowView.bottomAnchor),
        arrowText.leadingAnchor.constraint(equalTo: arrowView.leadingAnchor),
        arrowText.trailingAnchor.constraint(equalTo: arrowView.trailingAnchor),
        
        arrowSymbol.centerYAnchor.constraint(equalTo: arrowView.centerYAnchor),
        arrowSymbol.trailingAnchor.constraint(equalTo: arrowView.trailingAnchor, constant: -10),
        
        arrowView.topAnchor.constraint(equalTo: topAnchor),
        arrowView.leadingAnchor.constraint(equalTo: leadingAnchor),
        arrowView.trailingAnchor.constraint(equalTo: trailingAnchor),
        arrowView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
