//
//  ItemListPage.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

struct ItemListPageDTO: Decodable {
    
    let pageNumber: Int
    let itemsPerPage: Int
    let totalCount: Int
    let offset: Int
    let limit: Int
    let items: [ItemDTO]
    let lastPage: Int
    let hasNext, hasPrevious: Bool
    
    private enum CodingKeys: String, CodingKey {
        
        case pageNumber = "pageNo"
        case itemsPerPage = "itemsPerPage"
        case totalCount = "totalCount"
        case offset
        case limit
        case items = "pages"
        case lastPage = "lastPage"
        case hasNext = "hasNext"
        case hasPrevious = "hasPrev"
        
    }
    
}

extension ItemListPageDTO {
    
    func toEntity() -> ItemListPage {
        var itemEntities: [Item] = []
        items.forEach { itemDTO in
            itemEntities.append(itemDTO.toEntity())
        }
        
        return ItemListPage(
            pageNumber: pageNumber,
            itemsPerPage: itemsPerPage,
            totalCount: totalCount,
            offset: offset,
            limit: limit,
            items: itemEntities,
            lastPage: lastPage,
            hasNext: hasNext,
            hasPrevious: hasPrevious
        )
    }
    
}
