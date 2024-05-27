class ShowAllTransactions {
  Data? data;

  ShowAllTransactions({this.data});

  ShowAllTransactions.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  static List<ShowAllTransactions> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ShowAllTransactions.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  Transactions? transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    transactions = json["transactions"] == null
        ? null
        : Transactions.fromJson(json["transactions"]);
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Data.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (transactions != null) {
      _data["transactions"] = transactions?.toJson();
    }
    return _data;
  }
}

class Transactions {
  int? currentPage;
  List<Data1>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Transactions(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Transactions.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links.fromJson(e)).toList();
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  static List<Transactions> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Transactions.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["current_page"] = currentPage;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["first_page_url"] = firstPageUrl;
    _data["from"] = from;
    _data["last_page"] = lastPage;
    _data["last_page_url"] = lastPageUrl;
    if (links != null) {
      _data["links"] = links?.map((e) => e.toJson()).toList();
    }
    _data["next_page_url"] = nextPageUrl;
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["prev_page_url"] = prevPageUrl;
    _data["to"] = to;
    _data["total"] = total;
    return _data;
  }
}

class Links {
  dynamic url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    label = json["label"];
    active = json["active"];
  }

  static List<Links> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Links.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["label"] = label;
    _data["active"] = active;
    return _data;
  }
}

class Data1 {
  int? id;
  int? userId;
  String? amount;
  String? currencySym;
  String? charge;
  String? postBalance;
  String? trxType;
  String? trx;
  String? details;
  String? createdAt;
  String? updatedAt;

  Data1(
      {this.id,
      this.userId,
      this.amount,
      this.currencySym,
      this.charge,
      this.postBalance,
      this.trxType,
      this.trx,
      this.details,
      this.createdAt,
      this.updatedAt});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    amount = json["amount"];
    currencySym = json["currency_sym"];
    charge = json["charge"];
    postBalance = json["post_balance"];
    trxType = json["trx_type"];
    trx = json["trx"];
    details = json["details"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<Data1> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Data1.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["amount"] = amount;
    _data["currency_sym"] = currencySym;
    _data["charge"] = charge;
    _data["post_balance"] = postBalance;
    _data["trx_type"] = trxType;
    _data["trx"] = trx;
    _data["details"] = details;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
