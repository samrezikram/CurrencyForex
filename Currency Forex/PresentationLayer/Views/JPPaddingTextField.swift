//
//  JPPaddingTextField.swift
//  JinglePay
//

import UIKit

class JPPaddingTextField: UITextField {
  
  var textPadding = UIEdgeInsets(top: 10, left: 70, bottom: 10, right: 20)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.textRect(forBounds: bounds)
    return rect.inset(by: textPadding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.editingRect(forBounds: bounds)
    return rect.inset(by: textPadding)
  }
  
  // Provides left padding for images
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += leftPadding
    return textRect
  }
  
  @IBInspectable var leftImage: UIImage? {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable var leftPadding: CGFloat = 0
  
  @IBInspectable var attributedPlaceholderColor: UIColor = UIColor.lightGray {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable var attributedPlaceholderFont: UIFont = UIFont(name: "Apple SD Gothic Neo", size: 15)! {
    didSet {
      updateView()
    }
  }
  
  func updateView() {
    if let image = leftImage {
      leftViewMode = UITextField.ViewMode.always
      let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
      imageView.contentMode = .scaleAspectFit
      imageView.image = image
      // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
      imageView.tintColor = attributedPlaceholderColor
      leftView = imageView
    } else {
      leftViewMode = UITextField.ViewMode.never
      leftView = nil
    }
    
    // Placeholder text color
    attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes: [NSAttributedString.Key.font: attributedPlaceholderFont, NSAttributedString.Key.foregroundColor: attributedPlaceholderColor])
  }
  
}
