//
//  FeedViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation
import Combine

@MainActor
final class FeedStore: ObservableObject {
    @Published var items: [FeedItem] = Array(repeating: News.news1, count: 0)
    
    @Published var latestTweets: [Tweet] = []

    @Published var filter: FeedFilter = .all
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $filter.sink { [weak self] newFilter in
            guard let self = self else { return }
            self.getFeed(for: newFilter)
        }.store(in: &cancellables)
        
        getAUCATwitterFeed()
    }
    
    func setFilter(_ newFilter: FeedFilter) {
        guard filter != newFilter else { return }
        filter = newFilter
    }
    
    func getFeed(for filter: FeedFilter) {
        let announcements = Array(repeating: Announcement.example, count: 2)
        let resources = Array(repeating: RemoteResource.example, count: 2)
        let news = Array(repeating: News.news1, count: 4)
        
        var result = [FeedItem] ()
        switch filter {
        case .all:
            result = announcements + resources + news
        case .news:
            result = news
        case .resources:
            result = resources
        case .announcements:
            result = announcements
        }
        items = result.shuffled()
    }
    
    func getAUCATwitterFeed() {
        if let aucaTwitterID = TwitterFeed.getAUCAtwitterID(),
//           let url = URL(string: "https://api.twitter.com/2/users/\(aucaTwitterID)/tweets") {
           let url = requestURL(path: "/2/users/\(aucaTwitterID)/tweets").url {
            Task {
                
                do {
                    let result = try await TwitterFeed.request(url: url, cached: true)
                    print("Got result:", result.count)
                    latestTweets = result
                } catch {
                    print("Request failed:", error.localizedDescription)
                }
            }
        }
        
    }
    
    func requestURL(path: String) -> URLComponents {
//        attachments,conversation_id,author_id,in_reply_to_user_id,entities,
      let defaultParams = [
        URLQueryItem(name: "tweet.fields", value: "created_at"),
        URLQueryItem(name: "user.fields", value: "profile_image_url"),
//        URLQueryItem(name: "media.fields", value: "url,preview_image_url"),
//        URLQueryItem(name: "expansions", value: "attachments.media_keys,attachments.poll_ids,referenced_tweets.id,in_reply_to_user_id,author_id")
      ]
      
      var components = URLComponents()
      components.scheme = "https"
      components.host = "api.twitter.com"
      components.path = path
      components.queryItems = defaultParams
      
      return components
    }

    enum FeedFilter: String, CaseIterable {
        case all
        case news
        case announcements
        case resources
    }
}
