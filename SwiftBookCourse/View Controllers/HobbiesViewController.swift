//
//  NewsViewController.swift
//  SwiftBookCourse
//
//  Created by Boris on 11.12.2020.
//

import UIKit

class HobbiesViewController: UIViewController, UITableViewDelegate {
  // MARK: IB Outlets
  @IBOutlet var tableView: UITableView!
  // MARK: Private Properties
  private let user: User = User.getCurrentUser()

  // MARK: Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
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
}

// MARK: - Extentions

// MARK: - UITableViewDataSource
extension HobbiesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return user.hobbies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sharedCellId)!
    let hobbies = user.hobbies

    cell.textLabel?.text = hobbies[indexPath.row].label
    cell.detailTextLabel?.text = hobbies[indexPath.row].value
    cell.detailTextLabel?.numberOfLines = 0
    
    return cell
  }
}
