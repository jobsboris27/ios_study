//
//  ViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 30.11.2020.
//

import UIKit

enum TrafficLightsState: Int {
  case initial = 0, red, yellow, green
}

struct Translations {
  static let initialButtonText = "Start"
  static let nextButtonText = "Next"
}

class ViewController: UIViewController {
  // MARK: IB Outlets
  @IBOutlet weak var redLight: UIView!
  @IBOutlet weak var yellowLight: UIView!
  @IBOutlet weak var greenLight: UIView!
  @IBOutlet weak var actionButton: UIButton!
  // MARK: Public Properties

  // MARK: Private Properties
  private lazy var allLights: [UIView] = [
    redLight,
    yellowLight,
    greenLight
  ]
  private var currentTrafficLightsState: TrafficLightsState = TrafficLightsState.initial

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButton()
    configureLights()

    turnOffLights()
  }

  // MARK: IB Actions
  @IBAction func changeTrafficLightsState(_ sender: UIButton) {
    changeCurrentTrafficLightsState()
    updateButtonText(by: currentTrafficLightsState)
    updateLights()
  }

  // MARK: Private Methods
  private func configureButton() {
    actionButton.layer.cornerRadius = 10
  }
  
  private func configureLights() {
    allLights.forEach { light in
      light.layer.cornerRadius = light.bounds.size.width / 2
    }
  }
  
  private func turnOffLights() {
    allLights.forEach { light in
      light.alpha = 0.3
    }
  }
  
  private func turnOnLight(light: UIView) {
    light.alpha = 1
  }
  
  private func changeCurrentTrafficLightsState() {
    let newValue = currentTrafficLightsState.rawValue + 1
    
    if let newState = TrafficLightsState(rawValue: newValue) {
      currentTrafficLightsState = newState
    } else {
      currentTrafficLightsState = TrafficLightsState.red
    }
  }
  
  private func updateButtonText(by state: TrafficLightsState) {
    actionButton?.setTitle(
      state == TrafficLightsState.initial ?
        Translations.initialButtonText :
        Translations.nextButtonText,
      for: .normal
    )
  }
  
  private func updateLights() {
    turnOffLights()

    switch currentTrafficLightsState {
    case .red:
      turnOnLight(light: redLight)
      break
    case .yellow:
      turnOnLight(light: yellowLight)
      break
    case .green:
      turnOnLight(light: greenLight)
      break
    default: break
    }
  }
}

