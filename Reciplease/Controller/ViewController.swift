//
//  ViewController.swift
//  Reciplease
//
//  Created by Aurelien Waxin on 24/01/2022.
//

import UIKit
import Foundation


// MARK: - UIIMAGE Extension

extension UIImageView {
    func getImage(with url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

// MARK: - STRING Extension

extension String {
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}


// MARK: - UIVIEW Extension

  extension UIViewController {
        func presentAlert(){
            let alertVC = UIAlertController(title: "Oops", message: "Erreur de chargement", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(action)
            present(alertVC, animated: true, completion: nil)
        }
      func presentSafariAlert(){
          let alertVC = UIAlertController(title: "Oops", message: "Please download safari navigator", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertVC.addAction(action)
          present(alertVC,animated: true,completion: nil)
      }
      func presentRecipeAlert(){
      let alertVC = UIAlertController(title: "Oops", message: "Veuillez ajouter/supprimer un ingredient", preferredStyle: .alert)
      let action = UIAlertAction(title:"OK", style: .cancel, handler: nil)
      alertVC.addAction(action)
      present(alertVC,animated: true, completion: nil)
    }
  }

