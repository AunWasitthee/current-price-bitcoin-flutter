// To parse this JSON data, do
//
//     final currentPriceEntity = currentPriceEntityFromJson(jsonString);

import 'dart:convert';

CurrentPriceEntity currentPriceEntityFromJson(String str) => CurrentPriceEntity.fromJson(json.decode(str));

String currentPriceEntityToJson(CurrentPriceEntity data) => json.encode(data.toJson());

class CurrentPriceEntity {
  final TimeEntity? time;
  final String? disclaimer;
  final String? chartName;
  final BpiEntity? bpi;

  CurrentPriceEntity({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  factory CurrentPriceEntity.fromJson(Map<String, dynamic> json) => CurrentPriceEntity(
    time: json["time"] == null ? null : TimeEntity.fromJson(json["time"]),
    disclaimer: json["disclaimer"],
    chartName: json["chartName"],
    bpi: json["bpi"] == null ? null : BpiEntity.fromJson(json["bpi"]),
  );

  Map<String, dynamic> toJson() => {
    "time": time?.toJson(),
    "disclaimer": disclaimer,
    "chartName": chartName,
    "bpi": bpi?.toJson(),
  };
}

class BpiEntity {
  final EurEntity? usd;
  final EurEntity? gbp;
  final EurEntity? eur;

  BpiEntity({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory BpiEntity.fromJson(Map<String, dynamic> json) => BpiEntity(
    usd: json["USD"] == null ? null : EurEntity.fromJson(json["USD"]),
    gbp: json["GBP"] == null ? null : EurEntity.fromJson(json["GBP"]),
    eur: json["EUR"] == null ? null : EurEntity.fromJson(json["EUR"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd?.toJson(),
    "GBP": gbp?.toJson(),
    "EUR": eur?.toJson(),
  };
}

class EurEntity {
  final String? code;
  final String? symbol;
  final String? rate;
  final String? description;
  final double? rateFloat;

  EurEntity({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory EurEntity.fromJson(Map<String, dynamic> json) => EurEntity(
    code: json["code"],
    symbol: json["symbol"],
    rate: json["rate"],
    description: json["description"],
    rateFloat: json["rate_float"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "symbol": symbol,
    "rate": rate,
    "description": description,
    "rate_float": rateFloat,
  };
}

class TimeEntity {
  final String? updated;
  final DateTime? updatedIso;
  final String? updateduk;

  TimeEntity({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  factory TimeEntity.fromJson(Map<String, dynamic> json) => TimeEntity(
    updated: json["updated"],
    updatedIso: json["updatedISO"] == null ? null : DateTime.parse(json["updatedISO"]),
    updateduk: json["updateduk"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
    "updatedISO": updatedIso?.toIso8601String(),
    "updateduk": updateduk,
  };
}
