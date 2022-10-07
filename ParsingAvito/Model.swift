//
//  Model.swift
//  ParsingAvito
//
//  Created by Владимир Мирошин on 11.07.2022.
//

import Foundation

struct Root: Decodable {
    var company: Company
}

struct Company: Decodable {
    let name: String
    var employees: [Employees]
}

struct Employees: Decodable {
    let nameEmployee: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case nameEmployee = "name"
        case phoneNumber = "phone_number"
        case skills
    }
}
