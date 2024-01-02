# currency-converter
Create a real-time currency converter using SwiftUI + Combine

This is a basic project done with the usage of : 
- SwiftUI
- Combine
- State machine for loading management (named _Loadable_ in here)
- RealmDB
- OpenExchangeRates API 
- Unit tests

_UI still in progress_

## Run the project

Open _currency-converter_ on Xcode and just build the project. 
Target min is iOS 17.0.

No need to add any appID, mine should work like a charm.

But if it expires, you can change it in the file _OpenExchangeRatesUrl_ line 13 in _currency-converter/IO_ and create yours here https://openexchangerates.org. 
