import Foundation
import ApolloAPI

struct RatingParser {
    static func calculateRating(from metafieldsDicts: [DataDict]?, productId: String) -> (rating: Double?, reviewCount: Int?) {
        guard let metafields = metafieldsDicts else { return (nil, nil) }
        var ratings: [Int] = []
        
        for metafield in metafields {
            let dict = metafield._data
            guard let namespace = dict["namespace"] as? String,
                  let key = dict["key"] as? String,
                  namespace == "reviews",
                  key == "items" else { continue }
            
            // Get references dict
            guard let references = dict["references"] as? DataDict,
                  let edges = references._data["edges"] as? [DataDict] else { continue }
            
            for edge in edges {
                guard let node = edge._data["node"] as? DataDict else { continue }
                guard node._data["__typename"] as? String == "Metaobject" else { continue }
                
                // approved check
                if let productObj = node._data["product"] as? DataDict,
                   let productValue = productObj._data["value"] as? String,
                   productValue == productId,
                   let approvedObj = node._data["approved"] as? DataDict,
                   let approvedValue = approvedObj._data["value"] as? String,
                   approvedValue.lowercased() == "true",
                   let ratingObj = node._data["rating"] as? DataDict,
                   let ratingValue = ratingObj._data["value"] as? String,
                   let r = Int(ratingValue),
                   (1...5).contains(r) {
                    ratings.append(r)
                }
            }
        }
        
        guard !ratings.isEmpty else { return (nil, nil) }
        let totalRating = ratings.reduce(0, +)
        let average = Double(totalRating) / Double(ratings.count)
        return (average, ratings.count)
    }
}
