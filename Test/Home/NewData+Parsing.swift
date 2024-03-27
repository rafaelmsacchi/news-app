import Foundation

struct NewDataParser {
    
    static func newData(from articlesResult: ArticlesResult) -> [NewData] {
        articlesResult.articles.compactMap { article in
            guard article.title != "[Removed]" else { return nil }
            
            var cellTypeList = [CellType]()
            if let imageURL = URL(string: article.urlToImage ?? urlString1) {
                let data = HeaderCellData(
                    imageURL: imageURL,
                    imageOverlayMessage: UInt.random(in: 0...10) < 5 ? "Breaking News" : nil,
                    title: article.title ?? "",
                    timeText: nil
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
