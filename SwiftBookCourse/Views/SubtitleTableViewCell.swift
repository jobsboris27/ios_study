//
//  SubtitleTableViewCell.swift
//  SwiftBookCourse
//
//  Created by Boris on 13.12.2020.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
