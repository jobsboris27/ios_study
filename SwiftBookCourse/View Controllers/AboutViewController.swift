//
//  AboutViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 11.12.2020.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate {
  // MARK: IB Outlets
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  // MARK: Private Properties
  private let user: User = User.getCurrentUser()

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    configureTableView()
    configureTitleLabel()
  }
  
  // MARK: Private methods
  private func configureTableView() {
    tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: Constants.sharedCellId)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorInset = .zero
  }
  
  private func configureTitleLabel() {
    titleLabel.text = "\(user.fullName), \(user.age)"
  }
}

// MARK: - Extentions

// MARK: - UITableViewDataSource
extension AboutViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return user.aboutInformation.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sharedCellId)!
    let aboutInformation = user.aboutInformation

    cell.textLabel?.text = aboutInformation[indexPath.row].label
    cell.detailTextLabel?.text = aboutInformation[indexPath.row].value
    cell.detailTextLabel?.numberOfLines = 0
    
    return cell
  }
}
