//
//
//  Extension.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import Foundation
import UIKit

internal protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: StoryboardIdentifiable {
    
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case mainStoryBoard = "Main"
        case loginStoryBoard = "Login"
        case homeStoryBoard = "Home"
        case emergencyContactsStoryBoard = "EmergencyContacts"
        case editProfile = "EditProfile"
        case aboutUsStoryBoard = "AboutUs"
        case exploreStoryBoard = "Explore"
        
        var filename: String {
            return rawValue.description
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}

extension UIViewController {
    func openViewController<T: UIViewController>(controller: T.Type, storyBoard: UIStoryboard.Storyboard, handler: @escaping (T) -> Void) {
        let storyBoard = UIStoryboard(storyboard: storyBoard)
        let vc: T = storyBoard.instantiateViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        handler(vc)
    }
}



extension UITableView {
    func reloadDataInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setShadowTV(color: UIColor, offset: CGSize, opacity: Float) {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setCornerRadiusTV(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorderTV(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
}

extension UICollectionView {
    func reloadDataInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setShadowCV(color: UIColor, offset: CGSize, opacity: Float) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setCornerRadiusCV(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorderCV(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
}

extension UIView {
    func setShadow(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius =  radius
    }
    
    func setCornerRadius(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorder(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
    
    func setDashedBorderView(color: UIColor) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = color.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
}

extension UIButton {
    func setShadowButton(color: UIColor, offset: CGSize, opacity: Float) {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setCornerRadiusButton(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorderButton(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
    
    func setDashedBorderButton(color: UIColor) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = color.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
}

extension UIImageView {
    func setShadowImageView(color: UIColor, offset: CGSize, opacity: Float) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setCornerRadiusImageView(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorderImageView(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
    
    func setDashedBorderImageView(color: UIColor) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = color.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
}

extension UITextField {
    func setShadowTextField(color: UIColor, offset: CGSize, opacity: Float) {
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setCornerRadiusTextField(value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
    }
    
    func setBorderTextField(color: UIColor, size: CGFloat) {
        layer.borderWidth = size
        layer.borderColor = color.cgColor
    }
    
    func setDashedBorderTextField(color: UIColor) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = color.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                        self.lowerBound.encodedOffset)
    }
}
extension Bundle {
    
    class var applicationVersionNumber: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Version Number Not Available"
    }
    
    class var applicationBuildNumber: String {
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return build
        }
        return "Build Number Not Available"
    }
    
}

extension UIFont {

    public enum WorkSansType: String {
        case extraboldItalic = "-ExtraboldItalic"
        case semiboldItalic = "-SemiboldItalic"
        case semibold = "-Semibold"
        case regular = "-Regular"
        case lightItalic = "Light-Italic"
        case light = "-Light"
        case italic = "-Italic"
        case extraBold = "-Extrabold"
        case boldItalic = "-BoldItalic"
        case bold = "-Bold"
    }

    static func OpenSans(_ type: WorkSansType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "WorkSans\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}
