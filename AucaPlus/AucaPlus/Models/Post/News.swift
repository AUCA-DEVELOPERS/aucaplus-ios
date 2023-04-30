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
}

public struct News: FeedItem, Codifiable {
    public var id: String { UUID().uuidString }
    
    public let imageURL: URL?
    public let title: String
    public let subtitle: String?
    public let content: AttributedString
    
    public let images: [String]
    public let postedDate: String
    public let author: NewsAuthor
    public let tags: [String]?
    
    public var isVerified: Bool = true
    public var likes: Int
    public let views: Int
}


public struct NewsAuthor: Codable {
    public let name: String
    public var headline: String?
    public let type: NewsAuthorType
    
    public enum NewsAuthorType: String, Codable {
        case `public`
        case personal
        case school
    }
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
    public let url: URL
    public let description: String
    public let createdAt: Date
    public let updatedAt: Date
    public let metadata: ResourceMetadata
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case metadata
    }
}

public struct Announcement: FeedItem, Codifiable {
    public var id: String
    
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
                                        url: URL(string: "https://example.com/remote-resource")!,
                                        description: "This is a remote resource that can be accessed over the internet.",
                                        createdAt: Date(),
                                        updatedAt: Date(),
                                        metadata: .example)
    
    
    
    static let example2 = RemoteResource(id: "5678",
                                         name: "Mountain Photo",
                                         url: URL(string: "https://example.com/mountain-photo.jpg")!,
                                         description: "This is a beautiful photo of a mountain landscape.",
                                         createdAt: Date(),
                                         updatedAt: Date(),
                                         metadata: .example2)
}

extension News {
    static let news1 = News(imageURL: URL(string: "auca1"),
                            title: "Example News 1",
                            subtitle: "An example subtitle for News 1",
                            content: News.description1,
                            images: ["auca1", "https://example.com/image2.jpg"],
                            postedDate: "2022-04-25",
                            author: NewsAuthor(name: "AUCA", headline: "Adventist University of Central Africa", type: .school),
                            tags: ["example", "news", "swift"],
                            likes: 21,
                            views: 104)
    
    static let news2 = News(imageURL: URL(string: "jpg"),
                            title: "Example News 2",
                            subtitle: nil,
                            content: AttributedString("This is some example content for News 2"),
                            images: ["auca1"],
                            postedDate: "2022-04-24",
                            author: NewsAuthor(name: "Jane Doe", type: .public),
                            tags: nil,
                            likes: 5,
                            views: 50)
    
    static let news3 = News(imageURL: nil,
                            title: "Example News 3",
                            subtitle: "An example subtitle for News 3",
                            content: AttributedString("This is some example content for News 3"),
                            images: [],
                            postedDate: "2022-04-23",
                            author: NewsAuthor(name: "Bob Smith", type: .school),
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
