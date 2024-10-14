//
//  QuestionModels.swift
//  FigmaApp
//
//  Created by Narmin Baghirova on 11.10.24.
//

import Foundation

struct Question: Codable {
    let title: String
    let answer: [Answer]
}

struct Answer: Codable {
    let title: String
    let correct: Bool
}
