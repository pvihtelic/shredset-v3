PriceRange.destroy_all

price_ranges = [ 
	{:price_range => '<$200', :low => 0, :high => 200},
	{:price_range => '$200-400', :low => 200, :high => 400},
	{:price_range => '$400-600', :low => 400, :high => 600},
	{:price_range => '$600-800', :low => 600, :high => 800},
	{:price_range => '$800-1,000', :low => 800, :high => 1000 },
	{:price_range => '$1,000+', :low => 1000, :high => 9999}
]

PriceRange.create price_ranges