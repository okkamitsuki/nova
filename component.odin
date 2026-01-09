package nova

Component :: struct{
    id: u32,
    size: u32,
}

init_component :: proc(component_id:u32, component_size:u32) -> Component {
    return Component{
        id=component_id,
        size=component_size,
    }
}