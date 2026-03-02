# GetWellGalaxy

<img width="20%" alt="GetWellGalaxyIcon-iOS-Default-1024x1024@1x" src="https://github.com/user-attachments/assets/d56a6f15-22a3-40aa-a868-611edfb8f74d" />

"GetWellGalaxy" app is your portal to better days. We realize how daunting it is to be sick for a while. Open the app to browse your favorite "Rick and Morty" episodes. Dig deeper and explore hundreds of characters. We even provide an option to export your favorite characters so the rest of the world can hear about them.

## Curious what's inside?

| <img width="30%" alt="homescreen-episodes-list" src="https://github.com/user-attachments/assets/2c33eaac-60a7-445d-9efa-7fab5d33cae6" /> | <img width="30%" alt="episode-details" src="https://github.com/user-attachments/assets/fde6d8b0-1692-421f-b050-0ded911db38f" /> | <img width="30%" alt="character-card" src="https://github.com/user-attachments/assets/8627e321-78f9-426b-a8ca-2b175bea0ca1" /> |

## Contribution

The creator of this app follows the coding standards listed below:
- Model-View-ViewModel architecture
- Feature-focused file organisation
- Protocol-oriented programming (we want implementations to be easily swappable and our code lightweight by using `struct`s)
- Minimal deployment target iOS 18
- Language mode "Swift 6" (don't you dare to switch to "Swift 5")
- Approachable Concurrency **enabled**
- Default actor isolation `nonisolated` (because we have some background tasks)
- Strict Concurrency Checking set to "Complete"
- SwiftUI for UI
- SwiftData for persistence
- Swift Testing for unit tests
- Data fetched from the [Rick & Morty API](https://rickandmortyapi.com/documentation#rest)
- SPM over CocoaPods (we know the latter will be read-only as of December 2, 2026)
- [GitHub-Flow](https://medium.com/@sreekanth.thummala/choosing-the-right-git-branching-strategy-a-comparative-analysis-f5e635443423) for branching strategy
	- `main` is protected branch from which release can be triggered
	- Use `feature/<short-feature-description>` for features
	- Use `bugfix/<short-bugfix-description>` for bug fixes
- Create separate PRs for each feature and bug-fix proposal

## Feedback

Reach out to the creator [Ivans Mihailovs](https://github.com/ivansdivans) or [create an issue](https://github.com/ivansdivans/get-well-galaxy/issues).
