//
//  HomeVC.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 23.08.2024.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    //MARK: - UIComponents
    
    private let profileButton: CustomButton = CustomButton()
    private let rightButton: CustomButton = CustomButton()
    private let searchButton: CustomButton = CustomButton()
    private let favoriteButton: CustomButton = CustomButton()
    private let bigButton: CustomButton = CustomButton()
    private let firstButton: CustomButton = CustomButton()
    private let secondButton: CustomButton = CustomButton()
    private let thirdButton: CustomButton = CustomButton()

    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = AppColorS.backgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AppColorS.noColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = AppColorS.noColor
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let editLabel: UILabel = {
        let label = UILabel()
        let fullText = "Yakın Duraklar ⟳"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let boldFont = UIFont(name: "Nunito-ExtraBold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        let normalFont = UIFont(name: "Nunito-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
        let refreshFont = UIFont(name: "Nunito-ExtraBold", size: 28) ?? UIFont.boldSystemFont(ofSize: 28)
        
        let boldRange = (fullText as NSString).range(of: "Yakın")
        attributedString.addAttribute(.font, value: boldFont, range: boldRange)
        
        let normalRange = (fullText as NSString).range(of: "Duraklar")
        attributedString.addAttribute(.font, value: normalFont, range: normalRange)
        
        let refreshRange = (fullText as NSString).range(of: "⟳")
        attributedString.addAttribute(.font, value: refreshFont, range: refreshRange)
        
        label.attributedText = attributedString
        label.textColor = .white
        
        return label
    }()
    private let editSearchLabel: UILabel = {
        let label = UILabel()

        let fullText = "Hat veya durak ara"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "Hat veya durak")
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)

        label.attributedText = attributedString
        return label
    }()
    let topLabel = CustomLabel(text: "Nereye?", textColor: .white,font: UIFont(name: "Nunito-ExtraBold", size: 37)!)
//tanimlamalarimizi yaptik
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let buttonHeight = view.bounds.height * 0.25
        let searchHeight = view.bounds.height * 0.12
        profileButton.updateButtonHeight(50)
        searchButton.updateButtonHeight(searchHeight)
        searchButton.updateCornerRadius(28)
        rightButton.updateButtonHeight(searchHeight)
        rightButton.updateCornerRadius(28)
        favoriteButton.updateButtonHeight(60)
        favoriteButton.updateCornerRadius(30)
        bigButton.updateButtonHeight(buttonHeight)
        bigButton.updateCornerRadius(25)
        firstButton.updateButtonHeight(115)
        secondButton.updateButtonHeight(115)
        thirdButton.updateButtonHeight(115)
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(profileButton)
        view.addSubview(bigButton)
        view.addSubview(favoriteButton)
        view.addSubview(searchButton)
        view.addSubview(rightButton) 
        view.addSubview(topLabel)
        view.addSubview(editLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(thirdButton)
                
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        bigButton.translatesAutoresizingMaskIntoConstraints = false
        
       
    }
    //MARK: - Constraints
    private func setupConstraints() {

        let screenHeight = UIScreen.main.bounds.height
        let spacingBetweenBigButtonAndStackView: CGFloat

//ekranlara gore araliklari belirliyoruz
        if screenHeight >= 896 {
            spacingBetweenBigButtonAndStackView = 230
        } else if screenHeight >= 844 {
            spacingBetweenBigButtonAndStackView = 230
        } else if screenHeight >= 736 {
            spacingBetweenBigButtonAndStackView = 210
        } else if screenHeight >= 667 {
            spacingBetweenBigButtonAndStackView = 180
        } else {
            spacingBetweenBigButtonAndStackView = 160
        }

        let viewHeight = UIScreen.main.bounds.height
        let buttonBottomPadding: CGFloat

        if viewHeight >= 896 {
            buttonBottomPadding = 120
        } else if viewHeight >= 844 {
            buttonBottomPadding = 112
        } else if viewHeight >= 667 {
            buttonBottomPadding = 90
        } else {
            buttonBottomPadding = 80
        }
        NSLayoutConstraint.activate([
//constraintlerimizi veriyoruz
            // BackgroundView Constraints
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 85),
            
            // ProfileButton Constraints
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            
            // TopLabel Constraints
            topLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: -53),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // SearchButton Constraints
            searchButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: -buttonBottomPadding),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            // RightButton Constraints
            rightButton.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            rightButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor, multiplier: 0.3),
            rightButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor),
            rightButton.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            
            // FavoriteButton Constraints
            favoriteButton.topAnchor.constraint(equalTo: bigButton.bottomAnchor, constant: -100),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // CentralLabel Constraints
            editLabel.topAnchor.constraint(equalTo: bigButton.bottomAnchor, constant: -39),
            editLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            editLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // BigButton Constraints
            bigButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -spacingBetweenBigButtonAndStackView),
            bigButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bigButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // ScrollView Constraints
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -45),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 120),
            
            // StackView Constraints
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.width + 40)
        ])
    }
