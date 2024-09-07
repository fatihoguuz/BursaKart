//
//  ProfileVC.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 23.08.2024.
//

import Foundation
import UIKit


class ProfileVC: UIViewController {
    //MARK: - UIComponents
    private let backgroundView: UIView = {
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            return backgroundView
        }()
    private let profileButton: CustomButton = CustomButton()
    private let bakiyeButton: CustomButton = CustomButton()
    private let addButton: CustomButton = CustomButton()
    private let topLabel = CustomLabel(text: "Kartlarım",textColor: .darkGray,font: UIFont(name: "Nunito-ExtraBold", size: 35)!)
    private let myCarts: CustomButton = CustomButton()
    private let otherCarts: CustomButton = CustomButton()
    private let digitalButton: CustomButton = CustomButton()
    private let selectDigital: CustomButton = CustomButton()
    private let rightArrow: UIButton = {
        let arrowButton = UIButton(type: .system)
        arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        arrowButton.tintColor = .white
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        return arrowButton
    }()
    private let studentButton: CustomButton = CustomButton()
    private let selectedStudent: CustomButton = CustomButton()
    private let rightArrows: UIButton = {
        let arrowButton = UIButton(type: .system)
        arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        arrowButton.tintColor = .white
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        return arrowButton
    }()
    private let addTitle = CustomLabel(text: "TAM SANAL KART",textColor: AppColorS.darkGrayColor,font: UIFont(name: "Nunito-ExtraBold", size: 14.5)!)
    private let idLabel = CustomLabel(text: "0000 6000 3922 09",textColor: .darkGray,font: UIFont(name: "Nunito-Bold", size: 13.5)!)
    private let priceLabel = CustomLabel(text: "₺0,00", textColor: AppColorS.darkGrayColor , font: UIFont(name: "Nunito-Bold", size: 25)!)
    
    private let stuAddTitle = CustomLabel(text: "ÖĞRENCİ",textColor: AppColorS.darkGrayColor,font: UIFont(name: "Nunito-ExtraBold", size: 14.5)!)
    private let stuIdLabel = CustomLabel(text: "0000 6000 3922 10",textColor: .darkGray,font: UIFont(name: "Nunito-Bold", size: 13.5)!)
    private let stuPriceLabel = CustomLabel(text: "₺12,20", textColor: AppColorS.darkGrayColor , font: UIFont(name: "Nunito-Bold", size: 25)!)
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        setupConstraints()
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(profileButton)
        view.addSubview(bakiyeButton)
        view.addSubview(addButton)
        view.addSubview(topLabel)
        view.addSubview(myCarts)
        view.addSubview(otherCarts)
        view.addSubview(digitalButton)
        view.addSubview(selectDigital)
        view.addSubview(rightArrow)
        view.addSubview(studentButton)
        view.addSubview(selectedStudent)
        view.addSubview(rightArrows)
        view.addSubview(addTitle)
        view.addSubview(idLabel)
        view.addSubview(priceLabel)
        view.addSubview(stuAddTitle)
        view.addSubview(stuIdLabel)
        view.addSubview(stuPriceLabel)

        
        topLabel.textAlignment = .left
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        bakiyeButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        myCarts.translatesAutoresizingMaskIntoConstraints = false
        otherCarts.translatesAutoresizingMaskIntoConstraints = false
        digitalButton.translatesAutoresizingMaskIntoConstraints = false
        selectDigital.translatesAutoresizingMaskIntoConstraints = false
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        selectedStudent.translatesAutoresizingMaskIntoConstraints = false
        
        profileButton.updateButtonHeight(50)
        bakiyeButton.updateButtonHeight(40)
        addButton.updateButtonHeight(50)
        myCarts.updateButtonHeight(51)
        myCarts.updateCornerRadius(17)
        otherCarts.updateButtonHeight(51)
        otherCarts.updateCornerRadius(17)
        digitalButton.updateButtonHeight(135)
        digitalButton.updateCornerRadius(20)
        selectDigital.updateButtonHeight(95)
        selectDigital.updateCornerRadius(35)
        studentButton.updateButtonHeight(135)
        studentButton.updateCornerRadius(20)
        selectedStudent.updateButtonHeight(95)
        selectedStudent.updateCornerRadius(35)
        
