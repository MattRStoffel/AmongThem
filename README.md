# AmongThem

_A SwiftUI chat “game” with AI personas, powered by Ollama 3.2._

---

## Contributors

1. [@MattRStoffel](https://github.com/MattRStoffel) - Matt Stoffel
2. [@MaKoabra](https://github.com/MaKoabra)         - Steven 
3. [@adixsharma](https://github.com/adixsharma)     - Aditya Sharma
4. [@natdav231] (https://github.com/natdav231)      - Nathan Gabriel David

---

## 🚀 Features

- **Multiple Threads**  
  Create, rename, and delete separate conversations (“threads”) with different AI personas.  
- **AI Chat via Ollama 3.2**  
  Streaming responses from local Ollama 3.2 models for ultra‑fast, privacy‑preserving chat.  
- **Typing Indicator**  
  “…is typing” bubble shows before each AI reply.  
- **Auto‑Scroll**  
  Chat view stays pinned to the latest message or typing bubble.  
- **CoreData Persistence**  
  All threads and messages saved locally, available offline.  
- **SwiftUI Interface**  
  Clean, reactive UI with custom message bubbles and dark‑mode support.

---

## 📝 Requirements

- **Xcode 16.2**  
- **iOS 17.0+**  
- **Swift 5.9**  
- **Ollama 3.2** installed and in your PATH  
- **CoreData** (no external database needed)

---

## 🔧 Setup & Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/YourOrg/AmongThem.git
   cd AmongThem
2. **Ensure Ollama 3.2 is installed and running**

   ```bash
   ollama version  # should report 3.2.x
   ollama run llama3.2
3. **Open in Xcode**  

   ```bash
   open AmongThem.xcodeproj
4. **Build & Run**  

## 🛠 Architecture

- **MVVM + Swift Concurrency**  
  - `ViewModel.swift` manages UI state, typing indicator, and AI calls (`@MainActor` async).  
  - `EnemyHandler.swift` interfaces with Ollama 3.2 for streaming responses.  
  - `MessageHandler.swift`, `ThreadHandler.swift`, `UserHandler.swift` encapsulate CoreData CRUD.  

- **SwiftUI Views**  
  - `ContentView.swift`, `ThreadDetailView.swift`, `MessageView.swift`, `TypingBubble.swift`, `UserInput.swift`.  

- **CoreData Stack**  
  - `DatabaseHandler.swift` sets up an `NSPersistentContainer`.  
  - `.xcdatamodeld` defines `User`, `Thread`, and `Message` entities.  

---
_Built for CSC 680 Final Project_
