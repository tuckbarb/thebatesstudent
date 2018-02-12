//
//
//

import Foundation

struct Sports {
    var title: String
    var category: String
    var description: String
    
    //
}



class FeedParser_sports: NSObject, XMLParserDelegate
{
    //XMLParserDelegate will basically pause to perform a method
    //at certain tags so one may navigate through nested items within tags
    
    private var sports: [Sports] = []
    private var currentElement = ""
    
    //we need to get values and also trim the white space on the site
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    
    private var currentCategory: String = "" {
        didSet {
            currentCategory = currentCategory.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    private var currentDescription: String = ""
    {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
//            currentDescription = currentDescription.stripHTML()
//            currentDescription = currentDescription.stripweird_one()
//            currentDescription = currentDescription.stripweird_two()
//            currentDescription = currentDescription.stripweird_three()
            //currentDescription = currentDescription.stripnbsp()
            
        }
        
    }
    
    
    private var parserCompletionHandler: (([Sports]) -> Void)?
    //basically make a closure parserComp... we make a function that returns nothing
    
    //Create a func to parse feed from some url
    //completion handler provides a safe way to finish the function even if the url doesn't
    //work but we need to account for time consumed in retrieving the xml feed
    //we need to rely on the delegate method to know when we're done with the
    //completion handler
    
    
    
    func parseFeed(url: String, completionHandler: (([Sports]) -> Void)?) {
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
            currentCategory = ""
            currentDescription = ""
            
        }
    }
    //need another method to vverigy if it found characters above with the "item" tag specified
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "category": currentCategory += string
        case "description": currentDescription += string
        default: break
            
        }
    }
    
    //Define a method for what happens when the parser reaches the closing tag of the tags specified
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let sports_item = Sports(title: currentTitle, category: currentCategory, description: currentDescription)
            self.sports.append(sports_item)
        }
    }
    
    
    //need to call completion handler at this point to keep track of the fact that parsing is done
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(sports)
    }
    
    //However, what if there's an error
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

