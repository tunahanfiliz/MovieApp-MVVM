//
//  Movie.swift
//  movieApp
//
//  Created by Ios Developer on 22.10.2022.
//

import Foundation

struct Movie: Decodable{
    let results: [MovieResult]?
    
}
struct MovieResult:Decodable{
    let id: Int?
    let posterPath: String?
    
    //detail kısmı
    let overview, releaseDate, title :String?
    
    enum CodingKeys: String,CodingKey{
        case id
        case posterPath = "poster_path"
        case overview , title
        case releaseDate = "release_date"
    }
    
    var _id: Int{
        id ?? Int.min  // id yoksa sıfır yap gibi
    }
    var _posterPath:String{
        posterPath ?? ""    // poster yoksa boş olsn
    }
    var _title: String{
        title ?? "N/A"
    }
    var _releaseDate : String {
        releaseDate ?? "N/A"
    }
    var _overview: String{
        overview ?? "There isn't overview"
    }
}
