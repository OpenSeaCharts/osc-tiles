import "./osm.js";

extern dec osmTag(target: unknown, tagName: string | string[]);
extern dec osmSource(target: unknown, sourceName: string[]);

namespace OpenSeaCharts {

enum GeometryType {
    Node: "node",
    Way: "way",
    Area: "area"
}

model Layer {
    @doc("The name of the seamark")
    @osmTag("seamark:name")
    name?: string;
    @doc("The OSM ID of the object")
    id?: int64;
    geometryType: GeometryType[];
}

enum AnchorageCategory {
    deepWater: "deep_water",
    _48Hour: "48_hour",
    explosives: "explosives",
    smallCraft: "small_craft",
    seaplane: "seaplane",
    waiting: "waiting",
    smallCraftMooring: "small_craft_mooring",
    naval: "naval",
    _24Hour: "24_hour",
    commercial: "commercial",
    cargo: "cargo",
    tanker: "tanker",
    quarantine: "quarantine",
    limitedPeriod: "limited_period",
    restricted: "restricted",
    pushing: "pushing",
    unrestricted: "unrestricted"
}

@osmSource(["anchorage"])
@doc("An area where vessels may anchor.")
model Anchorage extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the anchorage.")
    @osmTag("seamark:anchorage:category")
    category?: AnchorageCategory[];
}

enum AnchorBerthCategory {
    deepWater: "deep_water",
    explosives: "explosives",
    smallCraft: "small_craft",
    _24Hour: "24_hour",
    quarantine: "quarantine",
    tanker: "tanker",
    limitedPeriod: "limited_period",
    unrestricted: "unrestricted",
    dryCargo: "dry_cargo"
}

@osmSource(["anchor_berth"])
@doc("A designated area or point for a vessel to anchor.")
model AnchorBerth extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the anchor berth.")
    @osmTag("seamark:anchor_berth:category")
    category?: AnchorBerthCategory[];
    @doc("The radius of the anchor berth in meters.")
    @osmTag("seamark:anchor_berth:radius")
    radius?: float64;
}

@osmSource(["beacon_lateral", "beacon_cardinal", "beacon_isolated_danger", "beacon_safe_water", "beacon_special_purpose", "beacon"])
@doc("A fixed signal, mark, or light erected for the guidance of mariners.")
model Beacon extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The specific category of the beacon.")
    category?: string[];
    @doc("The colour of the beacon.")
    colour?: string[];
    @doc("The pattern of the colours on the beacon.")
    colourPattern?: string[];
    @doc("The physical shape of the beacon.")
    shape?: string[];
    @doc("The function or purpose of the beacon (e.g., lateral, cardinal).")
    function?: string;
}

@osmSource(["berth"])
@doc("A place where a vessel may be moored or secured.")
model Berth extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Way, GeometryType.Area];
    @doc("The minimum depth of water at the berth in meters.")
    @osmTag("seamark:berth:minimum_depth")
    minimumDepth?: float64;
}

enum BridgeCategory {
    footbridge,
    fixed,
    retractable,
    pontoon,
    yes,
    suspension,
    swing,
    lifting,
    bascule,
    disused,
    lift,
    bridge,
    viaduct,
    opening,
    drawbridge
}

@osmSource(["bridge"])
@doc("A structure carrying a road, path, railway, etc. across a river, road, or other obstacle.")
model Bridge extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Way, GeometryType.Area];
    @doc("The type of bridge construction.")
    @osmTag("seamark:bridge:category")
    category?: BridgeCategory[];
    @doc("The vertical clearance under the bridge in meters.")
    @osmTag("seamark:bridge:clearance_height")
    clearanceHeight?: float64;
}

