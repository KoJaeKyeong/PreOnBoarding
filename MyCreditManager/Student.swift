//
//  Student.swift
//  MyCreditManager
//
//  Created by Jae Kyeong Ko on 2022/11/15.
//

import Foundation

final class Student {
    let name: String
    var courses: [Course]

    init(name: String, courses: [Course] = []) {
        self.name = name
        self.courses = courses
    }
}
