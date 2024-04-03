import Foundation

struct ArticlesResult: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Decodable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.source?.id == rhs.source?.id
    }
    
    struct Source: Decodable, Hashable {
        let id: String?
        let name: String?
    }
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String? // create decodable to date
    let content: String?
}