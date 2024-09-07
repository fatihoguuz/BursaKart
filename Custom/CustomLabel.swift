//
//  CustomLabel.swift
//  BursaKart
//
//  Created by Fatih Oğuz on 6.09.2024.
//

import Foundation
import UIKit

class CustomLabel : UILabel {
   
    init(text: String, textColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 17)) {
          super.init(frame: .zero)
          self.text = text
          self.textColor = textColor
          self.font = font
          self.translatesAutoresizingMaskIntoConstraints = false // Auto Layout için gerekli
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
