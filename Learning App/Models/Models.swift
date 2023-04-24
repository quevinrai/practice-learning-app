//
//  Models.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/20/23.
//

import Foundation

struct Module: Identifiable, Decodable {
    var id: Int = 0
    var category: String = "[Category Name]"
    var content: Content = Content()
    var test: Test = Test()
}

struct Content: Identifiable, Decodable {
    var id: Int = 0
    var image: String = "swift"
    var time: String = "[Content Time]"
    var description: String = "[Content Description]"
    var lessons: [Lesson] = [Lesson()]
}

struct Lesson: Identifiable, Decodable {
    var id: Int = 0
    var title: String = "[Content > Lessons Title]"
    var video: String = "[Content > Lesons Video URL]"
    var duration: String = "[Content > Lessons Duration]"
    var explanation: String = "[Content > Lessons Explanation HTML]"
}

struct Test: Identifiable, Decodable {
    var id: Int = 0
    var image: String = "testSwift"
    var time: String = "[Test Time]"
    var description: String = "[Test Description]"
    var questions: [Question] = [Question()]
}

struct Question: Identifiable, Decodable {
    var id: Int = 0
    var content: String = "[Test > Content HTML]"
    var correctIndex: Int = 0
    var answers: [String] = ["Answer 1", "Answer 2", "Answer 3", "Answer 4"]
}
