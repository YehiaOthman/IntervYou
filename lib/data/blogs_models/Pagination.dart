class Pagination {
  num? total;
  num? page;
  num? limit;
  num? pages;

  Pagination({
      this.total, 
      this.page, 
      this.limit, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['pages'] = pages;
    return map;
  }

}