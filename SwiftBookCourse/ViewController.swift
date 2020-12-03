//
//  ViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 30.11.2020.
//

import UIKit


class ViewController: UIViewController {
  // MARK: IB Outlets
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var board: UIView!

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
    
    configureLabels()
    drawOnBoard()
  }

  // MARK: IB Actions
  @IBAction func changeColor(_ sender: Any) {
    guard let slider = sender as? UISlider else { return }

    let sliderValue = Int(slider.value)
    let sliderValueAsText = String(sliderValue)

    switch slider.tag {
    case redSliderTag:
      redLabel.text = sliderValueAsText
      redSliderValue = sliderValue
      break
    case greenSliderTag:
      greenLabel.text = sliderValueAsText
      greenSliderValue = sliderValue
      break
    case blueSliderTag:
      blueLabel.text = sliderValueAsText
      blueSliderValue = sliderValue
      break
    default: break
    }

    drawOnBoard()
  }
  
  // MARK: Private methods
  private func configureLabels() {
    redLabel.text = String(redSliderValue)
    greenLabel.text = String(greenSliderValue)
    blueLabel.text = String(blueSliderValue)
  }

  private func drawOnBoard() {
    board.backgroundColor = UIColor(red: CGFloat(redSliderValue)/255.0, green: CGFloat(greenSliderValue)/255.0, blue: CGFloat(blueSliderValue)/255.0, alpha: 1)
  }
}

