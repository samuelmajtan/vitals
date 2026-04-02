# Building

## Požiadavky

Xcode 26.2\
iOS Deployment Target: 26.2\
Swift: 6.2 

## Závislosti

Spravované cez Swift Package Manager. Všetky balíčky sa vyriešia automaticky pri prvom zostavení.

https://github.com/hmlongco/Factory - DI framework\
https://github.com/hmlongco/Navigator - Navigation framework\
https://github.com/sindresorhus/Defaults - User Defaults wrapper

## Spustenie

1. Naklonuj repozitár
2. Otvor `Vitals.xcodeproj` v Xcode
3. Vyber vývojársky tím v záložke **Signing & Capabilities**
4. Spusti na fyzickom zariadení — HealthKit nie je dostupný na Simulátore

```bash
git clone <repo>
cd Vitals
open Vitals.xcodeproj
```

## HealthKit oprávnenia

HealthKit vyžaduje fyzické zariadenie a nasledujúce oprávnenie v `Vitals.entitlements`:

```xml
<key>com.apple.developer.healthkit</key>
<true/>
<key>com.apple.developer.healthkit.access</key>
<array/>
```

`NSHealthShareUsageDescription` musí byť nastavený v `Info.plist` — bez neho aplikácia spadne pri štarte.

## Schémy

`Vitals`: Vývojový build, spúšťa sa na zariadení\
`VitalsTests`: Unit testy, spúšťajú sa na Simulátore

## Pridanie nového typu merania

1. Pridaj case do príslušného `*SampleType` enumu (napr. `VitalsSampleType`)
2. Implementuj `title`, `type` a `config` pre nový case
3. Ak typ používa `HKQuantityTypeIdentifier` ktorý ešte nie je v rozšírení, pridaj jeho `defaultUnit` a `displayUnit` do `HKQuantityTypeIdentifier+Units.swift`
4. Pridanie do `readTypes` v `HealthService` prebehne automaticky cez `SampleCategory.allCases.flatMap(\.types)`
5. Autorizácia sa vyžiada automaticky pri štarte aplikácie

## Pridanie novej kategórie

1. Pridaj case do `SampleCategory`
2. Implementuj `title`, `image`, `color` a `types` pre nový case
3. Vytvor nový `*SampleType` enum konformujúci na `SampleTypeProtocol` a `CaseIterable`
4. Vráť `AnySampleType` wrappers z `types` v `SampleCategory`

Žiadne zmeny v `HealthService`, `MeasurementProvider` ani vo ViewModeloch nie sú potrebné.
