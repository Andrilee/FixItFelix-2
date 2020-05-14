//
//  Prediction.swift
//  FixItFelix
//
//  Created by Prince Alvin Yusuf on 27/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

enum Prediction {
    case healthy
    case fastFood
    case failed(Error?)
    case empty
    
    init?(classLabel: String) {
        switch classLabel {
        case "fast food":
            self = .fastFood
        case "healthy":
            self = .healthy
        default:
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .healthy:
            return "Healthy Food, Happy Eating😄"
        case .fastFood:
            return "Junk Food, Please Avoid 🤢"
        case .failed(let error):
            let text = "Unable to recognize image"
            guard let error = error else { return text}
            return text + ":\n" + error.localizedDescription
         case .empty:
            return "No Data"
        }
    }
    
    var color: UIColor {
        switch self {
        case .healthy:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .fastFood:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .failed(_), .empty:
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
