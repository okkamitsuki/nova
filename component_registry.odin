package nova

ComponentRegistry :: struct {
    registry: map[typeid]Component,  
    size: u32,
}

init_component_registry :: proc() -> ComponentRegistry {
    return ComponentRegistry{   
        registry = make(map[typeid]Component),
        size = 0,
    }
}

delete_component_registry :: proc(component_registry: ^ComponentRegistry) {
    delete(component_registry.registry)
}

register_component :: proc($T: typeid, component_registry: ^ComponentRegistry) -> Component {
    if meta, ok := component_registry.registry[T]; ok {
        return &meta
    }

    size := u32(size_of(T))
    meta := init_component(component_registry.size, size)

    component_registry.registry[T] = meta
    component_registry.size += 1

    return meta
}