enum BuildingFunction {
    harbourMaster: "harbour_master",
    customs: "customs",
    health: "health",
    hospital: "hospital",
    postOffice: "post_office",
    hotel: "hotel",
    railwayStation: "railway_station",
    policeStation: "police_station",
    waterPoliceStation: "water-police_station",
    pilotOffice: "pilot_office",
    pilotLookout: "pilot_lookout",
    bank: "bank",
    districtControl: "district_control",
    transitShed: "transit_shed",
    factory: "factory",
    powerStation: "power_station",
    administrative: "administrative",
    educational: "educational",
    church: "church",
    chapel: "chapel",
    temple: "temple",
    pagoda: "pagoda",
    shintoShrine: "shinto_shrine",
    buddhistTemple: "buddhist_temple",
    mosque: "mosque",
    marabout: "marabout",
    lookout: "lookout",
    communication: "communication",
    television: "television",
    radio: "radio",
    radar: "radar",
    lightSupport: "light_support",
    microwave: "microwave",
    cooling: "cooling",
    observation: "observation",
    timeBall: "time_ball",
    clock: "clock",
    control: "control",
    airshipMooring: "airship_mooring",
    stadium: "stadium",
    busStation: "bus_station"
}

@osmSource(["building"])
@doc("A building with a specific function related to maritime navigation or administration.")
model Building extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Way, GeometryType.Area];
    @doc("The function or purpose of the building.")
    @osmTag("seamark:building:function")
    function?: BuildingFunction[];
}

enum BunkerStationCategory {
    diesel,
    water,
    ballast
}

@osmSource(["bunker_station"])
@doc("A station where vessels can take on fuel, water, or ballast.")
model BunkerStation extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Way, GeometryType.Area];
    @doc("The type of supplies available at the bunker station.")
    @osmTag("seamark:bunker_station:category")
    category?: BunkerStationCategory[];
}

@osmSource(["buoy_lateral", "buoy_cardinal", "buoy_isolated_danger", "buoy_safe_water", "buoy_special_purpose", "buoy_installation", "buoy"])
@doc("A floating object moored to the bottom to mark a channel, hazard, or for other purposes.")
model Buoy extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The specific category of the buoy.")
    category?: string[];
    @doc("The colour of the buoy.")
    colour?: string[];
    @doc("The pattern of the colours on the buoy.")
    colourPattern?: string[];
    @doc("The physical shape of the buoy.")
    shape?: string[];
    @doc("The function or purpose of the buoy (e.g., lateral, cardinal).")
    function?: string;
}

@osmSource(["cable_area"])
@doc("An area where cables are laid.")
model CableArea extends Layer {
    geometryType: [GeometryType.Area];
}

@osmSource(["cable_overhead"])
@doc("An overhead cable.")
model CableOverhead extends Layer {
    geometryType: [GeometryType.Way];
}

@osmSource(["cable_submarine"])
@doc("A submarine cable.")
model CableSubmarine extends Layer {
    geometryType: [GeometryType.Way];
}

@osmSource(["checkpoint"])
@doc("A place where checks are carried out.")
model Checkpoint extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the checkpoint.")
    @osmTag("seamark:checkpoint:category")
    category?: string[];
}

@osmSource(["coastguard_station"])
@doc("A station for the coastguard.")
model CoastguardStation extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
}

@osmSource(["crane"])
@doc("A machine for lifting heavy objects.")
model Crane extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the crane.")
    @osmTag("seamark:crane:category")
    category?: string[];
}

@osmSource(["daymark"])
@doc("A daytime mark.")
model Daymark extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the daymark.")
    @osmTag("seamark:daymark:category")
    category?: string[];
}

@osmSource(["distance_mark"])
@doc("A mark indicating distance.")
model DistanceMark extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the distance mark.")
    @osmTag("seamark:distance_mark:category")
    category?: string[];
    @doc("The distance indicated by the mark.")
    @osmTag("seamark:distance_mark:distance")
    distance?: float64;
    @doc("The units of the distance.")
    @osmTag("seamark:distance_mark:units")
    units?: string;
}

@osmSource(["dredged_area", "dumping_ground"])
@doc("An area of the sea.")
model SeaArea extends Layer {
    geometryType: [GeometryType.Area];
}

