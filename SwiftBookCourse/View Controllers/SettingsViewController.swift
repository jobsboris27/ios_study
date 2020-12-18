//
//  ViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 30.11.2020.
//

import UIKit

protocol SetColorDelegate: AnyObject {
  func setColor(color: UIColor)
}

class SettingsViewController: UIViewController {
  // MARK: IB Outlets
  @IBOutlet var redTextField: UITextField!
  @IBOutlet var greenTextField: UITextField!
  @IBOutlet var blueTextField: UITextField!

  @IBOutlet var redUISlider: UISlider!
  @IBOutlet var greenUISlider: UISlider!
  @IBOutlet var blueUISlider: UISlider!

  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var board: UIView!
  
  // MARK: Public Properties
  var currentColor: UIColor!
  weak var setColorDelegate: SetColorDelegate?

  // MARK: Private Properties
  private let redSliderTag = 0
  private let greenSliderTag = 1
  private let blueSliderTag = 2
  
  private var redSliderValue = 0
  private var greenSliderValue = 0
  private var blueSliderValue = 0

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createDismissKeyboardTapGesture()
    
    redTextField.delegate = self
    greenTextField.delegate = self
    blueTextField.delegate = self

    updateUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override func viewWillLayoutSubviews() {
    configureBoard()
    drawOnBoard()
  }

  // MARK: IB Actions
  @IBAction func handleDone() {
    // QUESTION: почему не работает просто dissmiss?
    navigationController?.popViewController(animated: true)

    setColorDelegate?.setColor(color: currentColor)
  }

  @IBAction func changeColor(_ sender: Any) {
    guard let slider = sender as? UISlider else { return }
    view.endEditing(true)

    let sliderValue = Int(slider.value)
    let sliderValueAsText = String(sliderValue)

    switch slider.tag {
    case redSliderTag:
      redLabel.text = sliderValueAsText
      redTextField.text = sliderValueAsText
      redSliderValue = sliderValue
      break
    case greenSliderTag:
      greenLabel.text = sliderValueAsText
      greenTextField.text = sliderValueAsText
      greenSliderValue = sliderValue
      break
    case blueSliderTag:
      blueLabel.text = sliderValueAsText
      blueTextField.text = sliderValueAsText
      blueSliderValue = sliderValue
      break
    default: break
    }

    drawOnBoard()
  }
  
  // MARK: Private methods
  private func configureBoard() {
    board.layer.cornerRadius = 9
  }

  private func configureLabels() {
    redLabel.text = String(redSliderValue)
    greenLabel.text = String(greenSliderValue)
    blueLabel.text = String(blueSliderValue)
  }
  
  private func configureSliders() {
    redUISlider.value = Float(redSliderValue)
    greenUISlider.value = Float(greenSliderValue)
    blueUISlider.value = Float(blueSliderValue)
  }
  
  private func configureTextFields() {
    redTextField.text = String(redSliderValue)
    greenTextField.text = String(greenSliderValue)
    blueTextField.text = String(blueSliderValue)
  }

  private func drawOnBoard() {
    currentColor = UIColor(
      red: CGFloat(redSliderValue)/255.0,
      green: CGFloat(greenSliderValue)/255.0,
      blue: CGFloat(blueSliderValue)/255.0,
      alpha: 1
    )
    board.backgroundColor = currentColor
  }
  
  private func updateUI() {
    configureLabels()
    configureSliders()
    configureTextFields()
    drawOnBoard()
  }
  
  private func createDismissKeyboardTapGesture() {
   let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
   view.addGestureRecognizer(tap)
  }
}

// MARK: Extentions
extension SettingsViewController {
  private func getTextFieldValue(textField: UITextField, slider: UISlider) -> Int {
    let textFieldValue = Int(textField.text!) ?? 0
    let max = Int(slider.maximumValue)
    let min = Int(slider.minimumValue)

    if (textFieldValue > max) {
      textField.text = String(max)
      return max
    }
    
    if (textFieldValue < min) {
      textField.text = String(min)
      return min
    }

    return textFieldValue
  }
  
  private func setSliderValues(by textField: UITextField) {
    switch textField {
    case redTextField:
      redSliderValue = getTextFieldValue(textField: textField, slider: redUISlider)
      break
    case greenTextField:
      greenSliderValue = getTextFieldValue(textField: textField, slider: greenUISlider)
      break
    case blueTextField:
      blueSliderValue = getTextFieldValue(textField: textField, slider: blueUISlider)
      break
    default: break
    }
  }
}

// MARK: SetColorDelegate
extension SettingsViewController: SetColorDelegate {
  func setColor(color: UIColor) {
    currentColor = color

    if let rgb = color.rgb() {
      redSliderValue = rgb.red
      greenSliderValue = rgb.green
      blueSliderValue = rgb.blue
    }
  }
}

// MARK: UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()

    setSliderValues(by: textField)
    updateUI()

    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    setSliderValues(by: textField)
    updateUI()
  }
}
