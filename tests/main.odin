package main

// DEPRECATE: This is a minimal prototype, It is currently not working.


import "core:sort"
import "core:hash"
import "core:fmt"
import "core:hash/xxhash"

Entity :: struct {
    id: u32,
}

World :: struct {
    entities: [dynamic]Entity,
}

init_world :: proc() -> World {
    return World{
        entities = make([dynamic]Entity),
    }
}

destroy_world :: proc(world: ^World) {
    delete(world.entities)
}

add_entity :: proc(world: ^World, entity: Entity = {}) -> ^Entity {
    entity := entity
    if len(world.entities) > 0 {
        entity.id = world.entities[len(world.entities)-1].id + 1
    } else {
        entity.id = 1
    }
    append(&world.entities, entity)
    return &world.entities[len(world.entities)-1]
}

Test :: struct{
    x: f32
}

main :: proc() {
    world := init_world()
    defer destroy_world(&world)
    
    e1 := add_entity(&world)
    e2 := add_entity(&world)
    e3 := add_entity(&world)
    
    fmt.println("Total entities:", len(world.entities))
    fmt.println("Entity 1:", e1^)
    fmt.println("Entity 2:", e2^)
    fmt.println("Entity 3:", e3^)

    component_registry := nova.init_component_registry()
    
    // Register the Test component type (not an instance)
    test_meta := nova.register_component(Test, &component_registry)
    fmt.println("Registered Test component:")
    fmt.println("  ID:", test_meta.id)
    fmt.println("  Size:", test_meta.size)
    
    // Try registering again to test deduplication
    test_meta2 := nova.register_component(Test, &component_registry)
    fmt.println("Re-registered Test component:")
    fmt.println("  ID:", test_meta2.id)
    fmt.println("  Size:", test_meta2.size)
    
    // Register another component type
    Another :: struct {
        value: int,
        name: string,
    }
    
    another_meta := nova.register_component(Another, &component_registry)
    fmt.println("\nRegistered Another component:")
    fmt.println("  ID:", another_meta.id)
    fmt.println("  Size:", another_meta.size)

    AnotherMoreBig :: struct {
        value: int,
        name: string,
        big: i64,
        big2: i64,
    }

    another_more_big_meta := nova.register_component(AnotherMoreBig, &component_registry)
    fmt.println("\nRegistered Another component:")
    fmt.println("  ID:", another_more_big_meta.id)
    fmt.println("  Size:", another_more_big_meta.size)

    nova.init_signature({Another{0,"a"}})
}