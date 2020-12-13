//
//  User.swift
//  SwiftBookCourse
//
//  Created by Boris on 12.12.2020.
//

import Foundation

struct LabelValue {
  var label: String
  var value: String
}
struct User {
  var fullName: String
  var age: String
  var username: String
  var password: String
  var aboutInformation: [LabelValue]
  var hobbies: [LabelValue]
}

extension User {
  static func getCurrentUser() -> User {
    User(
      fullName: "Мухин Борис Леонидович",
      age: "32",
      username: "Boris",
      password: "test",
      aboutInformation: [
        LabelValue(label: "Должность", value: "Frontend/Backend developer(иногда и мобильная разработка)"),
        LabelValue(label: "Языки", value: "Javascript, Typescript, C#"),
        LabelValue(label: "Технологии Frontend", value: "Angular, React, Vue, Svelte, Stylus"),
        LabelValue(label: "Технологии Backend", value: "ASP.NET, Entity Framework"),
        LabelValue(label: "Технологии Mobile", value: "Xamarin")
      ],
      hobbies: [
        LabelValue(label: "Футбол", value: "Играть, смотреть, болеть"),
        LabelValue(label: "Шахматы", value: "Обучаюсь и играю"),
        LabelValue(label: "iOS", value: "Пытаюсь научиться делать крутые приложения"),
      ]
    )
  }
}
