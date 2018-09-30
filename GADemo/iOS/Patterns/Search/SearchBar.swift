//
//  SearchBar.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit

public class SearchBar: UISearchBar, UISearchBarDelegate {
    
    /// Throttle engine
    var throttler: Throttler? = nil
    
    /// Throttling interval
    public var throttlingInterval: Double? = 0 {
        didSet {
            guard let interval = throttlingInterval else {
                self.throttler = nil
                return
            }
            self.throttler = Throttler(seconds: Int(interval))
        }
    }
    
    /// Event received when cancel is pressed
    public var onCancel: (() -> (Void))? = nil
    
    /// Event received when a change into the search box is occurred
    public var onSearch: ((String) -> (Void))? = nil
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    
    
    
}

extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
}


extension UISearchBar {
    func changeSearchBarColor(color : UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                
                if let _ = subSubView as? UITextInputTraits {
                    let textField = subSubView as! UITextField
                    textField.textColor = UIColor.white
                    textField.backgroundColor = color
                    break
                }
                
            }
        }
    }
}
