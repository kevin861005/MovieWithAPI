//
//  MovieData.swift
//  MovieWithAPI
//
//  Created by NAI LUN CHEN on 2023/4/16.
//

import Foundation

struct MovieData: Codable {
    let backdrop_path: String
    let id: Int
    let overview: String
    let title: String
    let release_date: String
}