//
//  FileCache.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/05/2023.
//

import Foundation
import CryptoKit

enum FileCache {
    // Write data to the cache file with the given URL
    static func write(_ url: URL, data: Data) -> Void {
        // Get the cache directory URL for the current user
        
        if let fileManager = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            // Generate a unique file name for the cache file based on the URL hash
            let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
            let cacheFile = fileManager.appendingPathComponent("\(hash).json")
            
            // Write the data to the cache file using atomic write to avoid data corruption
            try? data.write(to: cacheFile, options: .atomicWrite)
        }
    }
    
    // Read data from the cache file with the given URL
    static func read(_ url: URL) -> Data? {
        // Generate a unique file name for the cache file based on the URL hash
        let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
        
        // Get the cache directory URL for the current user
        if let fileManager = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
           // Check if a cache file with the same name as the hash exists in the cache directory
           let cachedResponse = try? Data(contentsOf: fileManager.appendingPathComponent("\(hash).json")) {
            // Return the cached data if found
            return cachedResponse
        }
        // Return nil if no cache file is found
        return nil
    }
}
