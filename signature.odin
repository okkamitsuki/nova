package nova

import "core:sort"
import "core:hash/xxhash"
import "core:mem"

Signature :: struct {
    components_ids: []u32,
    hash: u32,
}

init_signature_from_ids :: proc(components_ids: []u32) -> Signature {
    ids := make([]u32, len(components_ids))
    copy(ids, components_ids)

    sort.quick_sort(ids)

    bytes := mem.slice_to_bytes(ids)
    hash := xxhash.XXH32(bytes)

    return Signature{
        components_ids = ids,
        hash = hash,
    }
}

init_signature_from_components :: proc(components: ..Component) -> Signature {
    ids := make([]u32, len(components))

    for c, i in components {
        ids[i] = c.id
    }

    sort.quick_sort(ids)

    bytes := mem.slice_to_bytes(ids)
    hash := xxhash.XXH32(bytes)

    return Signature{
        components_ids = ids,
        hash = hash,
    }
}