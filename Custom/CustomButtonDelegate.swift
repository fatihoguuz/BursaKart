//
//  CustomView.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 25.08.2024.
//

import Foundation
import UIKit

protocol CustomButtonDelegate: AnyObject {
    func didTapButton(_ button: CustomButton)
}
class CustomButton: UIView {
    
    var delegate: CustomButtonDelegate?
    
    private var testButtonHeightConstraint: NSLayoutConstraint!

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColorS.noColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var testButton: UIButton = { 
        let button = UIButton()
        button.tintColor = .white
        button.setTitleColor(UIColor.white ,for: .normal)
        button.backgroundColor = AppColorS.addViewColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.layer.shadowColor = UIColor.black.cgColor // Gölgenin rengi
        button.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0.0 - 1.0)
        button.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölgenin kaydırma miktarı
        button.layer.shadowRadius = 8 // Gölgenin yayılma yarıçapı
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
      
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(testButton)
        
        testButtonHeightConstraint = testButton.heightAnchor.constraint(equalToConstant: 140)
        testButtonHeightConstraint.isActive = true
        testButton.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            testButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            testButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            testButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
        ])
        testButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    func updateCornerRadius(_ radius: CGFloat) {
        testButton.layer.cornerRadius = radius
        testButton.layer.masksToBounds = true
    }
    func updateButtonHeight(_ height: CGFloat) {
        testButtonHeightConstraint.constant = height
    }
    func configure(
        backgroundColor: UIColor? = AppColorS.addViewColor,
        title:String? = "",
        textColor: UIColor? = .white,
        titleFontSize: CGFloat? = nil,
        cornerSettings: CGFloat,
        cornerType: UIRectCorner? = nil,
        addImage: UIImage? = nil,
        pointSize: CGFloat? = nil,
        imagePosition: UIButton.ContentHorizontalAlignment? = nil,
        selectWeight: UIImage.SymbolWeight? = nil,
        selectScale: UIImage.SymbolScale? = nil,
        imageInsets: UIEdgeInsets = .zero,
        titleInsets: UIEdgeInsets = .zero
        
    ) {
        testButton.backgroundColor = backgroundColor
        testButton.setTitle(title, for: .normal)
        let finalTitleFontSize = titleFontSize ?? 19
        testButton.titleLabel?.font = UIFont(name: "Nunito-Bold", size: finalTitleFontSize)
        testButton.setTitleColor(textColor, for: .normal)
       
        if let addImage = addImage {
            
            let finalPointSize = pointSize ?? 30
            let finalWeight = selectWeight ?? .regular
            let finalScale = selectScale ?? .default
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: finalPointSize, weight: finalWeight, scale: finalScale)
            let largeImage = addImage.withConfiguration(largeConfig)
            testButton.setImage(largeImage, for: .normal)
            
            testButton.contentVerticalAlignment = .center
            testButton.contentHorizontalAlignment = .center
            testButton.imageEdgeInsets = imageInsets
            testButton.titleEdgeInsets = titleInsets
        }
        if let cornerType = cornerType {
                   switch cornerType {
                   case .topLeft, .bottomLeft:
                       testButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                   case .topRight, .bottomRight:
                       testButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                   default:
                       testButton.layer.maskedCorners = []
                  }
                 } else {
                   testButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}
//MARK: - Selectors
extension CustomButton {
    @objc private func didTapButton() {
        delegate?.didTapButton(self)
    }
}
