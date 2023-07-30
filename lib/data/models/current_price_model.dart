// To parse this JSON data, do
//
//     final currentPriceModel = currentPriceModelFromJson(jsonString);

import 'dart:convert';

import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:equatable/equatable.dart';

CurrentPriceModel currentPriceModelFromJson(String str) =>
    CurrentPriceModel.fromJson(json.decode(str));

String currentPriceModelToJson(CurrentPriceModel data) =>
    json.encode(data.toJson());

class CurrentPriceModel extends Equatable {
  final Time? time;
  final String? disclaimer;
  final String? chartName;
  final Bpi? bpi;

  const CurrentPriceModel({
    this.time,
    this.disclaimer,
    this.chartName,
    this.bpi,
  });

  factory CurrentPriceModel.fromJson(Map<String, dynamic> json) =>
      CurrentPriceModel(
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        disclaimer: json["disclaimer"],
        chartName: json["chartName"],
        bpi: json["bpi"] == null ? null : Bpi.fromJson(json["bpi"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "disclaimer": disclaimer,
        "chartName": chartName,
        "bpi": bpi?.toJson(),
      };

  CurrentPriceEntity toEntity() => CurrentPriceEntity(
      time: time?.toEntity(),
      disclaimer: disclaimer,
      chartName: chartName,
      bpi: bpi?.toEntity());

  @override
  List<Object?> get props => [time, disclaimer, chartName, bpi];
}

class Bpi extends Equatable {
  final Currency? usd;
  final Currency? gbp;
  final Currency? eur;

  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: json["USD"] == null ? null : Currency.fromJson(json["USD"]),
        gbp: json["GBP"] == null ? null : Currency.fromJson(json["GBP"]),
        eur: json["EUR"] == null ? null : Currency.fromJson(json["EUR"]),
      );

  Map<String, dynamic> toJson() => {
        "USD": usd?.toJson(),
        "GBP": gbp?.toJson(),
        "EUR": eur?.toJson(),
      };

  BpiEntity toEntity() => BpiEntity(
        usd: usd?.toEntity(),
        gbp: gbp?.toEntity(),
        eur: eur?.toEntity(),
      );

  @override
  List<Object?> get props => [
        usd,
        gbp,
        eur,
      ];
}

class Currency extends Equatable {
  final String? code;
  final String? symbol;
  final String? rate;
  final String? description;
  final double? rateFloat;

  Currency({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
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

  CurrencyEntity toEntity() => CurrencyEntity(
      code: code,
      symbol: symbol,
      rate: rate,
      description: description,
      rateFloat: rateFloat);

  @override
  List<Object?> get props => [
        code,
        symbol,
        rate,
        description,
        rateFloat,
      ];
}

class Time extends Equatable {
  final String? updated;
  final DateTime? updatedIso;
  final String? updateduk;

  Time({
    this.updated,
    this.updatedIso,
    this.updateduk,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"],
        updatedIso: json["updatedISO"] == null
            ? null
            : DateTime.parse(json["updatedISO"]),
        updateduk: json["updateduk"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "updatedISO": updatedIso?.toIso8601String(),
        "updateduk": updateduk,
      };

  TimeEntity toEntity() => TimeEntity(
      updated: updated, updatedIso: updatedIso, updateduk: updateduk);

  @override
  List<Object?> get props => [updated, updatedIso, updateduk];
}
