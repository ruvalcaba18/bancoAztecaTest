
import Foundation

struct apiDecoder: Decodable{
    var name: String?
    var summary: String?
    var externals: externals?
    var image: image?
}
struct image: Decodable{
    var medium: String?
   
}

struct externals: Decodable{
    var imdb: String?
}
