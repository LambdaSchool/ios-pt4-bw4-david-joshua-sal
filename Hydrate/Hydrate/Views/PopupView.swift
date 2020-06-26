//
//  PopupView.swift
//  Hydrate
//
//  Created by Joshua Rutkowski on 6/17/20.
//  Copyright © 2020 Hydrate. All rights reserved.
//

import UIKit

class Popup: UIView {

    
    fileprivate let inputTextField: CustomTextField = {
       let textField = CustomTextField()
        textField.placeholder = "0.5"
        textField.backgroundColor = UIColor.undeadWhite
        textField.textColor = UIColor.sicklySmurfBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate let unitsLabel: UILabel = {
       let label = UILabel()
        label.text = "ounces"
        label.textColor = UIColor.sicklySmurfBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spacerView : UIView = {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    fileprivate let addWaterButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+1 cup", for: .normal )
        button.setTitleColor(UIColor.ravenClawBlue, for: .normal)
        button.backgroundColor = UIColor.undeadWhite
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height:4)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let addWaterButton2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.ravenClawBlue, for: .normal)
        button.backgroundColor = UIColor.undeadWhite
        button.setTitle("+2 cups", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height:4)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let addWaterButton3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+4 cups", for: .normal)
        button.setTitleColor(UIColor.ravenClawBlue, for: .normal)
        button.backgroundColor = UIColor.undeadWhite
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height:4)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let submitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "check-mark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(animateOut), for: .touchUpInside)


        return button
    }()

    fileprivate lazy var topHorizontalStackView: UIStackView = {
        let padding: CGFloat = 8
        let stack = UIStackView(arrangedSubviews: [spacerView, inputTextField, unitsLabel ])
        stack.spacing = padding
        stack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    fileprivate lazy var bottomHorizontalStackView: UIStackView = {
        let padding: CGFloat = 8

        let stack = UIStackView(arrangedSubviews: [addWaterButton1, addWaterButton2, addWaterButton3 ])
        stack.spacing = padding
        stack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    fileprivate let container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "RavenclawBlue")?.withAlphaComponent(0.75)
        view.isOpaque = false
        
        view.layer.cornerRadius = 24
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        
        applyBlurEffect()
        
        self.frame = UIScreen.main.bounds
        setupContainerView()

        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    fileprivate func setupContainerView() {
        self.addSubview(container)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))

        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        container.addSubview(bottomHorizontalStackView)
        bottomHorizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        bottomHorizontalStackView.isLayoutMarginsRelativeArrangement = true
        bottomHorizontalStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomHorizontalStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        bottomHorizontalStackView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        bottomHorizontalStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        bottomHorizontalStackView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        bottomHorizontalStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        container.addSubview(topHorizontalStackView)
        topHorizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        topHorizontalStackView.isLayoutMarginsRelativeArrangement = true
        topHorizontalStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive = true
        topHorizontalStackView.bottomAnchor.constraint(equalTo: bottomHorizontalStackView.topAnchor, constant: -8).isActive = true
        topHorizontalStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        topHorizontalStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        topHorizontalStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        topHorizontalStackView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        
        container.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: container.topAnchor, constant: -12).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 12).isActive = true
    }
    
    fileprivate func applyBlurEffect() {
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.isOpaque = false
            
        }
    }
    
    @objc fileprivate func animateOut() {

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0

        }) { (complete) in
            if complete {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1

        })
    }
}


