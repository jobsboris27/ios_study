//
//  ViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 30.11.2020.
//

import UIKit
import CoreGraphics

struct ValidationResult {
  static public var invalidLoginMessage = "Empty login"
  static public var invalidPasswordMessage = "Empty password"
  static public var invalidLoginOrPasswordMessage = "Wrong login or password"

  var message: String
  var valid: Bool
}

class LoginViewController: UIViewController {
  // MARK: IB Outlets
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var loginTextField: UITextField!

  // MARK: Private Properties
  private let user: User = User.getCurrentUser()

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTextFields()
    createDismissKeyboardTapGesture()
  }
  
  // MARK: Navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  guard segue.identifier == Constants.afterLoginSeugueId else { return }
  guard let tabBarController = segue.destination as? UITabBarController else { return }
  guard let destinationVC = tabBarController.viewControllers?.first as? AboutViewController else { return }
  
  tabBarController.selectedViewController = destinationVC
 }

  // MARK: IB Actions
  @IBAction func handleLogin(_ sender: Any) {
    view.endEditing(true)
    authenticate();
  }

  @IBAction func handleShowLogin(_ sender: Any) {
    showAlert(title: "Forgot User Name?", message: user.username)
  }
  
  @IBAction func handleShowPassword(_ sender: Any) {
    showAlert(title: "Forgot Password?", message: user.password)
  }

  // MARK: Private methods
  private func configureTextFields() {
    let textFields: [UITextField] = [
      loginTextField,
      passwordTextField
    ]
    
    textFields.forEach { [weak self] textField in
      guard let self = self else { return }

      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
      textField.leftView = paddingView
      textField.leftViewMode = UITextField.ViewMode.always
      let redPlaceholderText = NSAttributedString(string: textField.placeholder ?? "",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])

      textField.attributedPlaceholder = redPlaceholderText
      textField.delegate = self
    }
  }
      
  private func authenticate() {
    let validationResult = validateForm()

    if (validationResult.valid) {
      performSegue(withIdentifier: Constants.afterLoginSeugueId, sender: nil)
      return
    }
    
    showAlert(title: "Attention!", message: validationResult.message)
  }
  
  private func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
  }
}

// MARK: Extentions

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    if (textField.tag == loginTextField.tag) {
      passwordTextField.becomeFirstResponder()
    }

    if (textField.tag == passwordTextField.tag) {
      authenticate()
    }
    return true
  }
}

// MARK: Validate form
extension LoginViewController {
  func validateForm() -> ValidationResult {
    guard let loginText = loginTextField.text, !loginText.isEmpty else { return ValidationResult(message: ValidationResult.invalidLoginMessage, valid: false) }
    guard let passwordText = passwordTextField.text, !passwordText.isEmpty else { return ValidationResult(message: ValidationResult.invalidPasswordMessage, valid: false) }
    
    if user.username == loginText && user.password == passwordText {
      return ValidationResult(message: "Ok", valid: true)
    }

    return ValidationResult(message: ValidationResult.invalidLoginOrPasswordMessage, valid: false)
  }
}

// MARK: Shwo alert
extension LoginViewController {
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Thank you", style: .default, handler: nil))

    self.present(alert, animated: true)
  }
}
