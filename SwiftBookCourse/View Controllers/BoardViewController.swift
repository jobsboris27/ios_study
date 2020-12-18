//
//  BoardViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 18.12.2020.
//

import UIKit

class BoardViewController: UIViewController {
  // MARK: Public Properties
  var boardColor: UIColor! {
    get {
      return view.backgroundColor
    }
    set {
      view.backgroundColor = newValue
    }
  }

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destVC = segue.destination as? SettingsViewController {
      destVC.setColor(color: boardColor)
      destVC.setColorDelegate = self
    }
  }
}

// MARK: Extentions
extension BoardViewController: SetColorDelegate {
  func setColor(color: UIColor) {
    boardColor = color
  }
}

