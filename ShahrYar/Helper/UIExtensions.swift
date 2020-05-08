//
//  UIExtensions.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/6/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }
}

extension Hashable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


class UIExtensions: UIViewController {

    
    static let shared = UIExtensions()
    
    fileprivate var currentVc: UIViewController?
    
    func hideNavigationBar(vc: UIViewController) {
        currentVc = vc
        currentVc?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        currentVc?.navigationController?.navigationBar.shadowImage = UIImage()
        currentVc?.navigationController?.navigationBar.isTranslucent = true
        currentVc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func setCornerRedius(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.width / 2
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    func stringifyFileName() -> String {
        let components = self.components(separatedBy: "/")
        if components.isEmpty {
            return ""
        }
        
        let fileName = components.last!.replacingOccurrences(of: ".swift", with: "", options: .literal, range: nil)
        return fileName
    }
    
    func toDate(withFormat format: String = "HH:mm:ss", calendar: Calendar = Calendar(identifier: .persian))-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    
    var toDouble: Double? {
        return Double(self)
    }
    
    var toDoubleIosVersion: Double? {
        
        
        if let iosVersion = Double(self) {
            return iosVersion
        }
        
        var arr = components(separatedBy: ".")
        if arr.count >= 1 {
            var integerPart = 0
            var floatPart = 0
            
            if let _integerPart = Int(arr[0]), !arr[0].isEmpty{
                integerPart = _integerPart
            }
            
            if let _floatPart = Int(arr[1]), !arr[1].isEmpty{
                floatPart = _floatPart
            }
            
            return Double("\(integerPart).\(floatPart)")
        }
        return nil
    }
    
    var numbers: String {
        return String(self.filter { "0"..."9" ~= $0 })
    }
    
    func openCall(){
        
        if let tURL = URL(string: "tel:\(self)") {
            UIApplication.shared.open(tURL , options: [:], completionHandler: nil)
        }
        
    }
    
    func openLink(){
        
        if let tURL = URL(string: self) {
            UIApplication.shared.open(tURL , options: [:], completionHandler: nil)
        }
        
    }
    
    func openEmail(){
        
        if let url = NSURL(string: "mailto:\(self)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    func isValidVerifyCode()-> Bool {
        let code = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard Int(code) != nil  else {
            return false
        }
        
        return true
    }

    
    func isValidPhoneNumber()-> Bool {
        
        var phone = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if phone.isEmpty {
            return false
        }
        
        phone = self.transformNumbersToEng()
        
        let phoneRegex = "^09[0-9'@s]{9,9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: phone)
        return result
        
    }
    
    func isValidEmail()-> Bool {
        
        var emailAddress = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if emailAddress.isEmpty {
            return false
        }
        
        
        emailAddress = self.transformNumbersToEng()
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailAddress)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var farsiNumbers: [String] {
        return ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"]
    }
    
    var arabicNumbers: [String] {
        return ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
    }
    
    func transformNumbersToFarsi() -> String {
        var tempStr = self
        for (idx, char) in self.farsiNumbers.enumerated() {
            tempStr = tempStr.replacingOccurrences(of: "\(idx)", with: char, options: NSString.CompareOptions.caseInsensitive, range: nil)
        }
        return tempStr
    }
    
    func transformNumbersToEng() -> String {
        var tempStr = self
        
        for (idx, char) in self.farsiNumbers.enumerated() {
            tempStr = tempStr.replacingOccurrences(of: char, with: "\(idx)", options: NSString.CompareOptions.caseInsensitive, range: nil)
        }
        
        for (idx, char) in self.arabicNumbers.enumerated() {
            tempStr = tempStr.replacingOccurrences(of: char, with: "\(idx)", options: NSString.CompareOptions.caseInsensitive, range: nil)
        }
        
        return tempStr
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        let range: Range<Index> = start..<end
        return String(self[range])
        //        return String(self[Range(start ..< end)])
    }
    
    var isLatin: Bool {
        
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"
        
        for c in self {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isFarsi: Bool {
        
        //Remove extra spaces from the first and last word
        let value = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if value == "" {
            return false
        }
        
        let farsiLetters = "آ ا ب پ ت ث ج چ ح خ د ذ ر ز ژ س ش ص ض ط ظ ع غ ف ق ک گ ل م ی ن و ه"
        let arabicLetters = " ء ا أ إ ء ؤ ئـ ئ آ اً ة ا ب ت ث ج ‌ ح خ د ذ ر ز س ‌ ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ى ڤ ي"
        for c in value {
            if !farsiLetters.contains(c) && !arabicLetters.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isBothLatinAndCyrillic: Bool {
        return self.isLatin && self.isFarsi
    }
    
    func isValidPassportNumber()-> Bool {
        
        var passportNumber = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if passportNumber.isEmpty{
            return false
        }
        
        passportNumber = passportNumber.transformNumbersToEng()
        
        let passportNumberRegex = "[a-zA-Z]{1}[0-9]{8}"
        let passportNumberTest = NSPredicate(format: "SELF MATCHES %@", passportNumberRegex)
        let result = passportNumberTest.evaluate(with: passportNumber)
        return result
        
    }
    
    func isValidNationalCode()-> Bool{
        
        var code = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if code.isEmpty{
            return false
        }
        
        code = code.transformNumbersToEng()
        var i = 0
        var temp = 0
        
        if Int(code) == nil {
            return false
        }
        
        if code.count != 10 {
            return false
        }
        
        for n in 0...9{
            
            var repet : String = ""
            
            for _ in 1...10{
                repet = "\(repet)\(n)"
            }
            
            if repet == code{
                return false
            }
        }
        
        
        for i in (2...10).reversed() {
            
            let start = 10 - i
            let end = 11 - i
            
            temp = temp + ((Int(code.substring(with: start..<end)))! * i )
            
        }
        
        i = temp % 11
        
        if i >= 2 {
            i=11-i
        }
        
        if i == Int(code.substring(with: 9..<10)) {
            return true
        }else{
            return false
        }
        
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
}


