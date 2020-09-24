//
//  LocationInputView.swift
//  Uber
//
//  Created by Surya Chappidi on 21/09/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    //MARK: - Properties
    weak var delegate: LocationInputViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Surya Chappidi"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let endLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .systemGroupedBackground
        tf.isEnabled = false
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 8, width: 10)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private lazy var endingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Destination"
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 8, width: 10)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
        backgroundColor = .white
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44,
                          paddingLeft: 12, width: 24, height: 24)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(startingLocationTextField)
        startingLocationTextField.anchor(top: backButton.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 12,paddingLeft: 40,paddingRight: 40,height: 30)
        
        addSubview(endingLocationTextField)
        endingLocationTextField.anchor(top: startingLocationTextField.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 12,paddingLeft: 40,paddingRight: 40,height: 30)
        
        addSubview(startLocationIndicatorView)
        startLocationIndicatorView.centerX(inView: backButton)
        startLocationIndicatorView.centerY(inView: startingLocationTextField)
        startLocationIndicatorView.setDimensions(height: 6, width: 6)
        startLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        addSubview(endLocationIndicatorView)
        endLocationIndicatorView.centerX(inView: backButton)
        endLocationIndicatorView.centerY(inView: endingLocationTextField)
        endLocationIndicatorView.setDimensions(height: 6, width: 6)
        
        addSubview(linkingView)
        linkingView.centerX(inView: startLocationIndicatorView)
        linkingView.anchor(top:startLocationIndicatorView.bottomAnchor,bottom: endLocationIndicatorView.topAnchor,paddingTop: 4,paddingBottom: 4,width: 0.5)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
}
