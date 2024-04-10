import Foundation

struct LocalArticle: Codable, Hashable, Identifiable {
    var id: String { article.id }
    static func == (lhs: LocalArticle, rhs: LocalArticle) -> Bool {
        lhs.article == rhs.article
    }
    
    var article: Article
    var favorite: Bool
    var favoriteNote: String
}

// Display data
extension LocalArticle {
    
    var imageURL: URL? {
        URL(string: article.urlToImage ?? urlString1)
    }
    
    var imageOverlayMessage: String? {
        article.urlToImage != nil ? "Breaking News" : nil
    }
    
    var title: String {
        article.title ?? ""
    }
    
    var timeText: String? {
        nil
    }
    
    var content: String? {
        article.content
    }
    
    var description: String? {
        article.description
    }
    
}

class NewsRepository {
    
    func localArticles(from articlesResult: ArticlesResult) -> [LocalArticle] {
        articlesResult.articles.compactMap { article in
            guard article.title != "[Removed]" else { return nil }
            return LocalArticle(article: article, favorite: false, favoriteNote: "") // TODO: load favorite from local storage
        }
    }
    
}

// deprecated, to use above
struct NewDataParser {
    
    static func newData(from articlesResult: ArticlesResult) -> [NewData] {
        articlesResult.articles.compactMap { article in
            guard article.title != "[Removed]" else { return nil }
            
            var cellTypeList = [CellType]()
            if let imageURL = URL(string: article.urlToImage ?? urlString1) {
                let data = HeaderCellData(
                    id: article.source?.id ?? String(Int.random(in: 0...100000)), // IRL id is never null
                    imageURL: imageURL,
                    imageOverlayMessage: UInt.random(in: 0...10) < 5 ? "Breaking News" : nil,
                    title: article.title ?? "",
                    timeText: nil,
                    favorite: false,
                    favoriteNote: ""
                )
                cellTypeList.append(.header(data))
            } else if let title = article.title {
                let data = TextCellData(id: String("\(article.hashValue)\(title.hashValue)"), text: title)
                cellTypeList.append(.text(data))
            }
            
            if let content = article.content {
                let data = TextCellData(id: String("\(article.hashValue)\(content.hashValue)"), text: content)
                cellTypeList.append(.text(data))
            }
            
            if let description = article.description {
                let data = TextCellData(id: String("\(article.hashValue)\(description.hashValue)"), text: description)
                cellTypeList.append(.text(data))
            }
            return NewData(cellTypeList: cellTypeList)
        }
    }
    
}
