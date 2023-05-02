//
//  News.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 24/04/2023.
//

import Foundation

public typealias Codifiable = Codable & Identifiable

public protocol FeedItem {
    var id: String { get }
    var author: NewsAuthor? { get }
    var createdDate: Date { get }
}

public extension FeedItem {
    var author: NewsAuthor? { nil }
}

public struct News: FeedItem, Codifiable {
    public var id: String { UUID().uuidString }
    
    public let imageURL: URL?
    public let title: String
    public let subtitle: String?
    public let content: AttributedString
    
    public let images: [String]
    public let createdDate: Date
    public let author: NewsAuthor
    public let tags: [String]?
    
    public var isVerified: Bool = true
    public var likes: Int
    public let views: Int
}


public struct NewsAuthor: Codable {
    public let imageURL: URL?
    public let name: String
    public var headline: String?
    public let type: NewsAuthorType
    
    public enum NewsAuthorType: String, Codable {
        case `public`
        case personal
        case school
    }
}

extension NewsAuthor {
    static let school = NewsAuthor(imageURL: nil, name: "AUCA", headline: "Adventist University of Central Africa", type: .school)
    
    static let person = NewsAuthor(imageURL: nil, name: "Jane Doe", type: .public)
}

extension News {
    mutating func like() {
        likes += 1
    }
    
    mutating func dislike() {
        likes -= 1
    }
}

public struct RemoteResource: FeedItem, Codifiable {
    public let id: String
    public let name: String
    public let description: String
    public let fileURL: URL
    public let createdDate: Date
    public let updatedDate: Date?
    public let metadata: ResourceMetadata
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case fileURL = "url"
        case description
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case metadata
    }
}

public struct Announcement: FeedItem, Codifiable {
    public var id: String
    public var author: NewsAuthor
    public var content: String
    public var createdDate: Date = .now
    public var externalLink: URL?
}
extension Announcement {
    static let example = Announcement(id: UUID().uuidString, author: .person, content: "Hey folks.\n\nWe're moving our light winter celebration to the office patio on Thursday due to the recent uptick in COVID cases. We'll have heatlamps so you stay warm. Masks will still be required for this.")
}
public struct ResourceMetadata: Codable {
    public let type: ResourceFileType
    public let size: Int
    public let author: String
    public let keywords: [String]
}

extension ResourceMetadata {
    static let example = ResourceMetadata(type: .pdf,
                                          size: 1024,
                                          author: "John Doe",
                                          keywords: ["remote", "resource", "internet"])
    
    static let example2 = ResourceMetadata(type: .jpg, size: 2048, author: "Jane Doe", keywords: ["photo", "landscape", "mountain"])
    
}

public enum ResourceFileType: String, Codable {
    case pdf
    case jpg
    case other
}


extension RemoteResource {
    static let example = RemoteResource(id: "1234",
                                        name: "Remote Resource",
                                        description: "This is a remote resource that can be accessed over the internet.", fileURL: URL(string: "https://example.com/remote-resource")!,
                                        createdDate: Date(),
                                        updatedDate: Date(),
                                        metadata: .example)
    
    
    
    static let example2 = RemoteResource(id: "5678",
                                         name: "Mountain Photo",
                                         description: "This is a beautiful photo of a mountain landscape.", fileURL: URL(string: "https://example.com/mountain-photo.jpg")!,
                                         createdDate: Date(),
                                         updatedDate: Date(),
                                         metadata: .example2)
}

extension News {
    static let news1 = News(imageURL: URL(string: "auca1"),
                            title: "Example News 1",
                            subtitle: "An example subtitle for News 1",
                            content: News.description1,
                            images: ["auca1", "https://example.com/image2.jpg"],
                            createdDate: Date.now,
                            author: .school,
                            tags: ["example", "news", "swift"],
                            likes: 21,
                            views: 104)
    
    static let news2 = News(imageURL: URL(string: "jpg"),
                            title: "Example News 2",
                            subtitle: nil,
                            content: AttributedString("This is some example content for News 2"),
                            images: ["auca1"],
                            createdDate: .now,
                            author: .person,
                            tags: nil,
                            likes: 5,
                            views: 50)
    
    static let news3 = News(imageURL: nil,
                            title: "Example News 3",
                            subtitle: "An example subtitle for News 3",
                            content: AttributedString("This is some example content for News 3"),
                            images: [],
                            createdDate: .now,
                            author: NewsAuthor(imageURL: nil, name: "Bob Smith", type: .school),
                            tags: ["example"],
                            likes: 2,
                            views: 20)
    
    static var description1: AttributedString = {
        var str = AttributedString("@Bridge2Rwanda")
        str.link = URL(string: "https://github.com/AUCA-DEVELOPERS")
        str.foregroundColor = .accentColor
        
        return "Today, AUCA & " + str + "'s Bridge Talent Services, signed a MoU in areas of career devpt for students/graduates. The partnership will enhance education-to-employment approach, thus enabling students to learn, apply skills to build career mobility via job readiness workshops."
    }()
}


struct TweetData: Codable {
    let data: [Tweet]
}

struct Tweet: FeedItem, Codifiable {
    var createdDate: Date { createdAt }
    
    let id: String
    let text: String
    let createdAt: Date    
        
    var reference: URL {
        URL(string: "https://twitter.com/AUCA_Rwanda/status/\(id)")!
    }
}
