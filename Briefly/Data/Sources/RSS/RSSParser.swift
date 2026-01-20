//
//  RSSParser.swift
//  Briefly
//
//  Created by Pranay Chander on 22/12/25.
//

import Foundation

final class RSSParser: NSObject {

    private var items: [RSSItemDTO] = []
    private var currentItem: RSSItemDTOBuilder?
    private var currentElement = ""
    private var buffer = ""
    
    private var currentTopic = ""

    func parse(data: Data, topic: String) -> [RSSItemDTO] {
        items = []
        currentItem = nil
        currentElement = ""
        buffer = ""
        currentTopic = topic

        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()

        return items
    }

}

private final class RSSItemDTOBuilder {
    var title: String = ""
    var link: String = ""
    var publishedDate: Date?
    var author: String?
    var description: String = ""
    var thumbnailURL: URL?
}


extension RSSParser: XMLParserDelegate {

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        currentElement = elementName
        buffer = ""

        if elementName == "item" {
            currentItem = RSSItemDTOBuilder()
            return
        }

        guard let item = currentItem else { return }

        // ✅ BBC media:content (preferred – larger image)
        if elementName == "media:content",
           item.thumbnailURL == nil,
           attributeDict["medium"] == "image",
           let urlString = attributeDict["url"],
           let url = URL(string: urlString) {
            item.thumbnailURL = url
        }

        // ✅ BBC media:thumbnail (fallback – smaller)
        if elementName == "media:thumbnail",
           item.thumbnailURL == nil,
           let urlString = attributeDict["url"],
           let url = URL(string: urlString) {
            item.thumbnailURL = url
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        buffer += string
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard let item = currentItem else { return }

        let value = buffer.trimmingCharacters(in: .whitespacesAndNewlines)

        switch elementName {
        case "title":
            item.title = value
        case "link":
            item.link = value
        case "pubDate":
            item.publishedDate = RSSDateParser.parse(value)
        case "dc:creator", "author":
            item.author = value
        case "description", "content:encoded":
            item.description = value
        case "item":
            items.append(
                RSSItemDTO(
                    title: item.title,
                    link: item.link,
                    author: item.author,
                    publishedDate: item.publishedDate,
                    description: item.description,
                    topic: currentTopic,
                    thumbnailURL:  item.thumbnailURL
                )
            )
            currentItem = nil
        default:
            break
        }
    }
}
