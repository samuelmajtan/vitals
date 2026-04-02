# 

## Prehľad

Aplikácia sleduje architektúru MVVM so servisnou vrstvou. Tento dokument popisuje kľúčové vzory používané v celom projekte.

## MVVM + Observable

ViewModely používajú makro `@Observable` namiesto `ObservableObject`. View drží ViewModel cez `@State`.

```swift
// ViewModel
@MainActor
@Observable final class MeasurementTypesViewModel: MeasurementTypesViewModelProtocol {
    private(set) var dailySamples: [Sample] = []
}

// View — @State, nie @StateObject
struct MeasurementTypesView: View {
    @State private var viewModel: MeasurementTypesViewModelProtocol

    init(viewModel: MeasurementTypesViewModelProtocol) {
        self.viewModel = viewModel
    }
}
```

ViewModely sa vždy vytvárajú v Screen vrstve, nie priamo vo View.

```swift
struct MeasurementTypesScreen: View {
    var body: some View {
        MeasurementTypesView(viewModel: MeasurementTypesViewModel(context))
    }
}
```

## Dependency Injection — FactoryKit

Všetky služby sú registrované v rozšíreniach `Container` a injektované cez `@Injected`.

```swift
// Registrácia
extension Container {
    var healthService: Factory<HealthServiceProtocol> {
        self { HealthService() }.singleton
    }
}

// Použitie vo ViewModeli
@ObservationIgnored
@Injected(\.healthService)
private var healthService: HealthServiceProtocol
```

`@ObservationIgnored` je povinné pri použití `@Injected` v `@Observable` triedach, aby sa zabránilo sledovaniu injektovanej vlastnosti.

## Servisná vrstva

Tri vrstvy s jasnými zodpovednosťami:

| Vrstva | Typ | Zodpovednosť |
|---|---|---|
| `HKHealthStore` | Singleton | Jediný HealthKit store zdieľaný v celej aplikácii |
| `MeasurementProvider` | Actor | Surové HealthKit requesty cez deskriptory |
| `HealthService` | Class | Biznis logika — rozlíšenie intervalov a mapovanie dát |

`MeasurementProvider` je `final actor` kvôli serializácii prístupu k HealthKit. `HealthService` je bežná trieda, keďže jeho metódy sú už asynchrónne.

## Systém SampleType

Každá zdravotná kategória je reprezentovaná typovaným enumom konformujúcim na `SampleTypeProtocol`.

```swift
protocol SampleTypeProtocol {
    var title: String { get }
    var type: SampleType { get }
    var category: SampleCategory { get }
    var config: SampleConfiguration { get }
}
```

`AnySampleType` je type-erased wrapper používaný všade, kde je potrebný generický sample type bez znalosti konkrétneho enumu.

`SampleConfiguration` nesie všetky rozhodnutia o zobrazení — ViewModel ani View nikdy nerozhodujú ako typ zobraziť, typ to rozhoduje sám za seba.

```swift
struct SampleConfiguration {
    let statistics: StatisticsOption  // akú štatistiku zvoliť
    let chartStyle: ChartStyle        // aký graf zvoliť
    let summaryLabel: SummaryLabel    // aký popis zobraziť
    let dateInterval: DateInterval    // predvolený časový rozsah
}
```

## Navigácia — NavigatorUI

Navigačné destinácie sú definované ako enumy s asociovanými typmi `Context`. Každá destinácia vlastní svoj kontext, view a spôsob navigácie.

```swift
enum MeasurementTypesDestinations: Hashable, NavigationDestination {
    case detail(Context)

    var body: some View {
        switch self {
        case .detail(let context): MeasurementDetailScreen(context)
        }
    }

    var method: NavigationMethod { .push }

    struct Context: Hashable {
        let sample: Sample
    }
}
```

## Rozlíšenie intervalov

`HealthService.fetchSample(for:)` automaticky nájde najnovší interval s dátami prechodom `denný → týždenný → mesačný`. ViewModel nikdy nerozhoduje, ktorý interval použiť.

```swift
// HealthService rozlíši interval
func fetchSample(for type: AnySampleType) async throws -> Sample? {
    for interval in SampleInterval.allCases {
        if let sample = try await fetchStatistics(for: type, in: interval.dateInterval, assignedTo: interval) {
            return sample
        }
    }
    return nil
}

// ViewModel len rozdelí výsledok do skupín
switch sample?.interval {
case .daily:   daily.append(sample!)
case .weekly:  weekly.append(sample!)
case .monthly: monthly.append(sample!)
case nil:      empty.append(type)
}
```