        profileButton.configure(
                backgroundColor: AppColorS.noColor,
                cornerSettings: 40,
                addImage: UIImage(systemName: "person.circle.fill")?.withTintColor(AppColorS.blueColor, renderingMode: .alwaysOriginal),
                pointSize: 40
            )
        bakiyeButton.configure(
                backgroundColor: .white,
                title: "Bakiye Sorgula",
                textColor: .black,
                titleFontSize: 11,
                cornerSettings: 30,
                addImage: UIImage(systemName: "creditcard.circle.fill")!.withTintColor(AppColorS.appGray, renderingMode: .alwaysOriginal),
                pointSize: 28,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
        addButton.configure(
                backgroundColor: AppColorS.noColor,
                cornerSettings: 40,
                addImage: UIImage(systemName: "plus.circle.fill")?.withTintColor(AppColorS.addViewColor, renderingMode: .alwaysOriginal),
                pointSize: 40
            )
        
   // kart ekleme sistemi olmadigi icin butonlari islevsiz kullandim
        myCarts.configure(
                backgroundColor: AppColorS.addViewColor,
                title: "Benim Kartlarım",
                textColor: .white,
                titleFontSize: 15,
                cornerSettings: 0,
                addImage: UIImage(systemName: "person.circle.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal),
                pointSize: 30,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
        otherCarts.configure(
                backgroundColor: AppColorS.appGray,
                title: "Diğer Kartlarım",
                textColor: .darkGray,
                titleFontSize: 15,
                cornerSettings: 0,
                addImage: UIImage(systemName: "shared.with.you.circle.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal) ,
                pointSize: 30,
                imagePosition: .left,
                selectWeight: .medium,
                selectScale: .medium,
                imageInsets: UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0),
                titleInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            )
        digitalButton.configure(
                cornerSettings: 30,
                addImage: UIImage(named: "dijital")
            )
        selectDigital.configure(
            backgroundColor: AppColorS.lightRed,
                cornerSettings: 30,
                cornerType: .topRight
            )
        studentButton.configure(
                cornerSettings: 30,
                addImage: UIImage(named: "ogrenci")
            )
        selectedStudent.configure(
            backgroundColor: AppColorS.lightBlueColor,
                cornerSettings: 30,
                cornerType: .topRight
            )
}
    //MARK: - Constraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // BackgroundView Constraints
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 85),
            
            // ProfileButton Constraints
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            
            // BakiyeButton Constraints
            bakiyeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -35),
            bakiyeButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -10),
            bakiyeButton.widthAnchor.constraint(equalToConstant: 100),
            
            // AddButton Constraints
            addButton.bottomAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 70),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),
           
            // TopLabel Constraints
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            topLabel.heightAnchor.constraint(equalToConstant: 40),
            topLabel.bottomAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 70),
            
            // MyCarts Constraints
            myCarts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            myCarts.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            
            // OtherCarts Constraints
            otherCarts.leadingAnchor.constraint(equalTo: myCarts.trailingAnchor, constant: 10),
            otherCarts.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            otherCarts.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            
            myCarts.widthAnchor.constraint(equalTo: otherCarts.widthAnchor),
         
        
            // SelectDigital Constraints
            selectDigital.topAnchor.constraint(equalTo: myCarts.bottomAnchor, constant: 100),
            selectDigital.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // DigitalButton Constraints
            digitalButton.topAnchor.constraint(equalTo: selectDigital.topAnchor, constant: -20),
            digitalButton.trailingAnchor.constraint(equalTo: selectDigital.leadingAnchor),
            digitalButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            digitalButton.widthAnchor.constraint(equalTo: selectDigital.widthAnchor,multiplier: 0.34),
            digitalButton.heightAnchor.constraint(equalTo: selectDigital.heightAnchor),
            digitalButton.centerYAnchor.constraint(equalTo: selectDigital.centerYAnchor),
            
            // ArrowButton Constraints
            rightArrow.centerYAnchor.constraint(equalTo: selectDigital.centerYAnchor,constant: 45),
            rightArrow.trailingAnchor.constraint(equalTo: selectDigital.trailingAnchor, constant: -15),
            
            // SelectDigital Constraints
            selectedStudent.topAnchor.constraint(equalTo: digitalButton.bottomAnchor, constant: 180),
            selectedStudent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // DigitalButton Constraints
            studentButton.topAnchor.constraint(equalTo: selectedStudent.topAnchor, constant: -20),
            studentButton.trailingAnchor.constraint(equalTo: selectedStudent.leadingAnchor),
            studentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            studentButton.widthAnchor.constraint(equalTo: selectedStudent.widthAnchor,multiplier: 0.34),
            studentButton.heightAnchor.constraint(equalTo: selectedStudent.heightAnchor),
            studentButton.centerYAnchor.constraint(equalTo: selectedStudent.centerYAnchor),
            
            // ArrowButton Constraints
            rightArrows.centerYAnchor.constraint(equalTo: selectedStudent.centerYAnchor,constant: 48),
            rightArrows.trailingAnchor.constraint(equalTo: selectedStudent.trailingAnchor, constant: -15),
            
            // AddTitle Constraints
            addTitle.leadingAnchor.constraint(equalTo: selectDigital.leadingAnchor, constant: 20),
            addTitle.heightAnchor.constraint(equalToConstant: 30),
            addTitle.topAnchor.constraint(equalTo: selectDigital.topAnchor, constant: 10),
            
            // IDLabel Constraints
            idLabel.leadingAnchor.constraint(equalTo: selectDigital.leadingAnchor, constant: 20),
            idLabel.heightAnchor.constraint(equalToConstant: 30),
            idLabel.topAnchor.constraint(equalTo: addTitle.bottomAnchor, constant: -13),
            
            // PriceLabel Constraints
            priceLabel.leadingAnchor.constraint(equalTo: selectDigital.leadingAnchor, constant: 20),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: -5),
            
            // StuAddTitle Constraints
            stuAddTitle.leadingAnchor.constraint(equalTo: selectedStudent.leadingAnchor, constant: 20),
            stuAddTitle.heightAnchor.constraint(equalToConstant: 30),
            stuAddTitle.topAnchor.constraint(equalTo: selectedStudent.topAnchor, constant: 10),
            
            // StuIdLabel Constraints
            stuIdLabel.leadingAnchor.constraint(equalTo: selectedStudent.leadingAnchor, constant: 20),
            stuIdLabel.heightAnchor.constraint(equalToConstant: 30),
            stuIdLabel.topAnchor.constraint(equalTo: stuAddTitle.bottomAnchor, constant: -13),
            
            // StuPriceLabel Constraints
            stuPriceLabel.leadingAnchor.constraint(equalTo: selectedStudent.leadingAnchor, constant: 20),
            stuPriceLabel.heightAnchor.constraint(equalToConstant: 30),
            stuPriceLabel.topAnchor.constraint(equalTo: stuIdLabel.bottomAnchor, constant: -5),
        ])
    }
    }
