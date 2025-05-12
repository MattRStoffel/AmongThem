# AmongThem

_A SwiftUI chat “game” with AI personas, powered by Ollama 3.2._

---

## Contributors

1. [@MattRStoffel](https://github.com/MattRStoffel) - Matt Stoffel
2. [@MaKoabra](https://github.com/MaKoabra)         - Steven 
3. [@adixsharma](https://github.com/adixsharma)     - Aditya Sharma
4. [@natdav231](https://github.com/natdav231)       - Nathan Gabriel David

---

## Project Proposal

### Overview

"AmongThem" is an engaging chat-based application allowing users to interact with multiple specialized AI personas. It features seamless and interactive chat threads powered by Ollama 3.2, providing real-time, streaming responses for an enhanced conversational experience.

### Target Audience

* Age: 18-65
* All genders
* All education levels
* Interests: Technology, Fitness, Health, Cooking, Gaming

---

## Must-Have Features

* **Multiple Threads Management**

  * Create, rename, and delete conversations with different AI personas and Overall Project structure of files.
  * Estimated time: 12 hours (Owner: Matt Stoffel)

* **AI Chat via Ollama 3.2**

  * Implement real-time token-by-token streaming responses.
  * Estimated time: 5 hours (Owner: Aditya Sharma and Matt Stoffel)

* **Typing Indicator**

  * Visual feedback while waiting for AI responses.
  * Estimated time: 2 hours (Owner: Aditya Sharma)

* **Auto-Scroll Functionality**

  * Auto-scroll to latest messages or ongoing typing indicators.
  * Estimated time: 3 hours (Owner: Aditya Sharma)

* **CoreData Persistence**

  * Persist user threads and messages locally, accessible offline.
  * Estimated time: 8 hours (Owner: Steven Brandt)

* **User-Friendly UI & Character Personas**

  * Intuitive and responsive UI designed using SwiftUI.
  * Estimated time: 8 hours (Owner: Nathan Gabriel David)

---

## Nice-to-Have Features

* **Concise Mode**

  * Option to enable shorter, more concise AI responses.
  * Estimated time: 3 hours

---
## 🛠 Wireframe Storyboard

![Wireframe Storyboard](https://i.imgur.com/abPgspe.png)

---

## 🚀 Features

- **Multiple Threads**  
  Create, rename, and delete separate conversations (“threads”) with different AI personas.  
- **AI Chat via Ollama 3.2**  
  Streaming responses from local Ollama 3.2 models for ultra‑fast, privacy‑preserving chat.  
- **Typing Indicator**  
  “…is typing” bubble shows before each AI reply to keep the user informed mitigate exiting for the response delay.  
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
