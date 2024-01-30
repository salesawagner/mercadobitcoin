//
//  GetExchangeIconResponse.swift
//  MB
//
//  Created by Wagner Sales on 30/01/24.
//

struct GetExchangeIconResponse: Decodable {
    let exchangeID: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case url
    }
}
