---@meta
---@diagnostic disable

-- `unit_number` for entity
---@alias unit_number uint
---@alias uid unit_number

-- `uid` alias used in composite entity cloning which stands for `unit_number` of old main entity
---@alias old_main_uid uid

---< Global >---

--<`Key`: old main uid, `Value`: event.tick>
---@alias PhTimestampList table<uid, uint>

---@class PhCache
---@field entity LuaEntity|false
---@field highest? LuaEntity|false
---@field highest_count? LuaEntity|false
---@field highest_present? LuaEntity|false
---@field signal_present? LuaEntity|false

--Table: <`Key`: old main uid, `Value`: cache ph table>
---@alias PhCacheList {count:integer} | table<old_main_uid, PhCache>

---@class PhCombinator
---@field entity LuaEntity|false
---@field module_chest? LuaEntity|false
---@field output_proxy? LuaEntity|false

--Table: <`Key`: old main uid, `Value`: combinator ph table>
---@alias PhCombinatorList {count:integer} | table<old_main_uid, PhCombinator>

---@class GlobalClonePh
---@field combinator PhCombinatorList
---@field cache PhCacheList
---@field timestamp PhTimestampList

---@class CcLatchQueue
---@field state table<uint, CcState[]>
---@field assembler table<uint, LuaEntity[]>
---@field container table<uint, LuaEntity[]>

---@alias GlobalCcData table<uid, CcState>
---@alias GlobalCcOrdered CcState[]
---@alias InserterEmptyQueue table<uint, CcState[]> #<`Key`: event.tick, `Value`: Array of CcState>

---@class GlobalCc
---@field data GlobalCcData
---@field ordered GlobalCcOrdered
---@field inserter_empty_queue InserterEmptyQueue
---@field latch_queue CcLatchQueue
---@field queue_count uint

---@alias GlobalRcData table<uid, RcState>
---@alias GlobalRcOrdered RcState[]

---@class GlobalRc
---@field data GlobalRcData
---@field ordered GlobalRcOrdered

---<`Key`: main uid, `Value`: SignalsCacheState>
---@alias GlobalSignalsCache table<uid, SignalsCacheState>

---<`Key`: part uid, `Value`: main uid>
---@alias main_uid_by_part_uid table<uid, uid>

---@class CraftingCombinatorTagData
---@field settings CcSettings|RcSettings

---`Key`: string of <entity.position.x>.."|"..<entity.position.y>
---@alias DelayedBlueprintTagsDictionary {[string]: {key: "crafting_combinator_data", tag_data: CraftingCombinatorTagData}}

---@class PlayerDelayedBlueprintTagsState
---@field is_queued boolean
---@field data DelayedBlueprintTagsDictionary

---@alias GlobalDelayedBlueprintTags {[PlayerIdentification]: PlayerDelayedBlueprintTagsState}

---Global table for this mod
---@class CraftingCombinatorGlobal
---@field delayed_blueprint_tag_state GlobalDelayedBlueprintTags
---@field cc GlobalCc
---@field rc GlobalRc
---@field signals {cache: GlobalSignalsCache}
---@field clone_placeholder GlobalClonePh
---@field main_uid_by_part_uid main_uid_by_part_uid

---@type CraftingCombinatorGlobal
__crafting_combinator_xeraph__global = nil
---@type CraftingCombinatorGlobal
__crafting_combinator_xeraph_test__global = nil

-- CC State

---@class AssemblerInventories
---@field input LuaInventory?
---@field output LuaInventory?

---@class CcInventories
---@field module_chest LuaInventory?
---@field chest LuaInventory?
---@field assembler AssemblerInventories

---@class CcSettings
---@field chest_position integer
---@field mode "w"|"r"
---@field wait_for_output_to_clear boolean
---@field discard_items boolean
---@field discard_fluids boolean
---@field empty_inserters boolean
---@field read_recipe boolean
---@field read_speed boolean
---@field read_machine_status boolean
---@field craft_until_zero boolean
---@field craft_n_before_switch integer
---@field input_buffer_size integer

---@class CcState:CcControl
---@field entityUID uid Combinator entity's uid
---@field entity LuaEntity Combinator entity
---@field control_behavior LuaControlBehavior? Combinator's control behavior
---@field module_chest LuaEntity Module chest entity associated to this CC
---@field assembler LuaEntity Assembler entity associated to this CC
---@field settings CcSettings CC settings table
---@field inventories CcInventories
---@field items_to_ignore table #?? not sure what's the purpose
---@field last_flying_text_tick integer
---@field enabled boolean
---@field last_recipe LuaRecipe?
---@field last_assembler_recipe LuaRecipe?
---@field read_mode_cb boolean
---@field sticky boolean
---@field allow_sticky boolean
---@field unstick_at_tick integer

-- RC State

---@alias RcMode
---| 'ing' Find ingredients
---| 'mac' Find machines
---| 'prod' Find products
---| 'rec' Find recipe
---| 'use' Find uses

---@class RcSettings
---@field mode RcMode,
---@field multiply_by_input boolean
---@field divide_by_output boolean
---@field differ_output boolean
---@field time_multiplier number

---@class RcState:RcControl
---Combinator entity's uid
---@field entityUID uid
---Combinator LuaEntity
---@field entity LuaEntity
---@field output_proxy LuaEntity
---Output proxy's control behavior
---@field control_behavior LuaControlBehavior
---Combinator's control behavior
---@field input_control_behavior LuaControlBehavior
---@field settings RcSettings
---@field last_signal? SignalID
---@field last_name? string
---@field last_count integer

-- Signals Cache

---@class CacheEntities
---@field highest LuaEntity
---@field highest_present LuaEntity
---@field highest_count LuaEntity
---@field signal_present LuaEntity

---@class CacheCb
---@field __cb LuaLampControlBehavior
---@field valid boolean
---@field value CacheValue

---@class CacheValue
---@field signal SignalID

---@class SignalsCacheState
---@field __entity LuaEntity
---@field __circuit_id defines.circuit_connector_id
---@field __cache_entities CacheEntities
---@field highest CacheCb
---@field highest_present CacheCb
---@field highest_count CacheCb
---@field signal_present CacheCb


--- TEST