@osmSource(["fairway"])
@doc("A navigable channel.")
model Fairway extends Layer {
    geometryType: [GeometryType.Area, GeometryType.Way];
    @doc("Restrictions applying to the fairway.")
    @osmTag("seamark:fairway:restriction")
    restriction?: string[];
}

@osmSource(["ferry_route"])
@doc("A route for ferries.")
model FerryRoute extends Layer {
    geometryType: [GeometryType.Way];
    @doc("The category of the ferry route.")
    @osmTag("seamark:ferry_route:category")
    category?: string[];
}

@osmSource(["wall"])
@doc("A wall.")
model Wall extends Layer {
    geometryType: [GeometryType.Way];
    @doc("The category of the wall.")
    @osmTag("seamark:wall:category")
    category?: string[];
}

@osmSource(["fog_signal"])
@doc("A signal used in fog.")
model FogSignal extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the fog signal.")
    @osmTag("seamark:fog_signal:category")
    category?: string[];
    @doc("The frequency of the signal.")
    @osmTag("seamark:fog_signal:frequency")
    frequency?: float64;
    @doc("The generation method of the signal.")
    @osmTag("seamark:fog_signal:generation")
    generation?: string;
    @doc("The group of the signal.")
    @osmTag("seamark:fog_signal:group")
    group?: string;
    @doc("The period of the signal.")
    @osmTag("seamark:fog_signal:period")
    period?: float64;
    @doc("The range of the signal.")
    @osmTag("seamark:fog_signal:range")
    range?: float64;
    @doc("The sequence of the signal.")
    @osmTag("seamark:fog_signal:sequence")
    sequence?: string;
}

@osmSource(["fortified_structure"])
@doc("A fortified structure.")
model FortifiedStructure extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the fortified structure.")
    @osmTag("seamark:fortified_structure:category")
    category?: string[];
}

@osmSource(["fishing_facility"])
@doc("A facility for fishing.")
model FishingFacility extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the fishing facility.")
    @osmTag("seamark:fishing_facility:category")
    category?: string[];
}

@osmSource(["gate"])
@doc("A gate.")
model Gate extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Way, GeometryType.Area];
    @doc("The category of the gate.")
    @osmTag("seamark:gate:category")
    category?: string[];
}

@osmSource(["gridiron"])
@doc("A gridiron.")
model Gridiron extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The water level at the gridiron.")
    @osmTag("seamark:gridiron:water_level")
    waterLevel?: string;
}

@osmSource(["harbour_basin"])
@doc("A harbour basin.")
model HarbourBasin extends Layer {
    geometryType: [GeometryType.Area];
}

@osmSource(["harbour"])
@doc("A harbour.")
model Harbour extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the harbour.")
    @osmTag("seamark:harbour:category")
    category?: string[];
}

@osmSource(["hulk"])
@doc("A hulk.")
model Hulk extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the hulk.")
    @osmTag("seamark:hulk:category")
    category?: string[];
}

@osmSource(["landmark"])
@doc("A prominent object used for navigation.")
model Landmark extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the landmark.")
    @osmTag("seamark:landmark:category")
    category?: string[];
    @doc("The colour of the landmark.")
    @osmTag("seamark:landmark:colour")
    colour?: string[];
    @doc("The colour pattern of the landmark.")
    @osmTag("seamark:landmark:colour_pattern")
    colourPattern?: string[];
    @doc("The function of the landmark.")
    @osmTag("seamark:landmark:function")
    function?: string;
}

@osmSource(["light"])
@doc("A light source.")
model Light extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the light.")
    @osmTag("seamark:light:category")
    category?: string[];
    @doc("The colour of the light.")
    @osmTag("seamark:light:colour")
    colour?: string[];
}

