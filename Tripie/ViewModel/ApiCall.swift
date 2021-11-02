//
//  ApiCall.swift
//  Tripie
//
//  Created by Jakub Kachlík on 24.10.2021.
//
import Foundation

class Api{
    @Published var places : APIAnswer?
    enum LoadErr: Error {
        case invalidURL
        case missingData
    }
    let defaultURL = "https://api.opentripmap.com/0.1/en/places/radius?"
    
    func loadRadius(radius:Int, lon:Double, lat:Double, limit:Int, apikey:String, completion:@escaping (Result<APIAnswer, Error>) -> Void) {
        let wholeURL = defaultURL + "radius=\(radius)&" + "lon=\(lon)&" + "lat=\(lat)&" + "limit=\(limit)&" + "apikey=\(apikey)"
        guard let url = URL(string: wholeURL)
        else{
            completion(.failure(LoadErr.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decodedData = try JSONDecoder().decode(APIAnswer.self, from: data!)
                completion(.success(decodedData))
                }
            catch let error{
                completion(.failure(error))
            }
        }.resume()
    }
}
