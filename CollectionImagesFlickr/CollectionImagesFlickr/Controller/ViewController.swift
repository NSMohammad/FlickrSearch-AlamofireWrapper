//
//  ViewController.swift
//  CollectionImagesFlickr
//
//  Created by MuhaMaD on 30/2/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    var searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = APIService(baseURL: .flickr)
        SearchModel.tag = "cat"
        s.doCustomRequest(searchModel, method: .get) { (response) in
            switch response {
            case .success(let rawSearchModel):
                self.searchModel = rawSearchModel
                print(self.searchModel)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}

struct SearchModel: Requestable {
    static var retriable: Bool {
        false
    }
    
    typealias ResponseType = SearchModel
    static var tag = ""
    static var apiKey = "fa99d5e37376a1c8f370a085e46c82ea"
    static var path: String {
        return "/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(tag)&extras=url_m&page=&format=json&nojsoncallback=1"
    }
    
    var photos: Photos?
        var stat: String?
}
struct Photos: Codable {
    var page: Int?
        var pages: Int?
        var perpage: Int?
        var total: Int?
        var photo: [Photo]?

        enum CodingKeys: String, CodingKey {
            case page = "page"
            case pages = "pages"
            case perpage = "perpage"
            case total = "total"
            case photo = "photo"
        }
}
struct Photo: Codable {
    var id: String?
        var owner: String?
        var secret: String?
        var server: String?
        var farm: Int?
        var title: String?
        var ispublic: Int?
        var isfriend: Int?
        var isfamily: Int?
    var "url_m": "https://live.staticflickr.com/65535/52093729816_5e426d92fb.jpg",
        var    "height_m": "472",
            "width_m": "500"

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case owner = "owner"
            case secret = "secret"
            case server = "server"
            case farm = "farm"
            case title = "title"
            case ispublic = "ispublic"
            case isfriend = "isfriend"
            case isfamily = "isfamily"
        }
    
}
