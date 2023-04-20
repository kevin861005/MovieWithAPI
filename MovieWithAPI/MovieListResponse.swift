//
//  MovieListResponse.swift
//  MovieWithAPI
//
//  Created by NAI LUN CHEN on 2023/4/16.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [MovieInfo]
    let total_pages: Int
    let total_results: Int
}
