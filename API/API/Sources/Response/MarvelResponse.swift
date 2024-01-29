//
//  MarvelResponse.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

struct MarvelResponse<Response: Decodable>: Decodable { // FIXME: remover
    let status: String?
    let message: String?
    let data: DataContainer<Response>?
}
