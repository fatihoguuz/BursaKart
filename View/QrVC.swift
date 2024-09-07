//
//  QrVC.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 23.08.2024.
//

import Foundation
import UIKit

class QrVC: UIViewController {
    //MARK: - UIComponents
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private let cancelButton: CustomButton = CustomButton()
    private let topLabel = CustomLabel(text: "QR Kod ile Öde", textColor: .darkGray,font: UIFont(name: "Nunito-Bold", size: 30)!)
    private let underLabel = CustomLabel(text: "QR Kodunu cihaza okut", textColor: .darkGray, font: UIFont(name: "Nunito-Regular", size: 12)!)
    
    private var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var qrCodeTimer: Timer?
    
    let topPurseLabel = CustomLabel(text: "Kalan Bakiye",textColor: .darkGray,font: UIFont(name: "Nunito-Bold", size: 16)!)
    var purseButton: CustomButton = CustomButton()
    
    private let segmentedContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColorS.appGray
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor // Gölgenin rengi
        view.layer.shadowOpacity = 0.3 // Gölgenin opaklığı (0.0 - 1.0)
        view.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölgenin kaydırma miktarı
        view.layer.shadowRadius = 8 // Gölgenin yayılma yarıçapı
        return view
    }()
    
    private let segmentedControl : UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["QR Göster", "QR Oku"])
        segmented.selectedSegmentIndex = 0
        segmented.backgroundColor = AppColorS.appGray
        segmented.selectedSegmentTintColor = AppColorS.backgroundColor
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Nunito-Bold", size: 18) ?? nil
        ]
        segmented.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Nunito-ExtraBold", size: 18) ?? nil
        ]
        segmented.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    static let current: QrVC = QrVC()
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        setupConstraints()
        startQrCodeTimer()
        cancelButton.delegate = self
        tabBarController?.tabBar.isHidden = true
        if let tabBarController = tabBarController as? MainTabBarController {
            tabBarController.ovalView.isHidden = true
        }
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(cancelButton)
        view.addSubview(topLabel)
        view.addSubview(underLabel)
        view.addSubview(qrCodeImageView)
        view.addSubview(topPurseLabel)
        view.addSubview(purseButton)
        view.addSubview(segmentedContainerView)
        segmentedContainerView.addSubview(segmentedControl)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        purseButton.translatesAutoresizingMaskIntoConstraints = false
        
        topLabel.textAlignment = .center
        underLabel.textAlignment = .center
        topPurseLabel.textAlignment = .center
        
        purseButton.updateButtonHeight(50)
        
        cancelButton.configure(
            backgroundColor: AppColorS.noColor,
            cornerSettings: 40,
            addImage: UIImage(systemName: "multiply.circle.fill")?.withTintColor(AppColorS.appRed, renderingMode: .alwaysOriginal),
            pointSize: 40
        )
        purseButton.configure(
            backgroundColor: .white,
            title: "₺0,00",
            textColor: .black,
            cornerSettings: 0,
            pointSize: 30
        )
    }
    //MARK: - Constraints
    private func setupConstraints() {
        let viewHeight = UIScreen.main.bounds.height
        let buttonBottomPadding: CGFloat
        
        if viewHeight >= 896 { // Büyük ekranlar (iPhone 11 gibi)
            buttonBottomPadding = 55
        } else if viewHeight >= 844 { // Orta boy ekranlar (iPhone 15 gibi)
            buttonBottomPadding = 55
        } else if viewHeight >= 667 { // Küçük ekranlar (iPhone SE gibi)
            buttonBottomPadding = -5
        } else {
            buttonBottomPadding = -5 // Daha küçük cihazlar için varsayılan
        }
        NSLayoutConstraint.activate([
            // BackgroundView Constraints
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // CancelButton Constraints
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: buttonBottomPadding),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 100),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            
            // TopLabel Constraints
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            topLabel.heightAnchor.constraint(equalToConstant: 40),
            topLabel.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 60),
            
            // UnderLabel Constraints
            underLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            underLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            underLabel.heightAnchor.constraint(equalToConstant: 30),
            underLabel.bottomAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 25),
            
            // QRCodeImageView Constraints
            qrCodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCodeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 280),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 280),
            
            // TopPurseLabel Constraints
            topPurseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            topPurseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            topPurseLabel.heightAnchor.constraint(equalToConstant: 25),
            topPurseLabel.bottomAnchor.constraint(equalTo: purseButton.topAnchor, constant: -5),
            
            // PurseButton Constraints
            purseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            purseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -145),
            purseButton.heightAnchor.constraint(equalToConstant: 60),
            purseButton.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -buttonBottomPadding),
            
            // SegmentedContainerView Constraints
            segmentedContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            segmentedContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            segmentedContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -25),
            segmentedContainerView.heightAnchor.constraint(equalToConstant: 75),
            
            // SegmentedControl Constraints
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedContainerView.leadingAnchor, constant: -5),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedContainerView.trailingAnchor, constant: 5),
            segmentedControl.topAnchor.constraint(equalTo: segmentedContainerView.topAnchor, constant: -5),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedContainerView.bottomAnchor, constant: 5),
    // QR sistemi eklemedigim icin segmentedControl aktif calismiyor 
        ])
    }
    //MARK: - QRImage
    private func startQrCodeTimer() {
        updateQrCode()
        qrCodeTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateQrCode), userInfo: nil, repeats: true)
    }
    
    @objc private func updateQrCode() {
        let qrCodeString = generateRandomQrCodeString()
        if let qrCodeImage = generateQRCode(from: qrCodeString) {
            qrCodeImageView.image = qrCodeImage
        }
    }
    private func generateRandomQrCodeString() -> String {
        return UUID().uuidString
    }
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    deinit {
        qrCodeTimer?.invalidate()
    }
}
//MARK: - Selectors
extension QrVC: CustomButtonDelegate{
    func didTapButton(_ button: CustomButton) {
        
        let secondVC = HomeVC()
        if let mainTabBarController = tabBarController as? MainTabBarController {
            mainTabBarController.selectedIndex = 0
            mainTabBarController.tabBar.isHidden = false
            mainTabBarController.ovalView.isHidden = false
        }
    }
}
