//
//  MainViewController.swift
//  Hydrate
//
//  Created by Joshua Rutkowski on 6/16/20.
//  Copyright © 2020 Hydrate. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Properties
    var wave: WaveAnimationView!
    // sets the current waterLevel for the wave animation. Values are 0.0...1.0.
    var waterLevel: Float = 0.7
    
    //MARK: - UI Components
    let addWaterIntakeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "water-button"), for: .normal)
        return button
    }()
    
    let showHistoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar-button"), for: .normal)
        button.tintColor = UIColor(named: "UndeadmWhite")
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 0.0);
        button.addTarget(self, action: #selector(handleShowHistoryTapped), for: .touchUpInside)
        return button
    }()
    
    let showSettingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings-button"), for: .normal)
        button.tintColor = UIColor(named: "UndeadmWhite")
        button.contentHorizontalAlignment = .right
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 20.0);
        button.addTarget(self, action: #selector(handleShowSettingsTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: view.bounds.size),
                                 color: UIColor.sicklySmurfBlue.withAlphaComponent(0.5))
        view.addSubview(wave)
        wave.startAnimation()
        wave.setProgress(waterLevel)
        print(waterLevel)
        print(wave.bounds.size.height)
        
        setupTapGestures()
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        wave.stopAnimation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Private
    
    /// Sets up long and short press tap gestures. Change default by using `numberofTapsRequired`.
    /// Change default duration by using `minimumPressDuration`
    fileprivate func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleNormalPress))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        addWaterIntakeButton.addGestureRecognizer(tapGesture)
        addWaterIntakeButton.addGestureRecognizer(longGesture)
        
        // UILongPressGestureRecognizer by default cancels touches in the hierarchy once recognized
        // The touch event on the UIButton is canceled and then becomes unhighlighted
        // set cancelsTouchesInView to false to change default behaviour
        longGesture.cancelsTouchesInView = false
    }
    
    /// Sets up programmatic views for view controller
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(named: "RavenclawBlue")
        view.addSubview(addWaterIntakeButton)
        addWaterIntakeButton.anchor(top: nil,
                                    leading: view.leadingAnchor,
                                    bottom: view.bottomAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        setupTopControls()
    }
    
    /// Sets up top stackView
    fileprivate func setupTopControls() {
        //sets a spacer between the left and right buttons, equally dividing the view by 3
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        
        let topControlsStackView = UIStackView(arrangedSubviews: [showHistoryButton, spacerView, showSettingsButton])
        
        view.addSubview(topControlsStackView)
        topControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        topControlsStackView.distribution  = .fillEqually
        
        NSLayoutConstraint.activate([
            topControlsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topControlsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //MARK: -  UIButton Methods
    @objc fileprivate func handleShowHistoryTapped() {
        let hvc = HistoryTableViewController()
        hvc.modalTransitionStyle = .flipHorizontal
        present(hvc, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleShowSettingsTapped() {
        let svc = SettingsTableViewController()
        svc.modalTransitionStyle = .flipHorizontal
        present(svc, animated: true, completion: nil)
    }
    
    @objc func handleNormalPress(){
        print("Normal tap")
    }
    
    /// Sets up the begin state of view animations when using UILongPressGestureRecognizer
    /// - Parameter sender: UILongPressGestureRecognizer
    fileprivate func handleGestureBegan(sender: UILongPressGestureRecognizer) {
        addWaterIntakeButton.isHighlighted = true
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

    }

    /// Sets up the changed state of view animations when using UILongPressGestureRecognizer
    /// - Parameter sender: UILongPressGestureRecognizer
    fileprivate func handleGestureChanged(sender: UILongPressGestureRecognizer) {

    }
    
    /// Sets up the changed state of view animations when using UILongPressGestureRecognizer
    /// - Parameter sender: UILongPressGestureRecognizer
    fileprivate func handleGestureEnded(sender: UILongPressGestureRecognizer) {
        let pop = Popup()
        self.view.addSubview(pop)
    }
    
    @objc func handleLongPress(sender : UILongPressGestureRecognizer){
        if sender.state == .ended {
            print("\(sender.state): ended")
            handleGestureEnded(sender: sender)
        } else if sender.state == .began {
            print("\(sender.state): began")
            handleGestureBegan(sender: sender)
        } else if sender.state == .changed {
            // Gets called if gesture state changes (i.e. moving finger/mouse)
            print("\(sender.state): is changing")
            handleGestureChanged(sender: sender)
        }
    }
}

extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let undeadWhite = UIColor(hex: 0xd8d8d8)
    static let sicklySmurfBlue = UIColor(hex: 0x4b8a9c)
    static let ravenClawBlue = UIColor(hex: 0x363e56)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
