//
//  CourseNetwork.swift
//  Cursos
//
//  Created by Lilian on 15/05/21.
//

import Foundation

class CourseNetwork {
    
    private let baseURL = "https://luanzeracourses.herokuapp.com"
    private let path = "/courses"
    
    func getCourses(completion: @escaping(Result<[Course], Error>) -> Void) {
        let fullUrl = baseURL + path
        guard let url = URL(string: fullUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                guard let data = data, let _ = response, error == nil else {
                    completion(.failure(NSError()))
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                print(json)
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                completion(.success(courses))
                
            } catch {
                print("Error do network", error)
                completion(.failure(error))
            }
        }.resume()
    }
}
