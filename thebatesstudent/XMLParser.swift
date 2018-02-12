//
//
//

import Foundation

struct News {
    var title: String
    var pubDate: String
    var author: String
    var description: String
    //
}


extension String {
    /**
     Takes the current String struct and strips out HTML using regular expression. All tags get stripped out.

     :returns: String html text as plain text
     */
    func stripHTML() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func stripweird_one() -> String {
        return self.replacingOccurrences(of: "&#8220;", with: "", options: .regularExpression, range: nil)
    }
    func stripweird_two() -> String {
        return self.replacingOccurrences(of: "&#8221;", with: "", options: .regularExpression, range: nil)
    }
    func stripweird_three() -> String {
        return self.replacingOccurrences(of: "&#8230;", with: "", options: .regularExpression, range: nil)
    }
    
    func stripweird_four() -> String {
        return self.replacingOccurrences(of: "&#160; ", with: "", options: .regularExpression, range: nil)
    }
    
//    func stripnbsp() -> String {
//        return self.replacingOccurrences(of: "&nbsp:", with: "")
//
//        //return self.replacingOccurrences(of: "&nbsp;", with: "")
//    }
}

//download xml from server
//parse xml to xcode objects


class FeedParser: NSObject, XMLParserDelegate
{
    //XMLParserDelegate will basically pause to perform a method
    //at certain tags so one may navigate through nested items within tags
    
    private var news: [News] = []
    private var currentElement = ""
    
    //we need to get values and also trim the white space on the site
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }

    private var currentAuthor: String = "" {
        didSet {
            currentAuthor = currentAuthor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    private var currentDescription: String = ""
    {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //clean the text
            currentDescription = currentDescription.stripHTML()
            currentDescription = currentDescription.stripweird_one()
            currentDescription = currentDescription.stripweird_two()
            currentDescription = currentDescription.stripweird_three()
            currentDescription = currentDescription.stripweird_four()
            
            //currentDescription = currentDescription.stripnbsp()
            
        }
        
        }
    
    
    private var parserCompletionHandler: (([News]) -> Void)?
    //basically make a closure parserComp... we make a function that returns nothing
    
    //Create a func to parse feed from some url
    //completion handler provides a safe way to finish the function even if the url doesn't
    //work but we need to account for time consumed in retrieving the xml feed
    //we need to rely on the delegate method to know when we're done with the
    //completion handler
    
    
    
    func parseFeed(url: String, completionHandler: (([News]) -> Void)?) {
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data //first set up procedure so methods are executed only if there's no error
                else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
            }
            //parse xml if
            let parser = XMLParser(data: data)
            //tell parser that you want it to be its own delegate
            parser.delegate = self
            //start parsing the document,
            parser.parse()
            
        }
        task.resume()
    }
    //MARK: - Delegate for XML Parser
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentAuthor = ""
            currentDescription = ""
            currentPubDate = ""
            
        }
    }
    //need another method to vverigy if it found characters above with the "item" tag specified
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title": currentTitle += string
            case "pubdate": currentPubDate += string
            case "dc:creator": currentAuthor += string
        case "content:encoded": currentDescription += string
        default: break
            
        }
    }
    
    //Define a method for what happens when the parser reaches the closing tag of the tags specified
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let news_item = News(title: currentTitle, pubDate: currentPubDate, author: currentAuthor, description: currentDescription)
            self.news.append(news_item)
        }
    }
    
    
    //need to call completion handler at this point to keep track of the fact that parsing is done
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(news)
    }
    
    //However, what if there's an error
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
