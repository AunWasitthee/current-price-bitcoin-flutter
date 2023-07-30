// To parse this JSON data, do
//
//     final currentPriceEntity = currentPriceEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CurrentPriceEntity currentPriceEntityFromJson(String str) => CurrentPriceEntity.fromJson(json.decode(str));

String currentPriceEntityToJson(CurrentPriceEntity data) => json.encode(data.toJson());

class CurrentPriceEntity extends Equatable{
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
  @override
  List<Object?> get props => [time, disclaimer, chartName, bpi];
}

class BpiEntity extends Equatable{
  final CurrencyEntity? usd;
  final CurrencyEntity? gbp;
  final CurrencyEntity? eur;

  BpiEntity({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory BpiEntity.fromJson(Map<String, dynamic> json) => BpiEntity(
    usd: json["USD"] == null ? null : CurrencyEntity.fromJson(json["USD"]),
    gbp: json["GBP"] == null ? null : CurrencyEntity.fromJson(json["GBP"]),
    eur: json["EUR"] == null ? null : CurrencyEntity.fromJson(json["EUR"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd?.toJson(),
    "GBP": gbp?.toJson(),
    "EUR": eur?.toJson(),
  };

  @override
  List<Object?> get props => [
    usd,
    gbp,
    eur,
  ];
}

class CurrencyEntity extends Equatable{
  final String? code;
  final String? symbol;
  final String? rate;
  final String? description;
  final double? rateFloat;

  CurrencyEntity({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory CurrencyEntity.fromJson(Map<String, dynamic> json) => CurrencyEntity(
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

  @override
  List<Object?> get props => [
    code,
    symbol,
    rate,
    description,
    rateFloat,
  ];
}

class TimeEntity extends Equatable{
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
  @override
  List<Object?> get props => [updated, updatedIso, updateduk];
}
