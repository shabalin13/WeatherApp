//
//  WeatherIDtoIconNameMapping.swift
//  WeatherApp
//
//  Created by DIMbI4 on 03.11.2023.
//

enum WeatherIDtoIconNameMapping: Int {
    
    case id200 = 200
    case id201 = 201
    case id202 = 202
    case id210 = 210
    case id211 = 211
    case id212 = 212
    case id221 = 221
    case id230 = 230
    case id231 = 231
    case id232 = 232
    
    case id300 = 300
    case id301 = 301
    case id302 = 302
    case id310 = 310
    case id311 = 311
    case id312 = 312
    case id313 = 313
    case id314 = 314
    case id321 = 321
    
    case id500 = 500
    case id501 = 501
    case id502 = 502
    case id503 = 503
    case id504 = 504
    case id511 = 511
    case id520 = 520
    case id521 = 521
    case id522 = 522
    case id531 = 531
    
    case id600 = 600
    case id601 = 601
    case id602 = 602
    case id611 = 611
    case id612 = 612
    case id613 = 613
    case id615 = 615
    case id616 = 616
    case id620 = 620
    case id621 = 621
    case id622 = 622
    
    case id701 = 701
    case id711 = 711
    case id721 = 721
    case id731 = 731
    case id741 = 741
    case id751 = 751
    case id761 = 761
    case id762 = 762
    case id771 = 771
    case id781 = 781
    
    case id800 = 800
    case id801 = 801
    case id802 = 802
    case id803 = 803
    case id804 = 804
    
    var iconName: String {
        switch self {
        case .id200, .id201, .id202, .id210, .id211, .id212, .id221, .id230, .id231, .id232:
            return "2xx"
        case .id300, .id301, .id302:
            return "30x"
        case .id310, .id311, .id312, .id313, .id314:
            return "31x"
        case .id321:
            return "32x"
        case .id500:
            return "500"
        case .id501, .id502:
            return "501-502"
        case .id503, .id504:
            return "503-504"
        case .id511:
            return "511"
        case .id520:
            return "520"
        case .id521, .id522:
            return "521-522"
        case .id531:
            return "531"
        case .id600:
            return "600"
        case .id601:
            return "601"
        case .id602:
            return "602"
        case .id611:
            return "611"
        case .id612:
            return "612"
        case .id613:
            return "613"
        case .id615:
            return "615"
        case .id616:
            return "616"
        case .id620:
            return "620"
        case .id621:
            return "621"
        case .id622:
            return "622"
        case .id701, .id711, .id721, .id731, .id741:
            return "70x-74x"
        case .id751, .id761, .id762, .id771, .id781:
            return "75x-78x"
        case .id800:
            return "800"
        case .id801:
            return "801"
        case .id802:
            return "802"
        case .id803:
            return "803"
        case .id804:
            return "804"
        }
    }
    
}
