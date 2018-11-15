//
//  AlertPresenter.swift
//  GADemo
//
//  Created by BMGH SRL on 14/11/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//


import UIKit

protocol Presentator {
    associatedtype Origin
    func present(_ origin: Origin)
}

enum Outcome {
    case accepted
    case rejected
}

struct AlertPresenter: Presentator {
    
    
    
    let title: String?
    let message: String?
    let okAction: String?
    let cancelAction: String?
 
    let handler: (Outcome) -> Void
    
    private func present(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        if let rejectTitle = cancelAction {
            if !rejectTitle.isEmpty {
                let rejectAction = UIAlertAction(title: rejectTitle, style: .cancel) { _ in
                    self.handler(.rejected)
                }
                alert.addAction(rejectAction)
            }
            
        }
        
        if let acceptTitle = okAction {
            if !acceptTitle.isEmpty {
                let acceptAction = UIAlertAction(title: acceptTitle, style: .default) { _ in
                    self.handler(.accepted)
                }
                alert.addAction(acceptAction)
            }
            
        }
        
        viewController.present(alert, animated: true)
    }
    
    func present(_ origin: UIViewController) {
        present(in: origin)
    }
    
}
