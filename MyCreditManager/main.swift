//
//  main.swift
//  MyCreditManager
//
//  Created by Jae Kyeong Ko on 2022/11/15.
//

import Foundation

var flag = true
var students = [Student]()
let grades = ["A+": 4.5, "A": 4, "B+": 3.5, "B": 3, "C+": 2.5, "C": 2, "D+": 1.5, "D": 1, "F": 0]

selectFunction()

func selectFunction() {
    while flag {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")

        guard let input = readLine() else { return }

        switch input {
        case "1":
            addStudent()
        case "2":
            deleteStudent()
        case "3":
            addGrade()
        case "4":
            deleteGrade()
        case "5":
            averageOfGrades()
        case "X":
            print("프로그램을 종료합니다...")
            flag = false
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")

    guard let name = readLine() else { return }

    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시확인해주세요.")
    } else if !students.filter({ $0.name == name }).isEmpty {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else {
        students.append(Student(name: name))
        print("\(name) 학생을 추가했습니다.")
    }
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")

    guard let name = readLine() else { return }

    if let index = students.firstIndex(where: { $0.name == name }) {
        students.remove(at: index)
        print("\(name) 학생을 삭제하였습니다.")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func addGrade() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재한면 기존 점수가 갱신됩니다.")

    guard let input = readLine()?.components(separatedBy: " "),
          input.count == 3,
          grades.keys.contains(where: { $0 == input[2] }) else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }

    let name = input[0]
    let subject = input[1]
    let grade = input[2]

    let student = students.first(where: {$0.name == name })

    if student?.courses.first(where: { $0.subject == subject }) != nil {
        let course = student?.courses.first(where: { $0.subject == subject })
        course?.grade = grade
    } else {
        student?.courses.append(Course(subject: subject, grade: grade))
    }

    print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
}

func deleteGrade() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")

    guard let input = readLine()?.components(separatedBy: " "),
          input.count == 2 else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }

    let name = input[0]
    let subject = input[1]

    if students.contains(where: { $0.name == name }) {
        if let student = students.first(where: { $0.name == name }),
           let index = student.courses.firstIndex(where: { $0.subject == subject }) {
            student.courses.remove(at: index)
            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
        }
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func averageOfGrades() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")

    guard let name = readLine() else { return }

    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }

    if let student = students.first(where: { $0.name == name }) {
        var sumOfGrades = 0.0

        for course in student.courses {
            print("\(course.subject): \(course.grade)")
            sumOfGrades += grades[course.grade] ?? 0
        }

        print("평점 : \(sumOfGrades / Double(student.courses.count))")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}
