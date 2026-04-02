# Testing

## Prehľad

Projekt využíva framework Swift Testing pre unit testy a XCTest pre UI testy. Služby sú testované pomocou mock implementácií injektovaných cez FactoryKit.

## Štruktúra

```
Tests/
├── Unit/
│   ├── Services/
│   │   ├── HealthServiceTests.swift
│   │   └── MeasurementProviderTests.swift
│   ├── ViewModels/
│   │   ├── MeasurementTypesViewModelTests.swift
│   │   └── MeasurementDetailViewModelTests.swift
│   └── Extensions/
│       └── HKQuantityTypeIdentifierTests.swift
└── Mocks/
    ├── MockHealthService.swift
    └── MockMeasurementProvider.swift
```

## Mockovanie služieb

FactoryKit umožňuje zameniť registrácie pre každý test. Registráciu prepíš v `setUp` a resetuj v `tearDown`.

```swift
final class MeasurementTypesViewModelTests {

    @Test func fetchSamples_naplniDenneSamples() async throws {
        Container.shared.healthService.register { MockHealthService() }
        let viewModel = MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals))

        await viewModel.fetchSamples()

        #expect(!viewModel.dailySamples.isEmpty)
    }

    deinit {
        Container.shared.reset()
    }
}
```

## Písanie mockov

```swift
final class MockHealthService: HealthServiceProtocol {

    var healthStore: HKHealthStore = .init()
    var readTypes: Set<HKSampleType> = []

    // Nakonfiguruj stub odpovede pre každý test
    var stubbedSample: Sample?
    var stubbedSampleData: [SampleData] = []
    var shouldThrow = false

    func isAvailable() -> Bool { true }

    func fetchSample(for type: AnySampleType) async throws -> Sample? {
        if shouldThrow { throw AppError.unknown }
        return stubbedSample
    }

    func fetchSampleData(for type: AnySampleType, in interval: DateInterval, limit: Int?) async throws -> [SampleData] {
        if shouldThrow { throw AppError.unknown }
        return stubbedSampleData
    }
}
```

## Testovanie jednotiek (HKUnit)

Kompatibilita jednotiek je kritická — otestuj každý `HKQuantityTypeIdentifier` aby si overil, že `safeDefaultUnit` nikdy nevráti `nil` pre typy používané v aplikácii.

```swift
@Test(arguments: VitalsSampleType.allCases)
func vitalneTypy_majuKompatibilneJednotky(type: VitalsSampleType) {
    guard case .quantity(let identifier) = type.type else { return }
    #expect(identifier.safeDefaultUnit != nil, "\(identifier.rawValue) má nekompatibilnú jednotku")
}

@Test(arguments: ActivitySampleType.allCases)
func aktivitneTypy_majuKompatibilneJednotky(type: ActivitySampleType) {
    guard case .quantity(let identifier) = type.type else { return }
    #expect(identifier.safeDefaultUnit != nil, "\(identifier.rawValue) má nekompatibilnú jednotku")
}
```

## Testovanie rozdeľovania do sekcií

Overuje, že samples sú správne priradené do sekcie Today, 7 Days alebo Month.

```swift
@Test func fetchSamples_priradiDoSpravnejSekcie() async throws {
    let mock = MockHealthService()
    mock.stubbedSample = Sample(
        AnySampleType(VitalsSampleType.heartRate),
        date: .now,
        value: 72,
        unit: "BPM",
        interval: .daily
    )
    Container.shared.healthService.register { mock }

    let viewModel = MeasurementTypesViewModel(MeasurementsDestinations.Context(.vitals))
    await viewModel.fetchSamples()

    #expect(viewModel.dailySamples.count == 1)
    #expect(viewModel.weeklySamples.isEmpty)
    #expect(viewModel.emptySamples.isEmpty)
}
```
