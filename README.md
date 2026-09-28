# inSeconds: Opportunities Feed

A small SwiftUI app that shows startup "opportunities" as a vertically paged feed, with search, a detail screen, and like/save that survives relaunch. Data comes from bundled JSON, but the data layer is structured as if it were a remote API.

**Screen recording:** <!-- https://www.icloud.com/iclouddrive/08aiVEXMAfrmqVJiMzOMihO6Q -->

## How the app works

- **Feed:** one full-screen card per opportunity (image, startup name, founder, category, funding status, description) with paging scroll, like, and save buttons.
- **Detail:** tapping a card's image opens a detail screen with the full information and a save/unsave button.
- **Search:** filters by startup name, founder, or category (case-insensitive) and updates on every keystroke.
- **Persistence:** saved and liked IDs are stored in `UserDefaults`, so state survives closing and reopening the app.
- **States:** the feed handles loading, success, empty, and error, driven by a single `DataState` enum.

## Architecture

MVVM with a Repository and a Service layer:

```
SwiftUI Views -> FeedVM (@Observable, @MainActor) -> OppRepository (protocol) -> OppService (decoding + persistence)
```

**Why this shape**

- The brief asks for the data layer to behave like an API. Views never touch the data source, so replacing the bundled JSON with a `URLSession` call would only change `OppService` and the repository. Nothing in the views or the view model would change.
- The repository is a protocol injected through `init`, so the view model can be tested with an in-memory mock (see Testing).
- One `FeedVM` is created at the root and passed to the feed, search, and detail screens. Saving from any screen updates the same state everywhere, with no syncing code.
- Models are `Codable` with `CodingKeys` mapping the JSON names (`startupName`, `founderName`, `description`) to cleaner Swift names.
- Errors are typed (`DataError`, conforming to `LocalizedError`) and turned into `DataState.isError(message)` in the view model.
- Concurrency uses `async/await` throughout. The view model is `@MainActor` and models are `Sendable`.

**A technical decision I'm happy with:** the typed error to `DataState` pipeline. Failures are modelled once (`DataError`), mapped to UI state once (`FeedVM.fetchOpportunities`), and rendered by a single `switch` in the view, so there is no ad-hoc error handling in views. A unit test also caught that the error messages weren't reaching the UI until `DataError` adopted `LocalizedError`.

## Persistence choice

The brief asked for a lightweight approach. Saved and liked state is two sets of IDs with no relationships or queries, so `UserDefaults` fits. SwiftData would add a schema and migrations for no benefit here. If saved items needed to carry their own data or be queried, I would move to SwiftData behind the same repository protocol.

## Testing

Written with Swift Testing. A mock repository keeps tests off the real `UserDefaults` and bundle. Run with `Cmd+U`.

- JSON decoding maps renamed keys correctly.
- The service maps bad input to typed errors (missing file, wrong shape).
- Search matches name, founder, and category, and handles empty and no-match queries.
- Save and unsave toggle state and persist through the repository.
- Saved and liked state reloads on a fresh view model (simulates relaunch).
- Loading, empty, and error states, including the error message text.

## Assumptions

- Data is a local bundled JSON file (10 opportunities). Images are remote URLs, so they need a network connection. A failed image shows a warning icon.
- Save and like are local and single-user.
- Search is a case-insensitive substring match across the three fields, not fuzzy or ranked.
- A one-item-at-a-time feed doesn't have a dense layout to preview, so a plain loading indicator is used instead of skeleton placeholders.

## What I would improve with 2 more days

- **Error fidelity:** `OppService.fetchData` maps every non-decoding failure to `noData`. I would keep the underlying error (or at least log it) so permission or corruption problems aren't reported as "no data".
- **Images:** `AsyncImage` has no timeout control or explicit caching. I would add a small image cache, a short request timeout, and a retry action on failure.
- **Memory growth:** `LazyVStack` keeps views it has created, so memory grows with feed length (about 40 MB after 10 cards). With a real backend I would paginate and cap the cache.
- **Share button:** it is a UI stub. I would wire it to `ShareLink`.
- **Persistence:** move to SwiftData if saved items need richer data, and batch writes if toggles become frequent.
- **Search:** debounce input and rank results (name matches first).
- **Quality:** UI tests for the feed to detail flow, accessibility labels and Dynamic Type checks, and iPad layout.

## Running it

Open the project in Xcode, select an iPhone simulator, and run. Tests: `Cmd+U`.
<!-- add Xcode version and minimum iOS target -->
