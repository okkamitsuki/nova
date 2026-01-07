
---

# NOVA  
**A lightweight, pure ECS library written in [Odin](https://odin-lang.org/)**

> ⚠️ **Status: Early Development / Experimental**  
> NOVA is under heavy development and **not ready for production or testing yet**.

---

## Overview

**NOVA** is a **pure Entity Component System (ECS)** library designed from the ground up to be:

- ⚡ **Fast** — data-oriented, cache-friendly, and minimal overhead  
- 🪶 **Lightweight** — no unnecessary abstractions or engine-level features  
- 🧠 **Simple** — easy to reason about, explicit behavior, predictable costs  

The long-term goal of NOVA is to serve as a **high-performance ECS foundation** suitable for modern game engines and real-time systems.

---

## Design Goals

- **Pure ECS**
  - Entities are simple identifiers
  - Components are plain data (POD structs)
  - Behavior lives outside of data

- **Minimal Core**
  - Only essential ECS concepts live in the core
  - No rendering, physics, scripting, or engine-specific logic

- **Data-Oriented**
  - Designed with cache locality and memory layout in mind
  - Intended for archetype-based storage

- **Explicit > Implicit**
  - No hidden allocations
  - No magic reflection systems
  - Clear control over data and execution

---

## Current State

At the moment, NOVA only contains **foundational building blocks**:

### ✔ Implemented
- Entity structure (ID + version)
- Component metadata
- Component registry (type → component info)
- Signatures (sorted component IDs + hashed)
- Deterministic archetype signatures using `xxHash`

### ❌ Not Implemented Yet
- Archetype storage
- Entity creation/destruction
- Component storage/layout
- Systems
- Queries / views
- Scheduler
- Multithreading
- Events

---

## Core Concepts

### Entity

```odin
Entity :: struct {
    id: u32,
    version: u32,
}
```

Entities are lightweight handles with no behavior or data attached directly.

---

### Component Metadata

```odin
Component :: struct {
    id:   u32,
    size: u32,
}
```

Components are registered globally and assigned a unique ID and size.
Only **metadata** exists at this level — actual storage will be handled by archetypes.

---

### Component Registry

```odin
ComponentRegistry :: struct {
    registry: map[typeid]Component,
    size:     u32,
}
```

The registry maps Odin `typeid`s to component metadata, ensuring:

* Stable IDs
* No duplicate registrations
* Fast lookup

---

### Signatures

Signatures uniquely identify a set of components and are used to define archetypes.

```odin
Signature :: struct {
    components_ids: []u32,
    hash:           u32,
}
```

* Component IDs are sorted for determinism
* Hashing is done using `xxHash` for performance
* Designed for fast archetype lookup and comparison

---

## Intended Architecture (Planned)

```
Entity
   ↓
Signature (set of component IDs)
   ↓
Archetype
   ↓
SoA Component Storage
   ↓
Systems operating on archetypes
```

---

## Why Odin?

NOVA is written in **Odin** because it provides:

* Excellent performance characteristics
* Explicit memory control
* Strong data-oriented philosophy
* No hidden runtime or GC
* Clean and readable syntax for systems programming

---

## Target Use Cases

* High-performance game engines
* Simulation systems
* Real-time tools

---

## Non-Goals

NOVA will **not** attempt to be:

* A full game engine
* A Unity/Bevy clone
* Opinionated about rendering, physics, or scripting

Those belong **outside** the ECS core.

---

## Project Status

🚧 **Work in Progress**
The API is unstable and subject to change.

---

## License

BSD-2-Clause

---