//configure islemlerimizi yapiyoruz
    //MARK: - ConfigureButton
    private func configureButtons() {
        firstButton.configure(
                backgroundColor: AppColorS.addViewColor,
                title: "Dolum\nNoktaları",
                cornerSettings: 20,
                addImage: UIImage(systemName: "turkishlirasign.arrow.circlepath"),
                pointSize: 20,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .default,
                imageInsets: UIEdgeInsets(top: -60, left: 10, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 40, left: -40, bottom: 0, right: 0)
            )
        secondButton.configure(
                backgroundColor: AppColorS.addViewColor,
                title: "Sefer\nSaatleri",
                cornerSettings: 20,
                addImage: UIImage(systemName: "clock.fill"),
                pointSize: 20,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .default,
                imageInsets: UIEdgeInsets(top: -60, left: 1, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 40, left: -55, bottom: 0, right: 0)
            )
        thirdButton.configure(
                title: "Bakiye\nSorgulama",
                cornerSettings: 20,
                addImage: UIImage(systemName: "creditcard.circle"),
                pointSize: 20,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .default,
                imageInsets: UIEdgeInsets(top: -63, left: 20, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 40, left: -30, bottom: 0, right: 0)
            )
        bigButton.configure(
                backgroundColor: AppColorS.addViewColor,
                title: "İşleminiz şu anda gerçekleştirilemiyor. Lütfen daha sonra tekrar deneyiniz.",
                cornerSettings: 20,
                addImage: UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(AppColorS.appRed, renderingMode: .alwaysOriginal),
                pointSize: 40,
                imagePosition: .center,
                selectWeight: .bold,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: -90, left: 0, bottom: 0, right: -280),
                titleInsets: UIEdgeInsets(top: 50, left: -40, bottom: 0, right: 0)
            )
        profileButton.configure(
                backgroundColor: AppColorS.noColor,
                cornerSettings: 40,
                addImage: UIImage(systemName: "person.circle.fill")?.withTintColor(AppColorS.appGray, renderingMode: .alwaysOriginal),
                pointSize: 40
            )
        favoriteButton.configure(
                backgroundColor: AppColorS.appGreen,
                title: "Favorilerim",
                cornerSettings: 30,
                addImage: UIImage(systemName: "star.fill"),
                pointSize: 15,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: 0, left: -160, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
        rightButton.configure(
                backgroundColor: AppColorS.appGreen,
                cornerSettings: 30,
                cornerType: .topRight,
                addImage: UIImage(systemName: "qrcode.viewfinder"),
                pointSize: 30,
                imagePosition: .center
            )
        searchButton.configure(
                title: "Hat veya durak ara",
                cornerSettings: 30,
                cornerType: .topLeft,
                addImage: UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(AppColorS.appGreen, renderingMode: .alwaysOriginal),
                pointSize: 30,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
    }
}
/*
 let screenHeight = UIScreen.main.bounds.height
 let buttonBottomPadding: CGFloat
 // Ekran yüksekliğine göre dinamik padding hesaplama
 if screenHeight >= 796 { // iPhone 15 ve benzeri büyük ekranlar
     buttonBottomPadding = -screenHeight * 0.27
 } else { // Daha küçük ekranlar (iPhone SE gibi)
     buttonBottomPadding = -screenHeight * 0.33       }
 */
