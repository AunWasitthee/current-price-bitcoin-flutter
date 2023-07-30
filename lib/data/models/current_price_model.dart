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
  // TODO: implement props
  List<Object?> get props => [time, disclaimer, chartName, bpi];
}

class Bpi {
  final Eur? usd;
  final Eur? gbp;
  final Eur? eur;

  Bpi({
    this.usd,
    this.gbp,
    this.eur,
  });

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
        usd: json["USD"] == null ? null : Eur.fromJson(json["USD"]),
        gbp: json["GBP"] == null ? null : Eur.fromJson(json["GBP"]),
        eur: json["EUR"] == null ? null : Eur.fromJson(json["EUR"]),
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
}

class Eur {
  final String? code;
  final String? symbol;
  final String? rate;
  final String? description;
  final double? rateFloat;

  Eur({
    this.code,
    this.symbol,
    this.rate,
    this.description,
    this.rateFloat,
  });

  factory Eur.fromJson(Map<String, dynamic> json) => Eur(
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

  EurEntity toEntity() => EurEntity(
      code: code,
      symbol: symbol,
      rate: rate,
      description: description,
      rateFloat: rateFloat);

// @override
// List<Object?> get props => [
//   code,
//   symbol,
//   rate,
//   description,
//   rateFloat,
// ];
}

class Time {
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
}
