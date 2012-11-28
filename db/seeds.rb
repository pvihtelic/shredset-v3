Brand.destroy_all
Ski.destroy_all
Store.destroy_all
Inventory.destroy_all
Spec.destroy_all
Image.destroy_all
PriceRange.destroy_all



price_ranges = [ 
	{:price_range => '-200'},
	{:price_range => '200-400'},
	{:price_range => '400-600'},
	{:price_range => '600-800'},
	{:price_range => '800-1000'},
	{:price_range => '1000+'},
]

PriceRange.create price_ranges