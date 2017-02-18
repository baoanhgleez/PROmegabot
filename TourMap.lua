KantoTour = {
	"Pallet Town",
	"Pokecenter Viridian",
	"Viridian Maze",
	"Pokecenter Pewter",
	"Mt. Moon B2F",
	"Route 25",
	"Pokecenter Cerulean",
	"Power Plant",
	"Pokecenter Route 10",
	"Rock Tunnel 2",
	"Pokecenter Lavender",
	"Route 8",
	"Route 15",
	"Route 18",
	"Pokecenter Celadon",
	"Route 7",
	"Route 6",
	"Digletts Cave",
	"Mt. Silver Exterior",
	"Route 27"
}

JohtoTour = {
	"Pokecenter Cherrygrove City",
	"Violet City",
	"Slowpoke Well L1",
	"Goldenrod City",
	"National Park",
	"Ecruteak City",
	"Mt. Mortar B1F",
	"Route 44",
	"Olivine City",
}

HoennTour = {
	"Lilycove City",
	"Littleroot Town"
}


function mergeMap(t1, t2)
    for key, value in pairs(t2) do
        if not t1[key] then
            t1[key] = value
        elseif type(value) == "table" then
            mergeMap(t1[key], value)
        end
    end
end