@osmSource(["light_major"])
@doc("A major light.")
model LightMajor extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the major light.")
    @osmTag("seamark:light_major:category")
    category?: string[];
    @doc("The character of the major light.")
    @osmTag("seamark:light_major:character")
    character?: string;
}

@osmSource(["light_minor"])
@doc("A minor light.")
model LightMinor extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the minor light.")
    @osmTag("seamark:light_minor:category")
    category?: string[];
    @doc("The character of the minor light.")
    @osmTag("seamark:light_minor:character")
    character?: string;
}

@osmSource(["light_float"])
@doc("A light float.")
model LightFloat extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The colour of the light float.")
    @osmTag("seamark:light_float:colour")
    colour?: string[];
    @doc("The colour pattern of the light float.")
    @osmTag("seamark:light_float:colour_pattern")
    colourPattern?: string[];
}

@osmSource(["light_vessel"])
@doc("A light vessel.")
model LightVessel extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The colour of the light vessel.")
    @osmTag("seamark:light_vessel:colour")
    colour?: string[];
    @doc("The colour pattern of the light vessel.")
    @osmTag("seamark:light_vessel:colour_pattern")
    colourPattern?: string[];
}

@osmSource(["marine_farm"])
@doc("A marine farm.")
model MarineFarm extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the marine farm.")
    @osmTag("seamark:marine_farm:category")
    category?: string[];
}

@osmSource(["mooring"])
@doc("A mooring.")
model Mooring extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the mooring.")
    @osmTag("seamark:mooring:category")
    category?: string[];
    @doc("The colour of the mooring.")
    @osmTag("seamark:mooring:colour")
    colour?: string[];
    @doc("The colour pattern of the mooring.")
    @osmTag("seamark:mooring:colour_pattern")
    colourPattern?: string[];
}

@osmSource(["navigation_line"])
@doc("A navigation line.")
model NavigationLine extends Layer {
    geometryType: [GeometryType.Way];
    @doc("The category of the navigation line.")
    @osmTag("seamark:navigation_line:category")
    category?: string[];
    @doc("The orientation of the navigation line.")
    @osmTag("seamark:navigation_line:orientation")
    orientation?: float64;
}

@osmSource(["notice"])
@doc("A notice.")
model Notice extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the notice.")
    @osmTag("seamark:notice:category")
    category?: string[];
}

@osmSource(["obstruction"])
@doc("An obstruction.")
model Obstruction extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the obstruction.")
    @osmTag("seamark:obstruction:category")
    category?: string[];
}

@osmSource(["platform"])
@doc("A platform.")
model Platform extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the platform.")
    @osmTag("seamark:platform:category")
    category?: string[];
}

@osmSource(["production_area"])
@doc("A production area.")
model ProductionArea extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The category of the production area.")
    @osmTag("seamark:production_area:category")
    category?: string[];
}

@osmSource(["pilot_boarding"])
@doc("A pilot boarding place.")
model PilotBoarding extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the pilot boarding place.")
    @osmTag("seamark:pilot_boarding:category")
    category?: string[];
    @doc("The channel of the pilot boarding place.")
    @osmTag("seamark:pilot_boarding:channel")
    channel?: string;
}

@osmSource(["pile"])
@doc("A pile.")
model Pile extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the pile.")
    @osmTag("seamark:pile:category")
    category?: string[];
}

@osmSource(["radar_reflector"])
@doc("A radar reflector.")
model RadarReflector extends Layer {
    geometryType: [GeometryType.Node];
}

@osmSource(["recommended_track"])
@doc("A recommended track.")
model RecommendedTrack extends Layer {
    geometryType: [GeometryType.Way];
    @doc("The orientation of the recommended track.")
    @osmTag("seamark:recommended_track:orientation")
    orientation?: float64;
}

@osmSource(["rescue_station"])
@doc("A rescue station.")
model RescueStation extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the rescue station.")
    @osmTag("seamark:rescue_station:category")
    category?: string[];
}

