//
//  TwitterFeed.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/05/2023.
//

import Foundation

struct AUCAConfig : Codable {
    var twitterBearToken: String
    var aucaTwitterID: String
}

final class TwitterFeed {
    private static let aucaConfigFile = "AUCAConfig"
    
    private static func getBearerToken() -> String? {
        if let settingsPath = Bundle.main.path(forResource: aucaConfigFile, ofType: "plist"),
           let xml = FileManager.default.contents(atPath: settingsPath),
           let plist = try? PropertyListDecoder().decode(AUCAConfig.self, from: xml) {
            return plist.twitterBearToken
        }
        
        return nil
    }
    
    static func getAUCAtwitterID() -> String? {
        if let settingsPath = Bundle.main.path(forResource: aucaConfigFile, ofType: "plist"),
           let xml = FileManager.default.contents(atPath: settingsPath),
           let plist = try? PropertyListDecoder().decode(AUCAConfig.self, from: xml) {
            return plist.aucaTwitterID
        }
        
        return nil
    }
    
    private static func decode<T: Decodable>(_ json: Data) throws -> T {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: json)
    }
    
    static func request(url: URL, cached: Bool = true) async throws -> [Tweet] {
        guard let bearerToken = TwitterFeed.getBearerToken(),
              !bearerToken.isEmpty else {
            throw(TwitterRequestError.missingBearerToken)
        }
        
        if cached,
           let data = FileCache.read(url),
           let body: [Tweet] = try? TwitterFeed.decode(data) {
            return body
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let body: TweetData = try TwitterFeed.decode(data)
        
        if cached {
            FileCache.write(url, data: data)
        }
        
        return body.data
    }

    enum TwitterRequestError: Error {
        case missingBearerToken
    }
}
