Paging pagingFromJson(dynamic str) => Paging.fromJson(str);

class Paging {
    final List content;
    final Pageable pageable;
    final int totalPages;
    final int totalElements;
    final bool last;
    final bool first;
    final int size;
    final int number;
    final Sort sort;
    final int numberOfElements;
    final bool empty;

    Paging({
        required this.content,
        required this.pageable,
        required this.totalPages,
        required this.totalElements,
        required this.last,
        required this.first,
        required this.size,
        required this.number,
        required this.sort,
        required this.numberOfElements,
        required this.empty,
    }
    
    );

    factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        content: List.from(json["content"].map((x) => x)),
        pageable: Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        first: json["first"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
    );
}
class Pageable {
    final Sort sort;
    final int pageNumber;
    final int pageSize;
    final int offset;
    final bool paged;
    final bool unpaged;

    Pageable({
        required this.sort,
        required this.pageNumber,
        required this.pageSize,
        required this.offset,
        required this.paged,
        required this.unpaged,
    });

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    final bool unsorted;
    final bool sorted;
    final bool empty;

    Sort({
        required this.unsorted,
        required this.sorted,
        required this.empty,
    });

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        unsorted: json["unsorted"],
        sorted: json["sorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "unsorted": unsorted,
        "sorted": sorted,
        "empty": empty,
    };
}