@osmSource(["restricted_area"])
@doc("A restricted area.")
model RestrictedArea extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The category of the restricted area.")
    @osmTag("seamark:restricted_area:category")
    category?: string[];
    @doc("The restriction of the restricted area.")
    @osmTag("seamark:restricted_area:restriction")
    restriction?: string[];
}

@osmSource(["seaplane_landing_area"])
@doc("A seaplane landing area.")
model SeaplaneLandingArea extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The restriction of the seaplane landing area.")
    @osmTag("seamark:seaplane_landing_area:restriction")
    restriction?: string[];
}

@osmSource(["signal_station_warning", "signal_station_traffic"])
@doc("A signal station.")
model SignalStation extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The category of the signal station.")
    category?: string[];
    @doc("The channel of the signal station.")
    channel?: string;
}

@osmSource(["small_craft_facility"])
@doc("A facility for small craft.")
model SmallCraftFacility extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the small craft facility.")
    @osmTag("seamark:small_craft_facility:category")
    category?: string[];
}

@osmSource(["spring"])
@doc("A spring.")
model Spring extends Layer {
    geometryType: [GeometryType.Node];
}

@osmSource(["topmark"])
@doc("A topmark.")
model Topmark extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The colour of the topmark.")
    @osmTag("seamark:topmark:colour")
    colour?: string[];
    @doc("The colour pattern of the topmark.")
    @osmTag("seamark:topmark:colour_pattern")
    colourPattern?: string[];
    @doc("The shape of the topmark.")
    @osmTag("seamark:topmark:shape")
    shape?: string[];
}

@osmSource(["separation_lane"])
@doc("A separation lane.")
model SeparationLane extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The category of the separation lane.")
    @osmTag("seamark:separation_lane:category")
    category?: string[];
    @doc("The restriction of the separation lane.")
    @osmTag("seamark:separation_lane:restriction")
    restriction?: string[];
}

@osmSource(["separation_line"])
@doc("A separation line.")
model SeparationLine extends Layer {
    geometryType: [GeometryType.Way];
    @doc("The category of the separation line.")
    @osmTag("seamark:separation_line:category")
    category?: string[];
    @doc("The orientation of the separation line.")
    @osmTag("seamark:separation_line:orientation")
    orientation?: float64;
    @doc("The restriction of the separation line.")
    @osmTag("seamark:separation_line:restriction")
    restriction?: string[];
}

@osmSource(["separation_roundabout"])
@doc("A separation roundabout.")
model SeparationRoundabout extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The category of the separation roundabout.")
    @osmTag("seamark:separation_roundabout:category")
    category?: string[];
    @doc("The restriction of the separation roundabout.")
    @osmTag("seamark:separation_roundabout:restriction")
    restriction?: string[];
}

@osmSource(["separation_zone"])
@doc("A separation zone.")
model SeparationZone extends Layer {
    geometryType: [GeometryType.Area];
    @doc("The category of the separation zone.")
    @osmTag("seamark:separation_zone:category")
    category?: string[];
    @doc("The restriction of the separation zone.")
    @osmTag("seamark:separation_zone:restriction")
    restriction?: string[];
}

enum WaterLevel {
    partSubmerged: "part-submerged",
    belowSurface: "below_surface",
    alwaysDry: "always_dry",
    dry: "dry",
    awash: "awash",
    r: "r",
    covers: "covers",
    aboveMwl: "above_mwl",
    belowMwl: "below_mwl",
    submerged: "submerged"
}

@osmSource(["rock"])
@doc("A rock.")
model Rock extends Layer {
    geometryType: [GeometryType.Node];
    @doc("The water level of the rock.")
    @osmTag("seamark:rock:water_level")
    waterLevel?: WaterLevel;
}

@osmSource(["wreck"])
@doc("A wreck.")
model Wreck extends Layer {
    geometryType: [GeometryType.Node, GeometryType.Area];
    @doc("The category of the wreck.")
    @osmTag("seamark:wreck:category")
    category?: string[];
}

}