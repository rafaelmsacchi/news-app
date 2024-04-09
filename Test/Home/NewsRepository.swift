import Foundation

struct LocalArticle: Codable, Hashable {
    static func == (lhs: LocalArticle, rhs: LocalArticle) -> Bool {
        lhs.article == rhs.article
    }
    
    let article: Article
    var favorite: Bool
    var favoriteNote: String
}

class NewsRepository {
    
    func localArticles(from articlesResult: ArticlesResult) -> [NewData] {
        articlesResult.articles.compactMap { article in
            guard article.title != "[Removed]" else { return nil }
            
            let id = article.source?.id ?? String(Int.random(in: 0...100000)) // IRL id is never null
            var cellTypeList = [CellType]()
            if let imageURL = URL(string: article.urlToImage ?? urlString1) {
                let data = HeaderCellData(
                    id: id,
                    imageURL: imageURL,
                    imageOverlayMessage: UInt.random(in: 0...10) < 5 ? "Breaking News" : nil,
                    title: article.title ?? "",
                    timeText: nil,
                    favorite: false, // TODO: fetch from local DB
                    favoriteNote: "" // TODO: fetch from local DB
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
    
    func update(favourite: Bool, note: String, id: String) {
        // save info locally
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
