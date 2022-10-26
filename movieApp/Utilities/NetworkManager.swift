//
//  NetworkManager.swift
//  movieApp
//
//  Created by Ios Developer on 22.10.2022.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    private init(){}
    
    
    @discardableResult //bunu yaparak movieServicedeki network.shared.downlaod... kodundaki dönüş tipi olan urlsessiondatatask ı kullanmak bizim insiyatifimize kaldı uyarı gitti.
    
    func download(url:URL,completion: @escaping (Result<Data,Error>) -> ()) -> URLSessionDataTask { //->URLSessionDataTaskı sonradan ekledik PosterImagede de kullanalım diye. böyle yazınca da mobile serviste network.shared.downlaod... kodunda uyarı veriyo o uyarıyı yukarda kaldırdık. @discardableResult ile
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            guard let data = data else{
                completion(.failure(URLError(.badURL)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
        return dataTask
    }
    
    
    
    
}
